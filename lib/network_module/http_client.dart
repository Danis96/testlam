import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../app/config/flavor_config.dart';
import '../app/locator.dart';
import '../app/repositories/navigation_repo.dart';
import 'api_exceptions.dart';

class HTTPClient {
  static final HTTPClient _singleton = HTTPClient();

  static HTTPClient get instance => _singleton;

  final NavigationRepo _navigationService = locator<NavigationRepo>();

  Future<dynamic> fetchData(String url, Map<String, String> headersType, {Map<String, dynamic>? params}) async {
    dynamic responseJson;

    final String uri = FlavorConfig.instance.values.baseUrl + url + ((params != null) ? queryParameters(params) : '');
    final Uri myUri = Uri.parse(uri);
    print(uri);
    try {
      final http.Response response = await http.get(myUri, headers: headersType);
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteData(String url, Map<String, String> headersType, {Map<String, String>? params, Map<String, dynamic>? body}) async {
    dynamic responseJson;

    final String uri = FlavorConfig.instance.values.baseUrl + url + ((params != null) ? queryParameters(params) : '');
    final Uri myUri = Uri.parse(uri);
    try {
      final http.Response response = await http.delete(myUri, headers: headersType, body: body != null ? jsonEncode(body) : null);
      print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> postData(String url, Map<String, String> headerType, {dynamic body, bool shouldEncode = false}) async {
    final String apiBase = FlavorConfig.instance.values.baseUrl;
    dynamic responseJson;
    try {
      final String uri = apiBase + url;
      final Uri myUri = Uri.parse(uri);
      print('Json body ${jsonEncode(body)}');
      final http.Response response = await http.post(
        myUri,
        body: body != null
            ? shouldEncode
                ? jsonEncode(body)
                : body
            : null,
        headers: headerType,
        encoding: Encoding.getByName('utf-8'),
      );
      responseJson = _returnResponse(response);
    }
    // on SocketException {
    //   throw InternetException('No internet connection');
    // }
    on Exception catch (_) {
      rethrow;
    } catch(e) {
      print('CATCH HTTP POST: $e');
    }
    return responseJson;
  }

  Future<dynamic> patchData(String url, dynamic body, Map<String, String> headerType) async {
    final String apiBase = FlavorConfig.instance.values.baseUrl;
    dynamic responseJson;
    try {
      final String uri = apiBase + url;
      final Uri myUri = Uri.parse(uri);
      final http.Response response = await http.patch(myUri, body: jsonEncode(body), headers: headerType);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> putData(String url, dynamic body, Map<String, String> headerType, {bool isAws = false}) async {
    final String apiBase = isAws ? '' : FlavorConfig.instance.values.baseUrl;
    dynamic responseJson;
    try {
      final String uri = apiBase + url;
      final Uri myUri = Uri.parse(uri);
      print(body.toString());
      final http.Response response = await http.put(myUri, body: jsonEncode(body), headers: headerType);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> put(
    String url,
    dynamic body,
  ) async {
    dynamic responseJson;
    try {
      final Uri myUri = Uri.parse(url);
      print(body.toString());
      final http.Response response = await http.put(myUri, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postMultipartData(String url, Map<String, String> headerType, File? file) async {
    final String apiBase = FlavorConfig.instance.values.baseUrl;
    dynamic responseJson;
    try {
      final Uri uri = Uri.parse(apiBase + url);
      final http.MultipartRequest request = http.MultipartRequest('POST', uri);
      if (file != null) {
        request.files.add(await http.MultipartFile.fromBytes('Images', file.readAsBytesSync(), filename: 'Photo.jpg'));
      }
      // request.fields.addAll(body);
      request.headers.addAll(headerType);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse = await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> getMultipartData(String url, Map<String, String> body, Map<String, String> headerType) async {
    print(body.toString());
    final String apiBase = FlavorConfig.instance.values.baseUrl;
    dynamic responseJson;
    try {
      final Uri uri = Uri.parse(apiBase + url);
      final http.MultipartRequest request = http.MultipartRequest('GET', uri)
        ..headers.addAll(headerType)
        ..fields.addAll(body);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse = await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
    } on SocketException {
      // throw InternetException('No internet connection');
    } on Exception catch (_) {
      // rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postMultipartImage(String url, Map<String, String> headerType, String imageFile) async {
    print(imageFile);
    final String apiBase = FlavorConfig.instance.values.baseUrl;
    dynamic responseJson;
    try {
      final Uri uri = Uri.parse(apiBase + url);
      final http.MultipartRequest request = http.MultipartRequest('POST', uri)..files.add(await http.MultipartFile.fromPath('image', imageFile));
      request.headers.addAll(headerType);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse = await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
      print(responseJson);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  String queryParameters(Map<String, dynamic> params) {
    if (params != null) {
      final Uri jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }

  dynamic _returnResponse(http.Response response) async {
    print(response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
      case 204:
        try {
          final dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
          return responseJson ?? '';
        } catch (e) {
          return;
        }
        break;
      case 201:
        final dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
      case 401:
      case 404:
      case 405:
        final dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestValidationException.fromJson(responseJson);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        final dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestValidationException.fromJson(responseJson);
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
