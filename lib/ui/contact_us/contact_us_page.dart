import 'dart:io';

import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUsPage extends StatelessWidget {
  static const route = "/contactus_page";
  static const whatsappNumber = "+15157085882";
  static const phoneNumber = "+249912267239";
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    SizeConfig().init(context);
    return Scaffold(
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
                        translate("labels.contactUs"),
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

                Padding(child: Align(child: Text(translate("labels.weAreInTouch"),
                    style: TextStyle(color: textColor2)
                ),
                  alignment: AlignmentDirectional.topStart,),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(30), bottom: SizeConfig().h(30)),
                ),

                Align(
                  child: Padding(
                      child:  SvgPicture.asset(
                        "assets/svg/contact_us.svg",
                        width: 100,
                        height: 100,),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          bottom: SizeConfig().h(25)
                      )),
                  alignment: AlignmentDirectional.topCenter,
                ),

                Padding(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(children: [
                    SvgPicture.asset(
                      "assets/svg/founder_icon.svg", width: 20, height: 20,),
                    Padding(child: Text(translate("labels.founder"), style: TextStyle(fontSize: 10, color: textColor2),), padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),)
                  ],),
                  Padding(child: Text("Amr Mohammed Osman", style: TextStyle(color: Colors.white),), padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),)
                    ,Divider(color: textColor2, thickness: 0.1,)
                ],), padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(10),
                    SizeConfig().w(25), SizeConfig().h(10)),),

                Padding(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        "assets/svg/email_icon.svg", width: 20, height: 20,),
                      Padding(child: Text(translate("labels.email"), style: TextStyle(fontSize: 10, color: textColor2),), padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),)
                    ],),
                    Padding(child: Text("Amr Mohammed Osman", style: TextStyle(color: Colors.white),), padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),)
                    ,Divider(color: textColor2, thickness: 0.1,)
                  ],), padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(10),
                    SizeConfig().w(25), SizeConfig().h(10)),),
                

                Padding(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        "assets/svg/email_icon.svg", width: 20, height: 20,),
                      Padding(child: Text(translate("labels.phone"), style: TextStyle(fontSize: 10, color: textColor2),), padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),)
                    ],),
                    Padding(child:
                    InkWell(child:

                    Text("+249 91 226 7239", style: TextStyle(color: Colors.white),)
                    ,onTap: (){
                        callNumber(phoneNumber);
                      },)
                      , padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),)
                    ,Divider(color: textColor2, thickness: 0.1,)
                  ],), padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(10),
                    SizeConfig().w(25), SizeConfig().h(10)),),

                Padding(child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      SvgPicture.asset(
                        "assets/svg/whatsapp_icon.svg", width: 20, height: 20,),
                      Padding(child: Text(translate("labels.whatsapp"), style: TextStyle(fontSize: 10, color: textColor2),), padding: EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),)
                    ],),
                    Padding(child:
    InkWell(child:
                    Text("+1 (515) 708-5882", style: TextStyle(color: Colors.white),),onTap: (){
      openWhatsapp(context, whatsappNumber);

    },)

    , padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),)
                    ,Divider(color: textColor2, thickness: 0.1,)
                  ],), padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(10),
                    SizeConfig().w(25), SizeConfig().h(10)),)
              ])),
              BackButtonWidget(context)
            ],)
      ),
    );
  }

  callNumber(String number) async {
    await launch("tel://"+number);
  }

  openWhatsapp(BuildContext context, String whatsappNumber) async{
    var whatsappURl_android = "whatsapp://send?phone="+whatsappNumber+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsappNumber?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }
}


