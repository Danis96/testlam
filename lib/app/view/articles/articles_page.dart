import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lamp/app/models/articles_model.dart';
import 'package:lamp/app/providers/articles_provider/articles_provider.dart';
import 'package:lamp/app/utils/int_extension.dart';
import 'package:lamp/routing/routes.dart';
import 'package:lamp/theme/color_helper.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../common_widgets/text_field/TextFieldType.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final int pageSize = 12;
  int pKey = 1;
  final PagingController<int, ArticlesModel> _pagingController = PagingController<int, ArticlesModel>(firstPageKey: 0);
  List<ArticlesModel> articles = <ArticlesModel>[];

  @override
  void initState() {
    _pagingController.addPageRequestListener((int pageKey) {
      Future<void>.delayed(Duration(seconds: pageKey == 1 ? 0 : 2)).then((_) {
        _fetchPage(pageKey);
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Lamp_LoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Provider.of<ArticlesProvider>(context, listen: false).getAwards(pageKey.toString());

      articles = Provider.of<ArticlesProvider>(context, listen: false).articles;

      if (articles.isEmpty && pageKey != 1) {
        await Provider.of<ArticlesProvider>(context, listen: false).getAwards(pageKey.toString());
        articles = Provider.of<ArticlesProvider>(context, listen: false).articles;
      }
      pKey = pageKey;
      final bool isLastPage = articles.length < pageSize;
      List<ArticlesModel> newss = <ArticlesModel>[];
      for (final ArticlesModel trip in articles) {
        newss.add(trip);
      }
      if (isLastPage) {
        _pagingController.appendLastPage(newss);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(newss, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _getInitialData() async {
    await context.read<ArticlesProvider>().getAwards('0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return Lamp_AppBarIconTitleIcon(
    context,
    onActionPressed: null,
    implyAction: false,
    titleWidget: SizedBox(width: MediaQuery.of(context).size.width / 1.7, child: Image.asset('assets/lamp_articles.png')),
    centerTitle: true,
    onLeadingPressed: () => Navigator.of(context).pop(),
    leadingIcon: Icons.arrow_back_ios,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  return ListView(
    shrinkWrap: true,
    children: <Widget>[
      _buildSearchWidget(context),
      _buildArticlesGridList(context),
    ],
  );
}

Widget _buildSearchWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 56),
    child: Lamp_TextFormField(
      controller: context.read<ArticlesProvider>().searchController,
      onChange: () {
        context.read<ArticlesProvider>().searchByNameArticles();
      },
      hintText: 'Pretraži',
      textAlign: TextAlign.start,
      prefixIcon: Icon(Icons.search, size: 28, color: ColorHelper.lampGray.color),
    ),
  );
}

Widget _buildArticlesGridList(BuildContext context) {
  return context.watch<ArticlesProvider>().showEmpty
      ? const SizedBox()
      : GridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisSpacing: 33,
          mainAxisSpacing: 33,
          crossAxisCount: 2,
          childAspectRatio: Platform.isIOS ? 0.74 : 0.65,
          padding: const EdgeInsets.symmetric(horizontal: 38),
          children: (context.watch<ArticlesProvider>().searchList.isNotEmpty
                  ? context.watch<ArticlesProvider>().searchList
                  : context.watch<ArticlesProvider>().articles)
              .map((e) => GestureDetector(
                  onTap: () {
                    context.read<ArticlesProvider>().setArticleID(e.id);
                    Navigator.of(context).pushNamed(articleDetails, arguments: context.read<ArticlesProvider>());
                  },
                  child: _buildArticlesItem(context, name: e.name, bodovi: e.creditAmount.toString(), img: e.image, km: e.priceAmount.toString())))
              .toList(),
        );
}

Widget _buildArticlesItem(BuildContext context, {String img = '', String name = '', String bodovi = '', String km = ''}) {
  return Container(
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
    child: Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
              child: Image.network(
                img,
                height: 120,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(11),
                        topLeft: Radius.circular(11),
                      ),
                    ),
                    child: Image.asset(
                      'assets/lampica_logo.png',
                      fit: BoxFit.contain,
                      height: 120,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w400, color: ColorHelper.lampGray.color, fontSize: 16)),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: ColorHelper.lampGreen.color, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
              child: Column(
                children: <Widget>[
                  Text('$bodovi ${int.parse(bodovi).returnPoints()}',
                      style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: ColorHelper.lampGray.color, fontSize: 16)),
                  Text('$km KM',
                      style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: ColorHelper.lampGray.color, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: Platform.isAndroid ? MediaQuery.of(context).size.height * 0.085 : MediaQuery.of(context).size.height * 0.065,
          right: Platform.isAndroid ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.width * 0.01,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorHelper.white.color,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0, blurRadius: 10)],
            ),
            height: 27,
            width: 27,
            padding: const EdgeInsets.all(9),
            child: Image.asset('assets/arrow_right.png'),
          ),
        ),
      ],
    ),
  );
}
