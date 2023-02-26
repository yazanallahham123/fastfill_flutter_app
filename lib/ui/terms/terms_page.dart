import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../utils/misc.dart';


class TermsPage extends StatefulWidget {
  static const route = "/terms_page";

  @override
  State<TermsPage> createState() => _TermsPageState();
}

bool agreementStatus = false;

class _TermsPageState extends State<TermsPage> {

  @override
  void initState() {
    super.initState();
     getAgreementStatus().then((v) {
       agreementStatus = v;
    });
  }

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
                        translate("terms.termsAndServicesTitle"),
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

                Padding(child: Align(child: Container(child: Row(children: [
                  Flexible(child:
                  Text(translate("terms.termsAndServicesContent"), style: TextStyle(color: Colors.white)),)
                ],),),

    alignment: AlignmentDirectional.topStart,),
    padding: EdgeInsetsDirectional.only(
    start: SizeConfig().w(25),
    end: SizeConfig().w(25),
    top: SizeConfig().h(10), bottom: SizeConfig().h(10)),
    ),


                Align(
                  child: Padding(
                      child: Text(
                        translate("terms.privacyPolicyTitle"),
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

                Padding(child: Align(child: Container(child: Row(children: [
                  Flexible(child:
                  Text(translate("terms.privacyPolicyContent"), style: TextStyle(color: Colors.white)),)
                ],),),

                  alignment: AlignmentDirectional.topStart,),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(10), bottom: SizeConfig().h(10)),
                ),

                Align(
                  child: Padding(
                      child: Text(
                        translate("terms.dataTitle"),
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

                Padding(child: Align(child: Container(child: Row(children: [
                  Flexible(child:
                  Text(translate("terms.dataContent"), style: TextStyle(color: Colors.white)),)
                ],),),

                  alignment: AlignmentDirectional.topStart,),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(10), bottom: SizeConfig().h(10)),
                ),

                Padding(child:
                Divider(color: buttonColor1, thickness: 0.5,), padding: EdgeInsetsDirectional.fromSTEB(25, 5, 25, 5),),
    Padding(child:

    Text(translate("terms.youAgreed"), style: TextStyle(color: buttonColor1),), padding: EdgeInsetsDirectional.fromSTEB(25, 5, 25, 15),)

                /*(!agreementStatus) ?
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
                        onTap: () async {

                          await setAgreementStatus(true);
                          if (mounted) {
                            setState(() {
                              agreementStatus = true;
                            });
                          }

                          Widget okButton = TextButton(
                            child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
                            onPressed:  () {
                              hideKeyboard(context);
                              Navigator.pop(context);
                            },
                          );


                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text(translate("terms.termsAndServicesTitle")),
                            content: Text(translate("terms.youSuccessfullyAgreedTerms")),
                            actions: [
                              okButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );

                          hideKeyboard(context);
                        })) : Container(),

                (!agreementStatus) ?
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
                        })) : Container(),*/
              ])),
              BackButtonWidget(context)
            ],)
      ),
    );
  }
}


