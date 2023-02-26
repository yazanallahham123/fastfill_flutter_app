import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../bloc/user/event.dart';
import '../../model/station/station.dart';
import '../../model/syberPay/syber_pay_get_url_body.dart';
import '../../model/user/user.dart';
import '../../ui/station/purchase_page.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';
import '../custom_text_field_widgets/custom_textfield_widget.dart';
import 'favorite_button.dart';
import 'package:crypto/crypto.dart';

class HomeBoxWidget extends StatefulWidget{

  final StationBloc stationBloc;
  final StationState stationState;
  final double userBalance;
  const HomeBoxWidget({required this.stationBloc, required this.stationState, required this.userBalance});

  @override
  State<HomeBoxWidget> createState() => _HomeBoxWidgetState();
}

User _buildUserInstance(AsyncSnapshot<User> snapshot) {
  if (snapshot.hasData && snapshot.data!.id != 0 && snapshot.data!.id != null)
    return snapshot.data!;
  return User();
}

class _HomeBoxWidgetState extends State<HomeBoxWidget> {

  @override
  void initState() {

    notificationsController.stream.listen((notificationBody) {
      hideKeyboard(context);
      widget.stationBloc.add(GetUserBalanceInStationEvent());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsetsDirectional.fromSTEB(25, 15, 25, 15),
        margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/home_box.png"),
                fit: BoxFit.fill
            )
        ),
        child:
        FutureBuilder<User>(
            future: getCurrentUserValue(),
            builder: (context, AsyncSnapshot<User> snapshot) {
              User usr = _buildUserInstance(snapshot);
              if (usr.id != null) {
                return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          child: Padding(
                            child: AutoSizeText(
                              usr.firstName!,
                              maxLines: 1,
                              style: TextStyle(
                                  color: backgroundColor1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            padding: EdgeInsetsDirectional.only(
                                start: SizeConfig().w(20),
                                end: SizeConfig().w(20),
                                top: SizeConfig().h(25)),
                          ),
                          alignment: AlignmentDirectional.topStart,
                        ),
                        Align(
                          child: Padding(
                            child: (widget.stationState is LoadingStationState) ? CustomLoading() : Text(
                              translate("labels.balance") +
                                  " : " +
                                  formatter.format(widget.userBalance) +
                                  " " +
                                  translate("labels.sdg"),
                              style: TextStyle(
                                  color: backgroundColor1, fontSize: 20),
                            ),
                            padding: EdgeInsetsDirectional.only(
                                start: SizeConfig().w(20),
                                end: SizeConfig().w(20),
                                top: SizeConfig().h(5)),
                          ),
                          alignment: AlignmentDirectional.topStart,
                        ),


                        Container(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 2),
                          margin: EdgeInsetsDirectional.fromSTEB(5, 15, 5, 5),
                          decoration: BoxDecoration(
                            borderRadius: radiusAll10,
                            border: Border.all(color: Colors.white, width: 0.5),
                            color: Colors.white30,),
                          child:
                          (widget.stationState is LoadingStationState) ?

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                SizedBox(
                                    child: CustomLoading(),
                                width: 25,
                                  height: 25,
                                )
                          ],)
                              :

                          InkWell(child:

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Icon(Icons.payment),
                              /*Image.asset(
                                'assets/syber_pay_icon.png',
                                width: SizeConfig().w(40),
                                height: SizeConfig().h(40),
                              ),*/
                              Text(
                                translate("labels.refillAccount"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: backgroundColor1),
                              ),
                            ],), onTap: (){
                            _topUp();
                          },),),

                        Align(
                          child: Padding(
                            child: Text(
                              translate("labels.customer_id") +
                                  " : " +
                                  usr.id.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  color: backgroundColor1, fontSize: 18),
                            ),
                            padding: EdgeInsetsDirectional.only(
                              top: SizeConfig().h(10),
                              bottom: SizeConfig().h(12),),
                          ),
                          alignment: AlignmentDirectional.center,
                        ) ,


                      ],
                    ));
              } else {
                return CustomLoading();
              }
            })
      );
  }


  _topUp()
  {
    final amountToRefillController = TextEditingController();
    final amountToRefillFocusNode = FocusNode();

    Widget cancelButton = TextButton(
      child: Text(translate("buttons.cancel"), style: TextStyle(color: Colors.black),),
      onPressed:  () {
        hideKeyboard(context);
        Navigator.pop(context);
      },
    );

    Widget okButton = TextButton(
      child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
      onPressed:  () async {
        hideKeyboard(context);
        Navigator.pop(context);
        await calcHashAndGetSyberPayUrl(double.parse(amountToRefillController.text));
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(translate("labels.refillPopupTitle")),
      content: Padding(
          child: CustomTextFieldWidget(
            focusNode: amountToRefillFocusNode,
            controller: amountToRefillController,
            hintText:
            translate("labels.amount"),
            textInputType: TextInputType.numberWithOptions(signed: false, decimal: true),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) async {
              hideKeyboard(context);
              if (amountToRefillController.text.trim() != "")
                await calcHashAndGetSyberPayUrl(double.parse(amountToRefillController.text));
            },
          ),
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig().w(30),
            end: SizeConfig().w(30),
            top: SizeConfig().h(15),
            bottom: SizeConfig().h(0),)),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


  }

  calcHashAndGetSyberPayUrl(double topUpAmount)
  async {
    if (topUpAmount > 0) {
      User u = await getCurrentUserValue();
      String key =  r"f@$tf!llK3y";
      String salt =  r"f@$tf!ll$@lt";
      String applicationId = r'f@$tf!llApp';//"0000000361";
      String serviceId = r"f@$tf!ll267";
      String amount = topUpAmount.toString();
      String currency = "SDG";
      String customerRef = u.firstName!;
      String all = key + "|" + applicationId + "|" + serviceId + "|" + amount +
          "|" + currency + "|" + customerRef + "|" + salt;
      var AllInBytes = utf8.encode(all);
      String value = sha256.convert(AllInBytes).toString();

      SyberPayGetUrlBody spgub = SyberPayGetUrlBody(
          applicationId: applicationId,
          serviceId: serviceId,
          amount: topUpAmount,
          currency: currency,
          customerRef: customerRef,
          hash: value);

      if (!widget.stationBloc.isClosed)
        widget.stationBloc.add(Station_GetSyberPayUrlEvent(spgub));
    }
  }
}


