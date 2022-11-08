import 'package:flutter/material.dart';
import 'package:lamp/app/providers/provider_helper.dart';
import 'package:lamp/app/repositories/donation_repo.dart';

class DonationProvider extends ChangeNotifier {
  DonationProvider() {
    _donationRepository = DonationRepository();
  }

  DonationRepository? _donationRepository;

  final TextEditingController pomoziBaAmountController = TextEditingController();
  final TextEditingController donationCardController = TextEditingController();

  bool isPomoziBaSuccess = false;

  void setPomoziBaDonationToSuccess(bool value) {
    isPomoziBaSuccess = value;
    notifyListeners();
  }

  Future<String?> setUserAsDonator() async {
    try {
      await _donationRepository!.setUserToBeAbleToDonate();
      notifyListeners();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> setPomoziBaDonation() async {
    try {
      if (pomoziBaAmountController.text.isNotEmpty) {
        // empty is because it is donation to pomozi ba
        await _donationRepository!.donate(pomoziBaAmountController.text, '', isPomoziBa: true);
        notifyListeners();
        return null;
      }
    } catch (e) {
      return ProviderHelper().dopunaError(e.toString());
    }
  }

  Future<String?> sendDonation() async {
    try {
      if (pomoziBaAmountController.text.isNotEmpty) {
        await _donationRepository!.donate(pomoziBaAmountController.text, donationCardController.text);
        notifyListeners();
        return null;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
