import 'package:flutter/material.dart';
import 'package:lamp/app/models/news_details.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../theme/color_helper.dart';
import '../../providers/news_provider/news_provider.dart';

class NewsDetailsPage extends StatefulWidget {
  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
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
    await context.read<NewsProvider>().getNewsDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return Lamp_AppBarIconTitleIcon(
    context,
    onActionPressed: null,
    implyAction: false,
    onLeadingPressed: () => Navigator.of(context).pop(),
    title: '',
    centerTitle: false,
    leadingIcon: Icons.arrow_back_ios_new,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  final NewsDetailsModel news = context.watch<NewsProvider>().newsDetailsModel;
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 34),
    shrinkWrap: true,
    children: <Widget>[
      SizedBox(
        height: 300,
        width: 300,
        child: news.image.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.network(
                  news.image[0],
                  fit: BoxFit.fill,
                ))
            : const SizedBox(),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(border: Border.all(color: ColorHelper.lampLightGray.color), borderRadius: BorderRadius.circular(11)),
        child: Text(news.body, style: Theme.of(context).textTheme.headline3),
      ),
      const SizedBox(height: 20),
    ],
  );
}
