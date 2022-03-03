import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../utils/misc.dart';


class TermsPage extends StatelessWidget {
  static const route = "/terms_page";

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        translate("labels.terms"),
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

                Padding(child: Align(child: Text(translate("labels.productQuestions"),
                style: TextStyle(color: textColor2)
                ),
                  alignment: AlignmentDirectional.topStart,),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(30), bottom: SizeConfig().h(10)),
                ),

                Padding(child: Align(child: Container(child: Row(children: [
                  Flexible(child:
                  Text(translate("Product Questions Product Questions Product Questions Product Questions Product Questions Product Questions Product Questions Product Questions Product Questions Product Questions"), style: TextStyle(color: Colors.white)),)
                ],),),
    alignment: AlignmentDirectional.topStart,),
    padding: EdgeInsetsDirectional.only(
    start: SizeConfig().w(25),
    end: SizeConfig().w(25),
    top: SizeConfig().h(10), bottom: SizeConfig().h(10)),
    ),
                Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(20),
                        end: SizeConfig().w(10),
                        top: SizeConfig().h(10), bottom: SizeConfig().h(10)),
                    child: CustomButton(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: SizeConfig().h(60),
                        backColor: buttonColor1,
                        titleColor: Colors.white,
                        borderColor: buttonColor1,
                        title: translate("buttons.agreeTerms"),
                        onTap: () {
                          hideKeyboard(context);
                        })),

                Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(20),
                        end: SizeConfig().w(20),
                        top: SizeConfig().h(10), bottom: SizeConfig().h(10)),
                    child: CustomButton(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: SizeConfig().h(60),
                        backColor: backgroundColor1,
                        titleColor: buttonColor1,
                        borderColor: buttonColor1,
                        title: translate("buttons.declineTerms"),
                        onTap: () {
                          hideKeyboard(context);
                        })),
              ])),
              BackButtonWidget(context)
            ],)
      ),
    );
  }
}


