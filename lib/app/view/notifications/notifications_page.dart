import 'package:flutter/material.dart';
import 'package:lamp/app/models/user_notification_model.dart';
import 'package:lamp/app/utils/int_extension.dart';
import 'package:lamp/routing/routes.dart';
import 'package:lamp/theme/color_helper.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../providers/account_provider/account_provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Lamp_LoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  Future<void> _getInitialData() async {
    await context.read<AccountProvider>().getUserNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildBody(context),
    );
  }
}

PreferredSizeWidget _appBar(BuildContext context) {
  return Lamp_AppBarIconTitleIcon(
    context,
    onActionPressed: null,
    implyAction: false,
    titleWidget: SizedBox(width: MediaQuery.of(context).size.width / 1.6, child: Image.asset('assets/lamp_notification.png')),
    centerTitle: true,
    onLeadingPressed: () => Navigator.of(context).pop(),
    leadingIcon: Icons.arrow_back_ios,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
    itemCount: context.watch<AccountProvider>().userNotifications.length,
    itemBuilder: (BuildContext context, int index) {
      final UserNotification singleNotification = context.watch<AccountProvider>().userNotifications[index];
      return GestureDetector(
          onTap: () {
            context.read<AccountProvider>().setNotification(singleNotification);
            Navigator.of(context).pushNamed(notificationDetails, arguments: context.read<AccountProvider>());
          },
          child: _notificationWidget(
              context, singleNotification.notificationTitle, singleNotification.description, singleNotification.amount.toString()));
    },
  );
}

Widget _notificationWidget(BuildContext context, String title, String desc, String amount) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Card(
      elevation: 5,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color.withOpacity(0.5)), borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.9,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGray.color),
                    )),
                SizedBox(
                  width: 100,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '$amount ${int.parse(amount).returnPoints()}',
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: amount.contains('-') ? ColorHelper.lampRed.color : ColorHelper.lampGreen.color, fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
            Text(desc,
                style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGray.color, fontWeight: FontWeight.w300, fontSize: 17)),
          ],
        ),
      ),
    ),
  );
}
