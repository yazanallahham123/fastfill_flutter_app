import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/payment/payment_result_body.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../model/user/user.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';


class PaymentResultPage extends StatelessWidget {
  static const route = "/payment_result_page";

  final PaymentResultBody paymentResultBody;

  const PaymentResultPage({Key? key, required this.paymentResultBody});



  User _buildUserInstance(AsyncSnapshot<User> snapshot) {
    if (snapshot.hasData && snapshot.data!.id != 0 && snapshot.data!.id != null)
      return snapshot.data!;
    return User();
  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: (paymentResultBody.fromList == false) ? backgroundColor1 : buttonColor1,
        body:
        SingleChildScrollView(
          child:
        FutureBuilder<User>(
    future: getCurrentUserValue(),
    builder: (context, AsyncSnapshot<User> snapshot) {
    User usr = _buildUserInstance(snapshot);

            return Stack(
              children: [
            Padding(padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(0), 0, 0),child:
              Column(children: [
                Stack(children: [
                  Container(
                    decoration:
                    BoxDecoration(color: (paymentResultBody.fromList == false) ? Colors.white : backgroundColor1, borderRadius: radiusAll20),
                    margin: EdgeInsetsDirectional.fromSTEB(25, 170, 25, 0),
                    child: Column(children: [
                      Align(
                        child: Padding(
                            child: Text(
                              translate("labels.customer_id") +
                                  " : " +
                              usr.id.toString()
                              ,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: backgroundColor1),
                            ),
                            padding: EdgeInsetsDirectional.only(
                              top: SizeConfig().h(60),
                              start: SizeConfig().w(25),
                              end: SizeConfig().w(25),
                            )),
                        alignment: AlignmentDirectional.topCenter,
                      ),

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
                            top: SizeConfig().h(10),
                            start: SizeConfig().w(25),
                            end: SizeConfig().w(25),
                          )),
                      alignment: AlignmentDirectional.topCenter,
                    ),

                      Padding(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("labels.gasStation")+":", style: TextStyle(color: (paymentResultBody.fromList == false) ? textColor2 : Colors.white, fontSize: 18),),
                          Flexible(child:
                          Text(paymentResultBody.stationName, style: TextStyle(color: (paymentResultBody.fromList == false) ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(30), SizeConfig().w(24), SizeConfig().h(10)),),

                      Padding(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("labels.amount")+":", style: TextStyle(color: (paymentResultBody.fromList == false) ? textColor2 : Colors.white, fontSize: 18),),
                          Text(formatter.format(paymentResultBody.amount-paymentResultBody.value)+" "+translate("labels.sdg"), style: TextStyle(color: (paymentResultBody.fromList == false) ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), (paymentResultBody.fromList == false) ? SizeConfig().w(10) : SizeConfig().w(30)),),

                      (paymentResultBody.fromList == false) ?
                      Padding(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(translate("labels.date")+":", style: TextStyle(color: (paymentResultBody.fromList == false) ? textColor2 : Colors.white, fontSize: 18),),
                          Text(paymentResultBody.date, style: TextStyle(color: (paymentResultBody.fromList == false) ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                        ],)
                        ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), SizeConfig().h(30)),)
                      : Container()
                      ,


                    ],),)
                  ,
                  Align(
                    child:
                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child:
                      Stack(children: [
                        (paymentResultBody.fromList) ? Container(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                            child: Align(child: Text(translate("labels.previousTransaction"), style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: backgroundColor1) ), alignment: AlignmentDirectional.topCenter,)) : Container(),
                    Image(
                      image: AssetImage(
                          (paymentResultBody.status) ? (paymentResultBody.fromList) ? "assets/checkmark_old.gif" : "assets/checkmark.gif" : "assets/fail.png",),),
                    ],),),
                    alignment: AlignmentDirectional.topCenter,
                  ),
                ],),



            Container(
                width: MediaQuery.of(context).size.width,
            margin: EdgeInsetsDirectional. only(top: SizeConfig().h(25), start: SizeConfig().w(25), end: SizeConfig().w(25)),

            decoration:
            BoxDecoration(color: (paymentResultBody.fromList == false) ? Colors.white : backgroundColor1, borderRadius: radiusAll20),
            child: Column(

              children: [

                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("labels.choice")+":", style: TextStyle(color: (paymentResultBody.fromList == false) ? textColor2 : Colors.white, fontSize: 18),),
                    Text((paymentResultBody.fuelTypeId == 1) ? translate("labels.gasoline"): translate("labels.benzine"), style: TextStyle(color: (paymentResultBody.fromList == false) ?Colors.black : Colors.white, fontSize: 18),),
                  ],)
                  ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(35), SizeConfig().w(24), SizeConfig().h(10)),),

                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("labels.fastfill")+":", style: TextStyle(color: (paymentResultBody.fromList == false) ? textColor2 : Colors.white , fontSize: 18),),
                    Text(formatter.format(paymentResultBody.value)+" "+translate("labels.sdg"), style: TextStyle(color: (paymentResultBody.fromList == false) ? Colors.black : Colors.white, fontSize: 18),),
                  ],)
                  ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), (paymentResultBody.fromList) ? SizeConfig().w(10) : SizeConfig().w(30)),),

                (paymentResultBody.fromList) ?
                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate("labels.date")+":", style: TextStyle(color: (paymentResultBody.fromList == false) ? textColor2 : Colors.white, fontSize: 18),),
                    Text(paymentResultBody.date, style: TextStyle(color: (paymentResultBody.fromList == false) ? Colors.black : Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  ],)
                  ,padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), SizeConfig().h(0), SizeConfig().w(24), SizeConfig().h(30)),)
                    : Container()


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
                        backColor: (paymentResultBody.fromList == false) ? buttonColor1 : backgroundColor1,
                        titleColor: Colors.white,
                        borderColor: (paymentResultBody.fromList == false) ? buttonColor1 : backgroundColor1,
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


            ],);})
          ),
        );
  }
}


