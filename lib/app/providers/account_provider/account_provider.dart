import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamp/app/models/user_info.dart';
import 'package:lamp/app/models/user_main_info.dart';
import 'package:lamp/app/models/user_notification_model.dart';
import 'package:lamp/app/repositories/account_repo.dart';
import 'package:lamp/common_widgets/loader/lamp_loader.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../utils/storage_prefs_manager.dart';

class AccountProvider extends ChangeNotifier {
  AccountProvider() {
    _accountRepository = AccountRepository();
  }

  AccountRepository? _accountRepository;

  UserInfo _info = UserInfo();
  UserInfo get info => _info;

  UserMainInfo _userMainInfo = UserMainInfo();
  UserMainInfo get userMainInfo => _userMainInfo;

  List<UserNotification> _userNotifications = <UserNotification>[];
  List<UserNotification> get userNotifications => _userNotifications;

  UserNotification notification = UserNotification();

  void setNotification(UserNotification value) {
     notification = value;
     notifyListeners();
  }

  File? imageFile;
  String? pickImageError;
  String? retrieveDataError;
  String? userPhoto;
  final ImagePicker picker = ImagePicker();

  Future<String?> getUserInfo() async {
    try {
      _info = await _accountRepository!.getUserinfo();
      notifyListeners();
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String?> getUserMainInfo() async {
    try {
      _userMainInfo = await _accountRepository!.getUserMainInformation();
      setUserImg();
      notifyListeners();
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String?> getUserNotifications() async {
    _userNotifications.clear();
    try {
      _userNotifications = await _accountRepository!.getUserNotifications();
      notifyListeners();
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  bool haveUnreadNotifications() => _userNotifications.isNotEmpty;

  Future<String?> setSeenNotifications() async {
    try {
      await _accountRepository!.setSeenNotifications(notification.notificationId.toString());
      notifyListeners();
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  String returnUsersCardNumber() => _userMainInfo.cardNumber.isNotEmpty ? _userMainInfo.cardNumber : '000 000 000';

  String? barcodeSVGPath = '';

  Future<void> setBarcodeSvg() async {
    String svg = Barcode.code93().toSvg(returnUsersCardNumber(), fontHeight: 0);
    await _write(svg);
    barcodeSVGPath = await _read();
    notifyListeners();
  }

  Future<void> _write(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/barcode.svg');
    await file.writeAsString(text);
  }

  Future<String> _read() async {
    String text = '';
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/barcode.svg');
      text = file.path;
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  int indexCarousel = 0;
  void addIndexCarousel(int index) {
     indexCarousel = index;
     notifyListeners();
  }

  void setUserImg() {
    if(_userMainInfo.profileImg.isNotEmpty) {
       userPhoto = _userMainInfo.profileImg;
    }
  }

  Future<String?> uploadImage(BuildContext context) async {
    final PickedFile? pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    final img.Image? capturedImage = img.decodeImage(await File(pickedFile!.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    imageFile = await File(pickedFile.path)
        .writeAsBytes(img.encodeJpg(orientedImage));
    Lamp_LoaderCircleWhite(context: context);
    try {
      if (imageFile != null) {
        await _accountRepository!.uploadPhoto(imageFile!);
      }
      notifyListeners();
      Navigator.of(context).pop();
      return null;
    } catch(e) {
      Navigator.of(context).pop();
      return e.toString();
    }
  }


  Future<String?> deletePhoto(BuildContext context) async {
    try {
      Lamp_LoaderCircleWhite(context: context);
      final String email = await storagePrefs.readEmailFromShared();
      await _accountRepository!.deletePhoto(email);
      userPhoto = null;
      imageFile = null;
      notifyListeners();
      Navigator.of(context).pop();
      return null;
    } catch(e) {
      return e.toString();
    }
  }

}
