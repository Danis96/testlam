import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lamp/app/models/report_model.dart';
import 'package:lamp/app/providers/provider_helper.dart';
import 'package:lamp/app/providers/report_provider/report_provider.dart';
import 'package:lamp/app/utils/int_extension.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/text_field/TextFieldType.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../theme/color_helper.dart';
import '../../utils/string_texts.dart';

class IzvjestajiPage extends StatefulWidget {
  const IzvjestajiPage({Key? key}) : super(key: key);

  @override
  State<IzvjestajiPage> createState() => _IzvjestajiPageState();
}

class _IzvjestajiPageState extends State<IzvjestajiPage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Lamp_LoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  Future<void> _getInitialData({bool isSelected = false}) async {
    await context.read<ReportProvider>().getUserPurchaseReports(isSelected: isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarIzvjestaj(context),
      body: SafeArea(child: _buildBody(context)),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSizeWidget _appBarIzvjestaj(BuildContext context) {
    return Lamp_AppBarIconTitleIcon(
      context,
      onActionPressed: null,
      implyAction: false,
      implyLeading: false,
      titleWidget: SizedBox(width: MediaQuery.of(context).size.width / 1.7, child: Image.asset('assets/lamp_izvjestaji.png')),
      centerTitle: true,
      onLeadingPressed: null,
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _buildSearchWidget(context),
        const SizedBox(height: 22),
        context.watch<ReportProvider>().showFilter
            ? Column(
                children: <Widget>[
                  _filterWidget(context),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 12),
        _buildList(context),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return context.watch<ReportProvider>().showEmpty
        ? _emptyState(context)
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: context.watch<ReportProvider>().searchList.isNotEmpty
                ? context.watch<ReportProvider>().searchList.length
                : context.watch<ReportProvider>().reports.length,
            itemBuilder: (BuildContext context, int index) {
              final ReportModel report = context.watch<ReportProvider>().searchList.isNotEmpty
                  ? context.read<ReportProvider>().searchList[index]
                  : context.read<ReportProvider>().reports[index];
              return _reportWidget(
                  context,
                  // ProviderHelper().returnAdditionalInfoForReport(report.additionalInfo),
                  '',
                  report.merchantName,
                  report.salesAmount.toStringAsFixed(2),
                  DateFormat("dd.MM.yyyy").format(DateTime.parse(report.purchaseDate)),
                  report.transactionPointsAmount);
            },
          );
  }

  Widget _buildSearchWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Lamp_TextFormField(
        controller: context.read<ReportProvider>().searchController,
        onChange: () {
          context.read<ReportProvider>().searchByName();
        },
        hintText: 'Pretraži',
        icon: GestureDetector(
            onTap: () => context.read<ReportProvider>().setShowFilter(!context.read<ReportProvider>().showFilter),
            child: Image.asset(
              'assets/ic_tune.png',
              scale: 1.5,
              color: ColorHelper.lampGray.color,
            )),
        textAlign: TextAlign.start,
        prefixIcon: Icon(Icons.search, size: 24, color: ColorHelper.lampGray.color),
      ),
    );
  }

  Widget _filterWidget(BuildContext context) {
    return Container(
      height: 35,
      width: 155,
      decoration: BoxDecoration(
        border: Border.all(color: ColorHelper.lampLightGray.color),
        borderRadius: BorderRadius.circular(11),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.17),
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Text(
                context.watch<ReportProvider>().fromController.text.isEmpty
                    ? '${DateFormat("MM.").format(DateTime.now())} mjesec ${DateFormat("yyyy.").format(DateTime.now())}'
                    : context.read<ReportProvider>().fromController.text,
                style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGray.color, fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Lamp_LoaderCircleWhite(context: context);
              context.read<ReportProvider>().resetFilter();
              _getInitialData().then((value) => Navigator.of(context).pop());
            },
            child: Image.asset(
              'assets/ic_x.png',
              scale: 2,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.year,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorHelper.lampGreen.color,
              colorScheme: ColorScheme.light(primary: ColorHelper.lampGreen.color, secondary: ColorHelper.lampGreen.color),
              hoverColor: ColorHelper.lampGreen.color,
            ),
            child: child!,
          );
        },
        firstDate: DateTime(2010, 8),
        lastDate: DateTime(2151));
    if (picked != null && picked != selectedDate) {
      setState(() {
        Lamp_LoaderCircleWhite(context: context);
        selectedDate = picked;
        context.read<ReportProvider>().fromController.text =
            '${DateFormat("MM.").format(selectedDate)} mjesec ${DateFormat("yyyy.").format(selectedDate)}';
        context.read<ReportProvider>().toController.text = DateFormat("dd.MM.yyyy").format(selectedDate);
        _getInitialData(isSelected: true).then((value) => Navigator.of(context).pop());
      });
    }
  }

  Widget _reportWidget(BuildContext context, String title, String merchantName, String desc, String date, int transactionPoint) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.17),
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color.withOpacity(0.5)), borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(merchantName,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: ColorHelper.lampGray.color, fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('$date. iznos $desc KM',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: ColorHelper.lampGray.color, fontSize: 16, fontWeight: FontWeight.w400))
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        transactionPoint.toStringAsFixed(0).contains('-')
                            ? '${transactionPoint.toStringAsFixed(0)}'
                            : '${transactionPoint.toStringAsFixed(0).replaceAll('-', '+')}',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: transactionPoint.toStringAsFixed(0).contains('-') ? ColorHelper.lampRed.color : ColorHelper.lampGreen.color,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${transactionPoint.returnPoints()}',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: ColorHelper.lampGray.color,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _emptyState(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height / 1.6,
    child: Center(child: Text(prodajna_mjesta_empty, style: Theme.of(context).textTheme.headline3)),
  );
}
