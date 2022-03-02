import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/payment/payment_result_body.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../utils/misc.dart';


class PaymentResultPage extends StatelessWidget {
  static const route = "/payment_result_page";

  final PaymentResultBody paymentResultBody;

  const PaymentResultPage({Key? key, required this.paymentResultBody});


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1 ,
        body:
        SingleChildScrollView(
          child:
            Stack(
              children: [
            Padding(padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(0), 0, 0),child:
              Column(children: [
                Stack(children: [
                  Container(
                    decoration:
                    BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
                    margin: EdgeInsetsDirectional.fromSTEB(25, 150, 25, 0),
                    child: Column(children: [
                    Align(
                      child: Padding(
                          child: Text(
                            (paymentResultBody.status) ?
                            translate("labels.successPayment") : translate("labels.failedPayment"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: buttonColor1),
                          ),
                          padding: EdgeInsetsDirectional.only(
                            top: SizeConfig().h(75),
                            start: SizeConfig().w(25),
                            end: SizeConfig().w(25),
                          )),
                      alignment: AlignmentDirectional.topCenter,
                    ),

                      Padding(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("labels.gasStation")+":", style: TextStyle(color: textColor2, fontSize: 18),),
                          Text(paymentResultBody.stationName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(30), SizeConfig().w(24), SizeConfig().h(10)),),

                      Padding(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("labels.amount")+":", style: TextStyle(color: textColor2, fontSize: 18),),
                          Text(formatter.format(paymentResultBody.amount-paymentResultBody.value)+" "+translate("labels.sdg"), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), SizeConfig().h(10)),),

                      Padding(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("labels.date")+":", style: TextStyle(color: textColor2, fontSize: 18),),
                          Text(paymentResultBody.date, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), SizeConfig().h(30)),),

                    ],),)
                  ,
                  Align(
                    child:
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child:
                    Image(
                      image: AssetImage(
                          (paymentResultBody.status) ? "assets/checkmark.gif" : "assets/checkmark.gif",),),
                    alignment: AlignmentDirectional.topCenter,
                  )),
                ],),



            Container(
                width: MediaQuery.of(context).size.width,
            margin: EdgeInsetsDirectional. only(top: SizeConfig().h(25), start: SizeConfig().w(25), end: SizeConfig().w(25)),

            decoration:
            BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
            child: Column(

              children: [

                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("labels.choice")+":", style: TextStyle(color: textColor2, fontSize: 18),),
                    Text((paymentResultBody.fuelTypeId == 1) ? translate("labels.gasoline"): translate("labels.benzine"), style: TextStyle(color: Colors.black, fontSize: 18),),
                  ],)
                  ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(35), SizeConfig().w(24), SizeConfig().h(10)),),

                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("labels.fastfill")+":", style: TextStyle(color: textColor2, fontSize: 18),),
                    Text(formatter.format(paymentResultBody.value)+" "+translate("labels.sdg"), style: TextStyle(color: Colors.black, fontSize: 18),),
                  ],)
                  ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), SizeConfig().w(30)),),


              ],),


            ),

                Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(25),
                        end: SizeConfig().w(25),
                        top: SizeConfig().h(30), bottom: SizeConfig().h(35)),
                    child: CustomButton(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: SizeConfig().h(60),
                        backColor: buttonColor1,
                        titleColor: Colors.white,
                        borderColor: buttonColor1,
                        title: translate((paymentResultBody.fromList) ? "buttons.back" : (paymentResultBody.status) ? "buttons.ok" : "buttons.tryAgain"),
                        onTap: () {
                          hideKeyboard(context);
                          if (!paymentResultBody.fromList) {
                            if (paymentResultBody.status)
                              Navigator.pushNamedAndRemoveUntil(context,
                                  HomePage.route, (
                                      Route<dynamic> route) => false);
                            else
                              Navigator.pop(context);
                          }
                          else
                            {Navigator.pop(context);}

                        })),
              ])),


            ],)
          ),
        );
  }
}


