import 'package:flutter/material.dart';
import 'package:lamp/app/models/articles_model.dart';
import 'package:lamp/app/providers/articles_provider/articles_provider.dart';
import 'package:lamp/app/utils/int_extension.dart';
import 'package:lamp/common_widgets/buttons/button.dart';
import 'package:lamp/routing/routes.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_bar/app_bar.dart';
import '../../../common_widgets/loader/lamp_loader.dart';
import '../../../theme/color_helper.dart';
import '../../models/article_model.dart';

class ArticlesDetailsPage extends StatefulWidget {
  @override
  State<ArticlesDetailsPage> createState() => _ArticlesDetailsPageState();
}

class _ArticlesDetailsPageState extends State<ArticlesDetailsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Lamp_LoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> _getInitialData() async {
    await context.read<ArticlesProvider>().getAwardDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return Lamp_AppBarIconTitleIcon(
    context,
    onActionPressed: null,
    implyAction: false,
    centerTitle: true,
    onLeadingPressed: () => Navigator.of(context).pop(),
    leadingIcon: Icons.arrow_back_ios,
    leadingIconColor: ColorHelper.lampGray.color,
  );
}

Widget _buildBody(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    shrinkWrap: true,
    children: <Widget>[
      const SizedBox(height: 20),
      _returnArticleCard(context),
      const SizedBox(height: 20),
      _button(context),
    ],
  );
}

Widget _button(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child:
        Lamp_Button(onPressed: () => Navigator.of(context).pushNamed(articleBuy, arguments: context.read<ArticlesProvider>()), buttonTitle: 'Kupi'),
  );
}

Widget _returnArticleCard(BuildContext context) {
  final ArticleModel a = context.read<ArticlesProvider>().articleDetail;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(color: ColorHelper.black.color.withOpacity(0.17), blurRadius: 10, blurStyle: BlurStyle.normal),
      ],
    ),
    child: Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: Image.network(
                a.image.isNotEmpty ? a.image[0] : '',
                fit: BoxFit.cover,
                width: 400,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      child: Image.asset('assets/lampica_logo.png', fit: BoxFit.contain),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(a.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 20, color: ColorHelper.lampGray.color)),
                  const SizedBox(height: 4),
                  Text('Dostupno komada: ${a.quantity}',
                      style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14, fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: <Widget>[
                  Image.asset('assets/lampica_logo.png', height: 50, width: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${a.creditAmount} ${a.creditAmount.returnPoints()}', style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                      Text('${a.priceAmount} KM', style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    ),
  );
}
