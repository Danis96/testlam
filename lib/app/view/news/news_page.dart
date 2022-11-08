import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lamp/app/models/news_model.dart';
import 'package:lamp/app/providers/news_provider/news_provider.dart';
import 'package:lamp/routing/routes.dart';
import 'package:lamp/theme/color_helper.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/loader/lamp_loader.dart';
import '../../utils/string_texts.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final int pageSize = 10;
  int pKey = 1;
  final PagingController<int, NewsModel> _pagingController = PagingController<int, NewsModel>(firstPageKey: 1);
  List<NewsModel> news = <NewsModel>[];

  @override
  void initState() {
    _pagingController.addPageRequestListener((int pageKey) {
      Future<void>.delayed(Duration(seconds: pageKey == 1 ? 0 : 2)).then((_) {
        _fetchPage(pageKey).then((value) => Navigator.of(context).pop());
      });
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    Lamp_LoaderCircleWhite(context: context);
    try {
      await Provider.of<NewsProvider>(context, listen: false).getNews(pageKey.toString(), '10');

      news = Provider.of<NewsProvider>(context, listen: false).newsList;

      if (news.isEmpty && pageKey != 1) {
        await Provider.of<NewsProvider>(context, listen: false).getNews(pageKey.toString(), '10');
        news = Provider.of<NewsProvider>(context, listen: false).newsList;
      }
      pKey = pageKey;
      final bool isLastPage = news.length < pageSize;
      List<NewsModel> newss = <NewsModel>[];
      for (final NewsModel trip in news) {
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return PagedListView<int, NewsModel>(
      key: Key('$pKey'),
      scrollDirection: Axis.vertical,
      pagingController: _pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<NewsModel>(
        noItemsFoundIndicatorBuilder: (_) => _emptyState(context),
        firstPageProgressIndicatorBuilder: (_) => const SizedBox(),
        itemBuilder: (BuildContext context, NewsModel news, int index) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                    margin: const EdgeInsets.only(top: 20), child: _newsWidget(context, news.image, news.intro, news.formattedDate, news.id)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.1,
      child: Center(child: Text(novosti_empty, style: Theme.of(context).textTheme.headline3)),
    );
  }

  Widget _newsWidget(BuildContext context, String image, String title, String date, int id) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: <Widget>[
        Card(
          elevation: 1,
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color), borderRadius: BorderRadius.circular(11)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  width: 300,
                  child: image != ''
                      ? ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ))
                      : const SizedBox(),
                ),
                SizedBox(
                  height: 55,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 2),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, fontSize: 18)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(date, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w400, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: Platform.isAndroid ? MediaQuery.of(context).size.height / 17 : MediaQuery.of(context).size.height / 20,
          right: Platform.isAndroid ? MediaQuery.of(context).size.width / 10 : MediaQuery.of(context).size.width / 14,
          child: GestureDetector(
            onTap: () {
              context.read<NewsProvider>().setNewsId(id);
              Navigator.of(context).pushNamed(newsDetails, arguments: context.read<NewsProvider>());
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorHelper.white.color,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0, blurRadius: 10)],
              ),
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(11),
              child: Image.asset('assets/arrow_right.png'),
            ),
          ),
        ),
      ],
    );
  }
}
