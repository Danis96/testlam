import 'package:flutter/cupertino.dart';

class ModalHelper {
  void returnErrorModalOrFn(BuildContext context, String? error, {Function? function}) {
    if (error != null) {
      // FOSSimpleDialog(context, content: error, title: 'modal_helper.error'.tr(), buttonText: 'modal_helper.btn_text'.tr());
    } else {
      if(function != null) {
        function();
      }
    }
  }
}
