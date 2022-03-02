import 'dart:io';
import 'dart:math';

import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/ui/auth/login_page.dart';
import 'package:fastfill/ui/contact_us/contact_us_page.dart';
import 'package:fastfill/ui/language/language_page.dart';
import 'package:fastfill/ui/terms/terms_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../main.dart';
import '../../utils/misc.dart';


class SettingsPage extends StatefulWidget {
  static const route = "/settings_page";

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool receiveNotifications = false;

  @override
  void initState() {
    super.initState();
    LocalData().getReceiveNotifications().then((v){
      setState(() {
        receiveNotifications = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    SizeConfig().init(context);



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor1 ,
      body:
      SingleChildScrollView(
          child:
          Stack(
            children: [
              Padding(padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(120), 0, 0),child:
              Column(children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.settings"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(25),
                        end: SizeConfig().w(25),
                      )),
                  alignment: AlignmentDirectional.topStart,
                ),


                Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsetsDirectional. only(top: SizeConfig().h(20), start: SizeConfig().w(20), end: SizeConfig().w(20)),
                padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
                decoration:
                BoxDecoration(color: backgroundColor3, borderRadius: radiusAll20),
                child: Column(children: [
                  Padding(child: Align(child: Text(translate("labels.applicationSettings"),
                      style: TextStyle(color: textColor2)
                  ),
                    alignment: AlignmentDirectional.topStart,),
                    padding: EdgeInsetsDirectional.only(
                        top: SizeConfig().h(30),
                        end: SizeConfig().w(25),
                        bottom: SizeConfig().h(15)),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(translate("labels.notifications"), style: TextStyle(color: Colors.white),),

                    Switch(
                      activeColor: buttonColor1,
                      inactiveTrackColor: textColor2,
                      onChanged: (bool value) {
                        hideKeyboard(context);
                        if (receiveNotifications) {
                          if (mounted) {
                            setState(() {
                              receiveNotifications = false;
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              receiveNotifications = true;
                            });
                          }
                        }

                        LocalData().setReceiveNotifications(receiveNotifications);
                      }

                      , value: receiveNotifications,)

                  ],),

                  Divider(color: Colors.black, thickness: 0.1,),

                  InkWell(child:
                  Padding(child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(translate("labels.language"), style: TextStyle(color: Colors.white),),

                      Row(children: [
                        Text((isArabic() ? "عربي" : "English"), style: TextStyle(color: Colors.white),),
                        Padding(child:

                        (isArabic()) ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child:

                            SvgPicture.asset(
                              "assets/svg/arrow.svg", width: 20, height: 20,)) : SvgPicture.asset(
                          "assets/svg/arrow.svg", width: 20, height: 20,)

                          ,padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),)

                      ],)
                    ],),padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 25),),onTap: () async {

                    hideKeyboard(context);
                    String? l = await Navigator.pushNamed(
                        context, LanguagePage.route, arguments: true) as String?;

                    if (l != null) {
                      if (mounted) {
                        setState(() {
                          languageCode = l;
                        });
                      }
                    }
                  },)

                ],),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsetsDirectional. only(top: SizeConfig().h(20), start: SizeConfig().w(20), end: SizeConfig().w(20)),
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
                  decoration:
                  BoxDecoration(color: backgroundColor3, borderRadius: radiusAll20),
                  child: Column(children: [
                    Padding(child: Align(child: Text(translate("labels.support"),
                        style: TextStyle(color: textColor2)
                    ),
                      alignment: AlignmentDirectional.topStart,),
                      padding: EdgeInsetsDirectional.only(
                          top: SizeConfig().h(30), bottom: SizeConfig().h(10)),
                    ),

                    Padding(child:
                    InkWell(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translate("labels.terms"), style: TextStyle(color: Colors.white),),

                        Padding(child:
                        (isArabic()) ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child:

                            SvgPicture.asset(
                              "assets/svg/arrow.svg", width: 20, height: 20,)) : SvgPicture.asset(
                          "assets/svg/arrow.svg", width: 20, height: 20,)

                          ,padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),)

                      ],), onTap: () {
                      hideKeyboard(context);
                      Navigator.pushNamed(context, TermsPage.route);

                    },),padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),),


                    Divider(color: Colors.black, thickness: 0.1,),

                    Padding(child:
                    InkWell(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(translate("labels.contactUs"), style: TextStyle(color: Colors.white),),

                        Padding(child:
    (isArabic()) ? Transform(
    alignment: Alignment.center,
    transform: Matrix4.rotationY(pi),
                        child:

                        SvgPicture.asset(
                          "assets/svg/arrow.svg", width: 20, height: 20,)) : SvgPicture.asset(
      "assets/svg/arrow.svg", width: 20, height: 20,)

                          ,padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),)
                      ],), onTap: () {
                      hideKeyboard(context);
                      Navigator.pushNamed(context, ContactUsPage.route);
                    },),padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 25),)

                  ],),
                ),

                Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(20),
                        end: SizeConfig().w(20),
                        top: SizeConfig().h(30), bottom: SizeConfig().h(35)),
                    child: CustomButton(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: SizeConfig().h(60),
                        backColor: Colors.white,
                        titleColor: Colors.black,
                        borderColor: Colors.white,
                        title: translate("buttons.logOut"),
                        onTap: () async {
                          hideKeyboard(context);
                          showLogoutAlertDialog(context);

                        })),

              ])),
              BackButtonWidget(context)
            ],)
      ),
    );
  }
}


