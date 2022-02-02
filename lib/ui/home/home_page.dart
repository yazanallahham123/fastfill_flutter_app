import 'package:fastfill/common_widgets/custom_app_bar/home_appbar_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/ui/home/transactions_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'favorites_tab_page.dart';
import 'home_tab_page.dart';
import 'notifications_tab_page.dart';


class HomePage extends StatefulWidget {
  static const route = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int pageIndex = 0;

  final pages = [
    const HomeTabPage(),
    const TransactionsTabPage(),
    const NotificationsTabPage(),
    const FavoritesTabPage(),
  ];

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundColor1,
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor2,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: Container(
                //alignment: Alignment.topLeft,
                  height: SizeConfig().h(60),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/homebutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 0) ? activeTabColor : notActiveTabColor,
                  )),
            ),

            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: Container(
                //alignment: Alignment.topLeft,
                  height: SizeConfig().h(60),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/transactionsbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 1) ? activeTabColor : notActiveTabColor,
                  )),
            ),

            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              child: Container(
                //alignment: Alignment.topLeft,
                  height: SizeConfig().h(60),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/notificationsbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 2) ? activeTabColor : notActiveTabColor,
                  )),
            ),

            InkWell(
              onTap: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              child: Container(
                //alignment: Alignment.topLeft,
                  height: SizeConfig().h(60),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/favoritesbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 3) ? activeTabColor : notActiveTabColor,
                  )),
            )
          ],
        ),
      ),

      appBar: new HomeAppBarWidget(),
      body: pages[pageIndex]
    );
  }
}

