import 'package:flutter/material.dart';
import 'package:lamp/app/providers/account_provider/account_provider.dart';
import 'package:lamp/app/utils/int_extension.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../theme/color_helper.dart';

class NotificationDetailsPage extends StatefulWidget {
  const NotificationDetailsPage({Key? key}) : super(key: key);

  @override
  State<NotificationDetailsPage> createState() => _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
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
    await context.read<AccountProvider>().setSeenNotifications();
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
    titleWidget: SizedBox(width: MediaQuery.of(context).size.width / 2.1, child: Image.asset('assets/lamp_notification.png')),
    centerTitle: true,
    onLeadingPressed: () => Navigator.of(context).pop(),
    leadingIcon: Icons.arrow_back_ios,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  final AccountProvider provider = Provider.of<AccountProvider>(context);
  return ListView(
    shrinkWrap: true,
    padding: const EdgeInsets.symmetric(horizontal: 24),
    children: <Widget>[
      _notificationWidget(
          context, provider.notification.notificationTitle, provider.notification.description, provider.notification.amount.toString())
    ],
  );
}

Widget _notificationWidget(BuildContext context, String title, String desc, String amount) {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Card(
      elevation: 1,
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color.withOpacity(0.5)), borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.4,
                child: Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGray.color))),
            const SizedBox(height: 5),
            Text(desc,
                style: Theme.of(context).textTheme.headline2!.copyWith(color: ColorHelper.lampGray.color, fontWeight: FontWeight.w300, fontSize: 17)),
            const SizedBox(height: 5),
            Text(
              '$amount ${int.parse(amount).returnPoints()}',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: amount.contains('-') ? ColorHelper.lampRed.color : ColorHelper.lampGreen.color, fontSize: 24),
            ),
          ],
        ),
      ),
    ),
  );
}
