import 'package:flutter/material.dart';
import 'package:lamp/app/models/sales_category_model.dart';
import 'package:lamp/app/models/sales_cities_model.dart';
import 'package:lamp/app/models/sales_merchant_address_model.dart';
import 'package:lamp/app/models/sales_merchant_model.dart';
import '../../repositories/sales_location_repo.dart';

class ChooseModel {
  ChooseModel({this.title = '', this.chosen = false, this.id = ''});

  String title;
  String id;
  bool chosen;
}

class SalesLocationProvider extends ChangeNotifier {
  SalesLocationProvider() {
    _salesLocationRepository = SalesLocationRepository();
  }

  SalesLocationRepository? _salesLocationRepository;

  List<SalesCategory> _salesCategory = <SalesCategory>[];

  List<SalesCategory> get salesCategory => _salesCategory;
  List<SalesCity> _salesCity = <SalesCity>[];

  List<SalesCity> get salesCity => _salesCity;

  List<ChooseModel> _salesCityForView = <ChooseModel>[];

  List<ChooseModel> get salesCityForView => _salesCityForView;

  List<ChooseModel> _salesCategoryForView = <ChooseModel>[];

  List<ChooseModel> get salesCategoryForView => _salesCategoryForView;

  Future<String?> getCategories() async {
    _salesCategory.clear();
    try {
      _salesCategory = await _salesLocationRepository!.getCategories();
      setCategoriesForView();
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getCities() async {
    _salesCity.clear();
    try {
      _salesCity = await _salesLocationRepository!.getCities();
      setCitiesForView();
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void setCitiesForView() {
    _salesCityForView.clear();
    if (_salesCity.isNotEmpty) {
      for (final SalesCity sc in _salesCity) {
        _salesCityForView.add(ChooseModel(title: sc.text, id: sc.value));
      }
    }
  }

  bool cityChosen = false;

  void setChooseBoolValueCity(String id) {
    if (_salesCityForView.isNotEmpty) {
      for (final ChooseModel sc in _salesCityForView) {
        if (sc.id == id) {
          sc.chosen = !sc.chosen;
        }
      }
    }
    notifyListeners();
  }

  void setCategoriesForView() {
    _salesCategoryForView.clear();
    if (_salesCategory.isNotEmpty) {
      for (final SalesCategory sc in _salesCategory) {
        _salesCategoryForView.add(ChooseModel(title: sc.text, id: sc.value));
      }
    }
  }

  bool categoryChosen = false;

  void setChooseBoolValueCategory(String id) {
    if (_salesCategoryForView.isNotEmpty) {
      for (final ChooseModel sc in _salesCategoryForView) {
        if (sc.id == id) {
          sc.chosen = !sc.chosen;
        }
      }
    }
    notifyListeners();
  }

  bool showCategory = false;
  bool showCity = false;

  void showCategoryWidget(bool value) {
    showCategory = value;
    notifyListeners();
  }

  void showCityWidget(bool value) {
    showCity = value;
    notifyListeners();
  }

  List<ChooseModel> _chosenCities = <ChooseModel>[];
  List<String> chosenCitiesString = <String>[];

  List<ChooseModel> get chosenCities => _chosenCities;

  void setChosenCitiesList() {
    _chosenCities.clear();
    chosenCitiesString.clear();
    if (_salesCityForView.isNotEmpty) {
      for (final ChooseModel sc in _salesCityForView) {
        if (sc.chosen) {
          _chosenCities.add(sc);
          chosenCitiesString.add(sc.title);
        }
      }
    }
    notifyListeners();
  }

  List<ChooseModel> _chosenCategories = <ChooseModel>[];
  List<String> chosenCategoriesString = <String>[];

  List<ChooseModel> get chosenCategories => _chosenCategories;

  void setChosenCategoriesList() {
    _chosenCategories.clear();
    chosenCategoriesString.clear();
    if (_salesCategoryForView.isNotEmpty) {
      for (final ChooseModel sc in _salesCategoryForView) {
        if (sc.chosen) {
          _chosenCategories.add(sc);
          chosenCategoriesString.add(sc.title);
        }
      }
    }
    notifyListeners();
  }

  List<SalesMerchant> _salesMerchant = <SalesMerchant>[];

  List<SalesMerchant> get salesMerchant => _salesMerchant;

  Future<String?> getMerchants(String pageKey, String pageSize) async {
    // _salesMerchant.clear();
    try {
      _salesMerchant = await _salesLocationRepository!.getMerchants(chosenCategoriesString, chosenCitiesString, pageKey);
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  bool hasAdditionalInfo(SalesMerchant s) => s.additionalInfo.isNotEmpty;

  List<SalesMerchantAddress> _salesMerchantAddressList = <SalesMerchantAddress>[];
  List<SalesMerchantAddress> get salesMerchantAddressList => _salesMerchantAddressList;

  SalesMerchant selectedMerchant = SalesMerchant();

  void setSelectedMerchant(SalesMerchant value) {
    selectedMerchant = value;
  }

  Future<String?> getMerchantAddress() async {
    _salesMerchantAddressList.clear();
    try {
      _salesMerchantAddressList = await _salesLocationRepository!.getMerchantAddress(selectedMerchant.merchantID.toString());
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
