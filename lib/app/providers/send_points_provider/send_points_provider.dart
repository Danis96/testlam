import 'package:flutter/material.dart';
import 'package:lamp/app/models/recipient_info_model.dart';
import 'package:lamp/app/providers/provider_helper.dart';
import 'package:lamp/app/repositories/send_points_repo.dart';

class SendPointsProvider extends ChangeNotifier {
  SendPointsProvider() {
    _sendPointsRepository = SendPointsRepository();
  }

  SendPointsRepository? _sendPointsRepository;

  TextEditingController cardNoController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  RecipientInfo _recipientInfo = RecipientInfo();
  RecipientInfo get recipientInfo => _recipientInfo;

  Future<String?> getRecipientsInfo() async {
    try {
      _recipientInfo = await _sendPointsRepository!.getRecipientInfo(cardNoController.text, amountController.text);
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  bool pointsSendSuccess = false;

  void pointsSendSuccessSet(bool value) {
    pointsSendSuccess = value;
    notifyListeners();
  }

  Future<String?> sendPoints() async {
    try {
      await _sendPointsRepository!.sendPoints(cardNoController.text, amountController.text);
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return ProviderHelper().sendPointsErrorParse(e.toString());
    }
  }

  Future<String?> pointsSendingNumber() async {
    try {
      await _sendPointsRepository!.pointsSendingNumber();
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
