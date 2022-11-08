import 'dart:io';

import 'package:lamp/app/models/user_info.dart';
import 'package:lamp/app/models/user_main_info.dart';
import 'package:lamp/app/models/user_notification_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class AccountRepository {
  Future<UserInfo> getUserinfo() async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.user_info), header);
    UserInfo userInfo = UserInfo();
    if (response != null) {
      userInfo = UserInfo.fromJson(response);
    }
    return userInfo;
  }

  Future<UserMainInfo> getUserMainInformation() async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.user_main_info), header);
    UserMainInfo userInfo = UserMainInfo();
    if (response != null) {
      userInfo = UserMainInfo.fromJson(response);
    }
    return userInfo;
  }

  Future<List<UserNotification>> getUserNotifications() async {
    List<UserNotification> userNotifications = <UserNotification>[];
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_user_notifications), header);
    final List<dynamic> responseJson = response as List<dynamic>;
    userNotifications = responseJson.map((e) => UserNotification.fromJson(e)).toList();
    return userNotifications;
  }

  Future<void> uploadPhoto(File file) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postMultipartData(ApiPathHelper.getValue(ApiPath.upload_image), header, file);
    print('object');
  }

  Future<void> deletePhoto(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.delete_image, concatValue: email), header);
    print('object');
  }

  Future<void> setSeenNotifications(String id) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.set_seen_notification, concatValue: id), header);
    print('object');
  }
}
