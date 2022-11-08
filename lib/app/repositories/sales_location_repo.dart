import 'package:lamp/app/models/sales_category_model.dart';
import 'package:lamp/app/models/sales_cities_model.dart';
import 'package:lamp/app/models/sales_merchant_address_model.dart';
import 'package:lamp/app/models/sales_merchant_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class SalesLocationRepository {
  Future<List<SalesMerchant>> getMerchants(List<String> category, List<String> city, String pageKey) async {
    List<SalesMerchant> salesMerchantList;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    List<String> _categoryList = <String>[];
    List<String> _citiesList = <String>[];
    Map<String, String> _categoriesMap = <String, String>{};
    for (final String _cat in category) {
      if (_cat.contains(' ')) {
        final List<String> _stringList = _cat.split(' ');
        _categoriesMap['&categories='] = _stringList[0] + _stringList[1];
      } else {
        _categoriesMap['&categories='] = _cat;
      }
      _categoriesMap.forEach((key, value) {
        _categoryList.add(key + value);
      });
    }
    Map<String, String> _cityMap = <String, String>{};
    for (final String _cat in city) {
      if (_cat.contains(' ')) {
        final List<String> _stringList = _cat.split(' ');
        _cityMap['&cities='] = _stringList[0] + _stringList[1];
      } else {
        _cityMap['&cities='] = _cat;
      }
      _cityMap.forEach((key, value) {
        _citiesList.add(key + value);
      });
    }
    String apiCat = '';
    String apiCity = '';
    _cityMap.forEach((key, value) {
      apiCity = (key + value);
    });
    _categoryList.forEach((String e) {
      apiCat += e;
    });
    final dynamic response =
        await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_merchants, concatValue: apiCat, secondConcatValue: apiCity, thirdConcatValue: pageKey), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    salesMerchantList = responseJson.map((e) => SalesMerchant.fromJson(e)).toList();
    return salesMerchantList;
  }

  Future<List<SalesCategory>> getCategories() async {
    List<SalesCategory> salesCategoryList;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_categories), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    salesCategoryList = responseJson.map((e) => SalesCategory.fromJson(e)).toList();
    return salesCategoryList;
  }

  Future<List<SalesCity>> getCities() async {
    List<SalesCity> salesCityList;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_cities), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    salesCityList = responseJson.map((e) => SalesCity.fromJson(e)).toList();
    return salesCityList;
  }

  Future<List<SalesMerchantAddress>> getMerchantAddress(String id) async {
    List<SalesMerchantAddress> salesAddressList;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_merchant_address, concatValue: id), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    salesAddressList = responseJson.map((e) => SalesMerchantAddress.fromJson(e)).toList();
    return salesAddressList;
  }
}
