import 'dart:io';

import 'package:fastfill/common_widgets/custom_app_bar/home_appbar_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/ui/home/transactions_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../utils/misc.dart';
import 'favorites_tab_page.dart';
import 'home_tab_page.dart';
import 'new_notifications_tab_page.dart';
import 'new_transactions_tab_page.dart';
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
    const NewTransactionsTabPage(),
    const NewNotificationsTabPage(),
    const FavoritesTabPage(),
  ];



  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor1,
      bottomNavigationBar: Container(
        height: 62,
        decoration: BoxDecoration(
          color: backgroundColor2,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: InkWell(
              onTap: () {
                setState(() {
                  hideKeyboard(context);
                  pageIndex = 0;
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(25, 5, 10, 15),
                //alignment: Alignment.topLeft,
                  height: SizeConfig().h(45),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/homebutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 0) ? activeTabColor : notActiveTabColor,
                  )),
            ), flex: 1,),

            Expanded(child: InkWell(
              onTap: () {
                setState(() {
                  hideKeyboard(context);
                  pageIndex = 1;
                });
              },
              child: Container(
                //alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                  ),

                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 15),
                  height: SizeConfig().h(45),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/transactionsbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 1) ? activeTabColor : notActiveTabColor,
                  )),
            ),flex: 1,),

            Expanded(child: InkWell(
              onTap: () {
                setState(() {
                  hideKeyboard(context);
                  pageIndex = 2;
                });
              },
              child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 15),
                //alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                  ),

                  height: SizeConfig().h(55),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/notificationsbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 2) ? activeTabColor : notActiveTabColor,
                  )),
            ),flex: 1,),

            Expanded(child: InkWell(
              onTap: () {
                setState(() {
                  hideKeyboard(context);
                  pageIndex = 3;
                });
              },
              child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 15),
                //alignment: Alignment.topLeft,
                  height: SizeConfig().h(45),
                  width: SizeConfig().w(25),
                  child: SvgPicture.asset(
                    'assets/svg/favoritesbutton.svg',
                    width: SizeConfig().w(25),
                    color: (pageIndex == 3) ? activeTabColor : notActiveTabColor,
                  )),
            ),flex: 1,)
          ],
        ),
      ),

      appBar: new HomeAppBarWidget(),
      body: pages[pageIndex]
    );
  }
}

