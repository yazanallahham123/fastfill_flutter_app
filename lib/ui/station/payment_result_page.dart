import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/payment/payment_result_body.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';


class PaymentResultPage extends StatelessWidget {
  static const route = "/payment_result_page";

  final PaymentResultBody paymentResultBody;

  const PaymentResultPage({Key? key, required this.paymentResultBody});

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
            Padding(padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(150), 0, 0),child:
              Column(children: [
                Stack(children: [


                  Container(
                    decoration:
                    BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
                    margin: EdgeInsetsDirectional.fromSTEB(25, 50, 25, 0),
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
                          Text(translate("labels.gasStation")+":", style: TextStyle(color: textColor2, fontSize: 14),),
                          Text(paymentResultBody.stationName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(30), SizeConfig().w(24), SizeConfig().h(10)),),

                      Padding(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("labels.date")+":", style: TextStyle(color: textColor2, fontSize: 14),),
                          Text(paymentResultBody.date, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), SizeConfig().h(30)),),

                    ],),)
                  ,
                  Align(
                    child: Padding(
                        child: Image(image: AssetImage(
                          (paymentResultBody.status) ? "assets/success.png" : "assets/fail.png",),
                          width: 100,
                          height: 100,),
                        padding: EdgeInsetsDirectional.only(
                            start: SizeConfig().w(25),
                            end: SizeConfig().w(25),
                            bottom: SizeConfig().h(25)
                        )),
                    alignment: AlignmentDirectional.topCenter,
                  ),
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
                    Text(translate("labels.choose")+":", style: TextStyle(color: textColor2, fontSize: 14),),
                    Text(paymentResultBody.fuelType, style: TextStyle(color: Colors.black, fontSize: 14),),
                  ],)
                  ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(35), SizeConfig().w(24), SizeConfig().h(10)),),


                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("labels.amount")+":", style: TextStyle(color: textColor2, fontSize: 14),),
                    Text(paymentResultBody.amount.toString(), style: TextStyle(color: Colors.black, fontSize: 14),),
                  ],)
                  ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), SizeConfig().h(10)),),

                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("labels.fastfill")+":", style: TextStyle(color: textColor2, fontSize: 14),),
                    Text(paymentResultBody.value.toString()+" "+translate("labels.sdg"), style: TextStyle(color: Colors.black, fontSize: 14),),
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
                        title: translate((paymentResultBody.status) ? "buttons.ok" : "buttons.tryAgain"),
                        onTap: () {
                          if (paymentResultBody.status)
                            Navigator.pushNamedAndRemoveUntil(context, HomePage.route, (Route<dynamic> route) => false);
                          else
                            Navigator.pop(context);
                        })),
              ])),


            ],)
          ),
        );
  }
}


