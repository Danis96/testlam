import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lamp/app/providers/sales_location_provider/sales_location_provider.dart';
import 'package:lamp/routing/routes.dart';
import 'package:lamp/theme/color_helper.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/bottom_sheet/lamp_bottom_sheet.dart';
import '../../../common_widgets/buttons/button.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../models/sales_merchant_model.dart';
import '../../utils/string_texts.dart';

class ProdajnaMjestapage extends StatefulWidget {
  const ProdajnaMjestapage({Key? key}) : super(key: key);

  @override
  State<ProdajnaMjestapage> createState() => _ProdajnaMjestapageState();
}

class _ProdajnaMjestapageState extends State<ProdajnaMjestapage> {
  final int pageSize = 10;
  int pKey = 0;
  final PagingController<int, SalesMerchant> _pagingController = PagingController<int, SalesMerchant>(firstPageKey: 0);
  List<SalesMerchant> merchants = <SalesMerchant>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Lamp_LoaderCircleWhite(context: context);
      _getCitiesAndCategories().then((value) => Navigator.of(context).pop());
    });
    _fetchPage();
  }

  Future<void> _fetchPage() async {
    _pagingController.addPageRequestListener((int pageKey) {
      Future<void>.delayed(Duration(seconds: pageKey == 1 ? 0 : 2)).then((_) async {
        await Provider.of<SalesLocationProvider>(context, listen: false).getMerchants(pageKey.toString(), pageSize.toString());
        merchants = Provider.of<SalesLocationProvider>(context, listen: false).salesMerchant;
        final bool isLastPage = merchants.length < pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(merchants);
        } else {
          final int nextPageKey = pageKey + 1;
          _pagingController.appendPage(merchants, nextPageKey);
        }
      });
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _getCitiesAndCategories() async {
    await context.read<SalesLocationProvider>().getCategories();
    await context.read<SalesLocationProvider>().getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return Lamp_AppBarIconTitleIcon(
      context,
      onActionPressed: null,
      implyAction: false,
      implyLeading: false,
      titleWidget: SizedBox(width: MediaQuery.of(context).size.width / 1.5, child: Image.asset('assets/lamp_prodajna_mjesta.png')),
      centerTitle: false,
      onLeadingPressed: null,
      bottomWidget: _buildSearch(context),
    );
  }

  PreferredSizeWidget _buildSearch(BuildContext context) {
    final SalesLocationProvider provider = Provider.of<SalesLocationProvider>(context);
    return PreferredSize(
        preferredSize: const Size(400, 140),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _chooseWidget(context, provider.chosenCitiesString.isNotEmpty ? provider.chosenCitiesString.join(', ') : prodajna_mjesta_odaberi_grad,
                  () {
                provider.showCityWidget(!provider.showCity);
                showCityDialog(context);
              }),
              const SizedBox(height: 20),
              _chooseWidget(context,
                  provider.chosenCategoriesString.isNotEmpty ? provider.chosenCategoriesString.join(', ') : prodajna_mjesta_odaberi_kategoriju, () {
                provider.showCategoryWidget(!provider.showCategory);
                showCategoryDialog(context);
              }),
            ],
          ),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return PagedListView<int, SalesMerchant>(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      key: Key('$pKey'),
      scrollDirection: Axis.vertical,
      pagingController: _pagingController,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<SalesMerchant>(
        noItemsFoundIndicatorBuilder: (_) => _emptyState(context),
        firstPageProgressIndicatorBuilder: (_) => const SizedBox(),
        itemBuilder: (BuildContext context, SalesMerchant merchant, int index) {
          final SalesMerchant singleM = merchant;
          return _buildProdajnaMjestaWidget(
            context,
            singleM.image,
            singleM.merchantName,
            singleM.moneyOnLowLoyalty.toInt(),
            singleM.moneyOnFullLoyalty.toInt(),
            singleM.moneyToFullLoyalty.toInt(),
            singleM,
          );
        },
      ),
    );
  }

  Widget _buildProdajnaMjestaWidget(
      BuildContext context, String img, String title, int startPoints, int endPoints, int price, SalesMerchant salesMerchant) {
    return GestureDetector(
      onTap: () {
        context.read<SalesLocationProvider>().setSelectedMerchant(salesMerchant);
        Navigator.of(context).pushNamed(prodajnaMjestaDetalji, arguments: context.read<SalesLocationProvider>());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        decoration: BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            img.isNotEmpty && img != ''
                ? Image.network(
                    img,
                    width: 200,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(11), topLeft: Radius.circular(11)),
                        ),
                        child: Image.asset('assets/lampica_logo.png', height: 80),
                      );
                    },
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(11), topLeft: Radius.circular(11)),
                    ),
                    child: Image.asset('assets/lampica_logo.png', height: 80),
                  ),
            Text(title, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            _buildFooter(context, startPoints, endPoints, price, salesMerchant),
            salesMerchant.additionalInfo.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(salesMerchant.additionalInfo,
                        style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w400, fontSize: 15)),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, int start, int end, int price, SalesMerchant salesMerchant) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: ColorHelper.lampGreen.color,
        borderRadius: BorderRadius.only(
          bottomLeft: salesMerchant.additionalInfo.isNotEmpty ? const Radius.circular(0) : const Radius.circular(11),
          bottomRight: salesMerchant.additionalInfo.isNotEmpty ? const Radius.circular(0) : const Radius.circular(11),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                Image.asset('assets/lamp_small_logo.png', width: 20),
                Text('$start$prodajna_mjesta_bod', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
              ],
            ),
          ),
          Text('$price $prodajna_mjesta_KM', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                Image.asset('assets/lamp_small_logo.png', width: 20),
                Text('$end$prodajna_mjesta_bod', style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chooseWidget(BuildContext context, String title, Function function) {
    return Lamp_Button(
      onPressed: () => function(),
      buttonTitle: title,
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(217, 220, 198, 1))),
    );
  }

  Widget _chooseList(BuildContext context, Function setState, {List<ChooseModel>? category, List<ChooseModel>? city}) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: category != null
                    ? category.length
                    : city != null
                        ? city.length
                        : 0,
                itemBuilder: (BuildContext context, int index) {
                  if (category != null) {
                    final ChooseModel singleCategory = category[index];
                    return _chooseListItem(context, singleCategory.title, singleCategory.chosen, singleCategory.id, false, setState);
                  } else {
                    final ChooseModel singleCity = city![index];
                    return _chooseListItem(context, singleCity.title, singleCity.chosen, singleCity.id, true, setState);
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _chooseListItem(BuildContext context, String title, bool value, String id, bool isCity, Function setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCity
                ? context.read<SalesLocationProvider>().setChooseBoolValueCity(id)
                : context.read<SalesLocationProvider>().setChooseBoolValueCategory(id);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.6,
                child: Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontStyle: FontStyle.normal, fontWeight: FontWeight.w500))),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 25,
              height: 25,
              decoration: BoxDecoration(shape: BoxShape.circle, color: ColorHelper.white.color),
              child: value
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.circle_outlined, size: 25.0, color: ColorHelper.lampLightGray.color),
                        Icon(Icons.circle, size: 15.0, color: ColorHelper.lampGreen.color),
                      ],
                    )
                  : Icon(Icons.circle_outlined, size: 25.0, color: ColorHelper.lampLightGray.color),
            )
          ],
        ),
      ),
    );
  }

  Widget _listButtons(BuildContext context, Function odaberi, Function nazad) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: Lamp_Button(onPressed: () => odaberi(), buttonTitle: prodajna_mjesta_btn_odaberi)),
        SizedBox(width: MediaQuery.of(context).size.width / 6),
        Expanded(
          child: Lamp_Button(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(ColorHelper.lampGray.color),
            ),
            btnTitleStyle: TextStyle(
              color: ColorHelper.white.color,
              fontSize: 20.0,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500,
            ),
            onPressed: () => nazad(),
            buttonTitle: prodajna_mjesta_btn_nazad,
          ),
        ),
      ],
    );
  }

  Widget _emptyState(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.6,
      child: Center(child: Text(prodajna_mjesta_empty, style: Theme.of(context).textTheme.headline3)),
    );
  }

  void showCityDialog(BuildContext context) {
    final SalesLocationProvider provider = Provider.of<SalesLocationProvider>(context, listen: false);
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (ctx, setState) {
            return ChangeNotifierProvider.value(
              value: provider,
              child: Lamp_CustomModalSheet(
                title: prodajna_mjesta_odaberi_grad,
                shouldUseHeight: false,
                onClosePressed: () => Navigator.of(context).pop(),
                bodyWidget: _chooseList(
                  ctx,
                  setState,
                  city: provider.salesCityForView,
                ),
                bottomWidget: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(ctx).size.width / 1,
                      height: MediaQuery.of(ctx).size.height / 14,
                      child: _listButtons(ctx, () async {
                        Lamp_LoaderCircleWhite(context: ctx);
                        pKey = 1;
                        provider.setChosenCitiesList();
                        await provider.getMerchants(pKey.toString(), '10');
                        provider.showCityWidget(false);
                        _pagingController.refresh();
                        Navigator.of(ctx).pop();
                        Navigator.of(ctx).pop();
                      }, () {
                        Navigator.of(ctx).pop();
                      }),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void showCategoryDialog(BuildContext context) {
    final SalesLocationProvider provider = Provider.of<SalesLocationProvider>(context, listen: false);
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (ctx, setState) {
            return ChangeNotifierProvider.value(
              value: provider,
              child: Lamp_CustomModalSheet(
                title: prodajna_mjesta_odaberi_grad,
                shouldUseHeight: false,
                onClosePressed: () => Navigator.of(context).pop(),
                bodyWidget: _chooseList(context, setState, category: provider.salesCategoryForView),
                bottomWidget: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(ctx).size.width / 1,
                      height: MediaQuery.of(ctx).size.height / 14,
                      child: _listButtons(ctx, () async {
                        Lamp_LoaderCircleWhite(context: ctx);
                        pKey = 1;
                        provider.setChosenCategoriesList();
                        await provider.getMerchants(pKey.toString(), '10');
                        provider.showCategoryWidget(false);
                        _pagingController.refresh();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }, () {
                        Navigator.of(ctx).pop();
                      }),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
