import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lamp/app/models/report_model.dart';
import 'package:lamp/app/providers/provider_helper.dart';
import 'package:lamp/app/providers/report_provider/report_provider.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/common_widgets/text_field/TextFieldType.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../theme/color_helper.dart';

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

  Future<void> _getInitialData() async {
    await context.read<ReportProvider>().getUserPurchaseReports();
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
      titleWidget: SizedBox(width: MediaQuery.of(context).size.width / 2.1, child: Image.asset('assets/lamp_izvjestaji.png')),
      centerTitle: true,
      onLeadingPressed: null,
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        _buildSearchWidget(context),
        context.watch<ReportProvider>().showFilter
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _filterWidget(context),
              )
            : const SizedBox(),
        _buildList(context),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
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
            report.transactionPointsAmount.toStringAsFixed(0));
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
            child: Icon(Icons.tune, size: 28, color: ColorHelper.lampGray.color)),
        textAlign: TextAlign.start,
        prefixIcon: Icon(Icons.search, size: 28, color: ColorHelper.lampGray.color),
      ),
    );
  }

  Widget _filterWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color), borderRadius: BorderRadius.circular(11)),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Text('Filtriraj prema datumu', style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGray.color)),
          const SizedBox(height: 20),
          _buildFromDateWidget(context),
          _buildToDateWidget(context),
          const SizedBox(height: 10),
          _buildFilterButton(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, {bool isFrom = false}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: ColorHelper.lampGreen.color,
              colorScheme: ColorScheme.light(primary: ColorHelper.lampGreen.color),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        if (isFrom) {
          context.read<ReportProvider>().fromController.text = DateFormat("dd.MM.yyyy").format(selectedDate);
        } else {
          context.read<ReportProvider>().toController.text = DateFormat("dd.MM.yyyy").format(selectedDate);
        }
      });
    }
  }

  Widget _buildFromDateWidget(BuildContext context) {
    return Lamp_TextFormField(
      controller: context.watch<ReportProvider>().fromController,
      textAlign: TextAlign.start,
      readOnly: true,
      icon: GestureDetector(
          onTap: () => _selectDate(context, isFrom: true), child: Icon(Icons.calendar_today_rounded, size: 28, color: ColorHelper.lampGray.color)),
      label: 'Od',
      hintText: '',
    );
  }

  Widget _buildToDateWidget(BuildContext context) {
    return Lamp_TextFormField(
      controller: context.watch<ReportProvider>().toController,
      textAlign: TextAlign.start,
      readOnly: true,
      icon:
          GestureDetector(onTap: () => _selectDate(context), child: Icon(Icons.calendar_today_rounded, size: 28, color: ColorHelper.lampGray.color)),
      label: 'Do',
      hintText: '',
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return SizedBox(
        width: 150,
        child: Lamp_Button(
            onPressed: () {
              context.read<ReportProvider>().searchByDate();
            },
            buttonTitle: 'Potvrdi'));
  }

  Widget _reportWidget(BuildContext context, String title, String merchantName, String desc, String date, String transactionPoint) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Card(
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color.withOpacity(0.5)), borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Text(merchantName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGray.color, fontSize: 17))),
                  Expanded(
                    child: Container(
                      width: 100,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(transactionPoint.contains('-') ? '$transactionPoint b' : '+$transactionPoint b',
                            style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGreen.color, fontSize: 22)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('$date ',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: ColorHelper.lampGray.color, fontWeight: FontWeight.w300, fontSize: 17)),
                  Text('u iznosu od $desc KM',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: ColorHelper.lampGray.color, fontWeight: FontWeight.w300, fontSize: 17)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
