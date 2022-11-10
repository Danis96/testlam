import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lamp/app/repositories/report_repo.dart';

import '../../models/report_model.dart';

class ReportProvider extends ChangeNotifier {
  ReportProvider() {
    _reportRepository = ReportRepository();
  }

  ReportRepository? _reportRepository;

  TextEditingController searchController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();

  List<ReportModel> _reports = <ReportModel>[];

  List<ReportModel> get reports => _reports;

  Future<String?> getUserPurchaseReports({bool isSelected = false}) async {
    try {
      if(isSelected) {
        final List<String> splitted = toController.text.split('.');
        final String monthNumber = splitted[1];
        final String yearNumber = splitted[2];
        searchList.clear();
        _reports = await _reportRepository!.getUserPurchaseReports(monthNumber, yearNumber);
      } else {
        final String monthNumber = DateTime.now().month.toString();
        final String yearNumber = DateTime.now().year.toString();
        searchList.clear();
        showEmpty = false;
        _reports = await _reportRepository!.getUserPurchaseReports(monthNumber, yearNumber);
      }
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  bool showFilter = false;

  void setShowFilter(bool value) {
    showFilter = value;
    notifyListeners();
  }

  void resetFilter() {
     fromController.text = '';
     notifyListeners();
  }

  List<ReportModel> searchList = <ReportModel>[];

  bool showEmpty = false;

  void searchByName() {
    if (searchController.text.isNotEmpty) {
      List<ReportModel> searchedItems = <ReportModel>[];
      for (final ReportModel element in _reports) {
        if (element.merchantName.toLowerCase().contains(searchController.text)) {
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
      searchList.addAll(_reports);
    }
    notifyListeners();
  }

  void searchByDate() {
    searchList.clear();
    if (fromController.text.isNotEmpty && toController.text.isNotEmpty) {
      final DateTime fDate = DateFormat("yyyy-MM-dd").parse(fromController.text);
      // final DateTime fDate = DateTime.parse(fromController.text);
      final DateTime tDate = DateTime.parse(toController.text);
      List<ReportModel> searchedItems = <ReportModel>[];
      for (final ReportModel element in _reports) {
        final DateTime reportDate = DateTime.parse(element.purchaseDate);
        if (fDate.isBefore(reportDate) && tDate.isAfter(reportDate)) {
          searchedItems.add(element);
        }
      }
      searchList.clear();
      searchList.addAll(searchedItems);
    } else {
      searchList.clear();
      searchList.addAll(_reports);
    }
    notifyListeners();
  }
}
