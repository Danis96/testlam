import 'package:flutter/material.dart';
import 'package:lamp/app/models/sales_merchant_model.dart';
import 'package:lamp/app/providers/sales_location_provider/sales_location_provider.dart';
import 'package:lamp/app/utils/int_extension.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../theme/color_helper.dart';
import '../../models/sales_merchant_address_model.dart';
import '../../utils/string_texts.dart';

class ProdajnaMjestaDetaljiPage extends StatefulWidget {
  const ProdajnaMjestaDetaljiPage({Key? key}) : super(key: key);

  @override
  State<ProdajnaMjestaDetaljiPage> createState() => _ProdajnaMjestaDetaljiPageState();
}

class _ProdajnaMjestaDetaljiPageState extends State<ProdajnaMjestaDetaljiPage> {
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
    await context.read<SalesLocationProvider>().getMerchantAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return Lamp_AppBarIconTitleIcon(
    context,
    onActionPressed: null,
    implyAction: false,
    onLeadingPressed: () => Navigator.of(context).pop(),
    titleWidget: SizedBox(width: MediaQuery.of(context).size.width / 1.6, child: Image.asset('assets/lamp_prodajna_mjesta.png')),
    centerTitle: false,
    leadingIcon: Icons.arrow_back_ios_new,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  final SalesMerchant salesMerchant = context.watch<SalesLocationProvider>().selectedMerchant;
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    shrinkWrap: true,
    children: <Widget>[
      _buildProdajnaMjestaWidget(context, salesMerchant.image, salesMerchant.merchantName, salesMerchant.moneyOnLowLoyalty.toInt(),
          salesMerchant.moneyOnFullLoyalty.toInt(), salesMerchant.moneyToFullLoyalty.toInt()),
      const SizedBox(height: 20),
      _buildAddressWidget(context),
    ],
  );
}

Widget _buildProdajnaMjestaWidget(BuildContext context, String img, String title, int startPoints, int endPoints, int price) {
  return Container(
    margin: const EdgeInsets.only(top: 25),
    decoration: BoxDecoration(
      border: Border.all(color: ColorHelper.lampLightGray.color),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.17),
          blurRadius: 4,
          blurStyle: BlurStyle.outer,
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        const SizedBox(height: 10),
        img.isNotEmpty
            ? Image.network(
                img,
                width: 200,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(11),
                          topLeft: Radius.circular(11),
                        ),
                      ),
                      child: Image.asset('assets/lampica_logo.png', fit: BoxFit.contain, height: 50),
                    ),
                  );
                },
              )
            : Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(11),
                      topLeft: Radius.circular(11),
                    ),
                  ),
                  child: Image.asset('assets/lampica_logo.png', fit: BoxFit.contain, height: 50),
                ),
              ),
        Text(title, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        _buildFooter(context, startPoints, endPoints, price),
      ],
    ),
  );
}

Widget _buildFooter(BuildContext context, int start, int end, int price) {
  return Container(
    height: 30,
    decoration: BoxDecoration(
      color: ColorHelper.lampGreen.color,
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(11), bottomRight: Radius.circular(11)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Image.asset('assets/lamp_small_logo.png', width: 20),
              Text('$start ${start.returnPoints()}', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
            ],
          ),
        ),
        Text('$price${'KM'}', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Image.asset('assets/lamp_small_logo.png', width: 20),
              Text('$end ${end.returnPoints()}', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAddressWidget(BuildContext context) {
  return Card(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorHelper.lampLightGray.color),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.17),
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: ColorHelper.lampGreen.color,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      prodajna_mjesta_mjesto,
                      style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Ubuntu medium'),
                    ),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      prodajna_mjesta_adresa,
                      style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Ubuntu medium'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: context.watch<SalesLocationProvider>().salesMerchantAddressList.length,
            itemBuilder: (BuildContext context, int index) {
              final SalesMerchantAddress address = context.watch<SalesLocationProvider>().salesMerchantAddressList[index];
              return _buildAddressItem(context, address.city, address.address, index, context.watch<SalesLocationProvider>().salesMerchantAddressList.length);
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildAddressItem(BuildContext context, String city, String address, int index, int length) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: index == length - 1 ? BorderSide.none : BorderSide(color: ColorHelper.lampLightGray.color),
      ),
    ),
    child: IntrinsicHeight(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(3.5),
              child: Text(
                city,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Ubuntu medium', fontStyle: FontStyle.normal),
              ),
            ),
          ),
          VerticalDivider(color: ColorHelper.lampLightGray.color),
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(3.5),
              child: Text(
                address,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Ubuntu medium', fontStyle: FontStyle.normal),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
