

import 'package:flutter/material.dart';
import 'package:lamp/app/models/articles_model.dart';
import 'package:lamp/app/providers/provider_helper.dart';
import 'package:lamp/app/repositories/articles_repo.dart';

import '../../models/article_model.dart';

class ArticlesProvider extends ChangeNotifier {

  ArticlesProvider() {
    _articlesRepository = ArticlesRepository();
  }

  ArticlesRepository? _articlesRepository;

  TextEditingController searchController = TextEditingController();

  List<ArticlesModel> _articles = <ArticlesModel>[];
  List<ArticlesModel> get articles => _articles;

  ArticleModel _articleDetail = ArticleModel();
  ArticleModel get articleDetail => _articleDetail;


  int articleID = 0;
  void setArticleID(int id) {
     articleID = id;
  }

  Future<String?> getAwards(String pageKey) async {
    try {
      _articles =  await _articlesRepository!.getArticles(pageKey);
      notifyListeners();
      return null;
    } catch(e) {
      print('Get awards error $e');
      return e.toString();
    }
  }

  Future<String?> getAwardDetails() async {
    try {
      _articleDetail =  await _articlesRepository!.getArticleDetails(articleID.toString());
      notifyListeners();
      return null;
    } catch(e) {
      print('Get awards error $e');
      return e.toString();
    }
  }

  bool showSuccess = false;
  void setShowSuccess(bool value) {
     showSuccess = value;
     notifyListeners();
  }

  Future<String?> buyAward() async {
    try {
      await _articlesRepository!.buyArticle(_articleDetail.id);
      notifyListeners();
      return null;
    } catch(e) {
      print('buyAward error $e');
      return ProviderHelper().articlesBuyError(e.toString());
    }
  }

  List<ArticlesModel> searchList = <ArticlesModel>[];

  bool showEmpty = false;

  void searchByNameArticles() {
    if (searchController.text.isNotEmpty) {
      List<ArticlesModel> searchedItems = <ArticlesModel>[];
      for (final ArticlesModel element in _articles) {
        if (element.name.toLowerCase().contains(searchController.text)) {
          searchedItems.add(element);
        }
      }
      if(searchedItems.isEmpty) {
        showEmpty = true;
      } else {
        showEmpty = false;
      }
      searchList.clear();
      searchList.addAll(searchedItems);
    } else {
      searchList.clear();
      searchList.addAll(_articles);
    }
    notifyListeners();
  }

}