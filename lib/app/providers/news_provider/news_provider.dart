import 'package:flutter/material.dart';
import 'package:lamp/app/models/news_details.dart';
import '../../models/news_model.dart';
import '../../repositories/news_repo.dart';

class NewsProvider extends ChangeNotifier {
  NewsProvider() {
    _newsRepository = NewsRepository();
  }

  NewsRepository? _newsRepository;

  List<NewsModel> _newsList = <NewsModel>[];

  List<NewsModel> get newsList => _newsList;

  NewsDetailsModel _newsDetailsModel = NewsDetailsModel();

  NewsDetailsModel get newsDetailsModel => _newsDetailsModel;

  Future<String?> getNews(String page, String pageSize) async {
    try {
      _newsList = await _newsRepository!.getNews(page, pageSize);
      notifyListeners();
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  int newsID = 0;

  void setNewsId(int id) {
    newsID = id;
  }

  Future<String?> getNewsDetails() async {
    try {
      _newsDetailsModel = await _newsRepository!.getNewsDetails(newsID);
      notifyListeners();
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }
}
