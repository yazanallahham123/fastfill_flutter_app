import 'dart:io';
import 'dart:math';

import 'package:fastfill/bloc/login/bloc.dart';
import 'package:fastfill/bloc/login/event.dart';
import 'package:fastfill/bloc/login/state.dart';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/event.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/app_widgets/favorite_button.dart';
import 'package:fastfill/common_widgets/app_widgets/new_station_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/methods.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/textfield_password_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_sizes.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/font_styles.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/station/add_remove_station_favorite_body.dart';
import 'package:fastfill/model/station/payment_transaction_body.dart';
import 'package:fastfill/model/station/payment_transaction_result.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/streams/add_remove_favorite_stream.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/ui/station/payment_result_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

import '../../model/payment/payment_result_body.dart';
import '../../model/station/station.dart';
import '../../model/user/user.dart';
import '../../utils/misc.dart';


enum FuelType {Benzine, Gasoline}

class PurchasePage extends StatefulWidget {
  static const route = "/purchase_page";

  final Station station;

  const PurchasePage({Key? key, required this.station})
      : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePage(this.station);
}

bool isAddedToFavorite = false;
PaymentResultBody? prb = null;
bool paying = false;
double userBalance = 0.0;

class _PurchasePage extends State<PurchasePage> {

  final Station station;
  _PurchasePage(this.station){
    isAddedToFavorite = this.station.isFavorite ?? false;
    paying = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) => StationBloc(),//.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is AddedStationToFavorite)
            {
              if (mounted) {
                setState(() {
                  isAddedToFavorite = true;
                  Station s = Station(id: station.id,
                  arabicName: station.arabicName,
                    englishName:  station.englishName,
                    arabicAddress: station.arabicAddress,
                    englishAddress: station.englishAddress,
                    code: station.code,
                    longitude: station.longitude,
                    latitude: station.latitude,
                      isFavorite: isAddedToFavorite
                  );

                  addRemoveFavoriteStreamController.sink.add(s);

                });
              }

            }
          else if (state is RemovedStationFromFavorite)
            {
              if (mounted) {
                setState(() {
                  isAddedToFavorite = false;
                  Station s = Station(id: station.id,
                      arabicName: station.arabicName,
                      englishName:  station.englishName,
                      arabicAddress: station.arabicAddress,
                      englishAddress: station.englishAddress,
                      code: station.code,
                      longitude: station.longitude,
                      latitude: station.latitude,
                      isFavorite: isAddedToFavorite
                  );

                  addRemoveFavoriteStreamController.sink.add(s);
                });
              }

            }
          else if (state is AddedPaymentTransaction)
            {
              if (!state.balanceNotEnough) {
                PaymentResultBody p = PaymentResultBody(
                    date: prb!.date,
                    stationName: prb!.stationName,
                    fuelTypeId: prb!.fuelTypeId,
                    amount: prb!.amount,
                    status: state.addPaymentTransactionResult,
                    fromList: false,
                    value: prb!.value
                );
                if (mounted) {
                  setState(() {
                    paying = false;
                  });
                }
                Navigator.pushNamed(
                    context, PaymentResultPage.route, arguments: p);
              }
              else
                {
                  if (mounted) {
                    setState(() {
                      paying = false;
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
                    title: Text(translate("labels.noBalance")),
                    content: Text(translate("labels.noEnoughBalance")),
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
                }
            }
        }

        ,
        bloc: bloc,
        child: BlocBuilder<StationBloc, StationState>(
            bloc: bloc,
            builder: (context, StationState state) {
              return BuildUI(bloc: bloc, state: state, station: station,);
            }));
  }
}

class BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;
  final Station station;

  const BuildUI({Key? key, required this.bloc, required this.state, required this.station})
      : super(key: key);

  @override
  State<BuildUI> createState() => _BuildUI(this.bloc, this.state, this.station);
}



class _BuildUI extends State<BuildUI> {
  final StationBloc bloc;
  final StationState state;
  final Station station;
  final amountNode = FocusNode();
  final confirmAmountNode = FocusNode();

  _BuildUI(this.bloc,this.state,this.station);

  final amountController = TextEditingController();
  final confirmAmountController = TextEditingController();

  FuelType _fuelTypeValue = FuelType.Benzine;

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1 ,
        body:
        KeyboardActions(
            config: _buildConfig(context),
            child: SingleChildScrollView(
                  child:
          Stack(children: [
            Padding(padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(110), 0, 0),
            child: 
            Column(
              children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.chooseFuel"),
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

                NewStationWidget(station: station, hideFavorite: true, openPurchaseOnClick: false,),

                Align(child: Padding(child: Text(translate("labels.choose"), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),), padding: EdgeInsetsDirectional.only(top: SizeConfig().h(20),
                start:SizeConfig().w(20),
                  bottom: SizeConfig().h(10)
                )),
                alignment: AlignmentDirectional.topStart,
                ),

                Padding(child:
                InkWell(
                    onTap: () {
                      hideKeyboard(context);
                      if (mounted) {
                        setState(() {
                          _fuelTypeValue = FuelType.Benzine;
                        });
                      }
                    },
                    child:
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: radiusAll14,
                        color: Colors.white
                    ),
                    child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(child: Text(translate("labels.benzine"), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(10), 0, SizeConfig().w(10), 0),),
                  Radio(onChanged: (x){
                    if (mounted) {
                      setState(() {
                        _fuelTypeValue = FuelType.Benzine;
                      });
                    }
                  },
                    value: FuelType.Benzine,
                    groupValue: _fuelTypeValue,
                  activeColor: buttonColor1,
                    fillColor: MaterialStateColor.resolveWith((states) => buttonColor1),
                    overlayColor: MaterialStateColor.resolveWith((states) => buttonColor1),
                  ),

                ],))),
                padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), 0, SizeConfig().w(20), SizeConfig().h(10)),
                )
                ,

                Padding(child:
                InkWell(
                    onTap: () {
                      hideKeyboard(context);
                      if (mounted) {
                        setState(() {
                          _fuelTypeValue = FuelType.Gasoline;
                        });
                      }
                    },
                    child:
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1),
                        borderRadius: radiusAll14,
                        color: Colors.white
                    ),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(child: Text(translate("labels.gasoline"), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(10), 0, SizeConfig().w(10), 0),),
                      Radio(onChanged: (x){
                        if (mounted) {
                          setState(() {
                            _fuelTypeValue = FuelType.Gasoline;
                          });
                        }
                      },
                        value: FuelType.Gasoline,
                        groupValue: _fuelTypeValue,
                        activeColor: buttonColor1,
                        fillColor: MaterialStateColor.resolveWith((states) => buttonColor1),
                        overlayColor: MaterialStateColor.resolveWith((states) => buttonColor1),
                      ),

                    ],))),
                  padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), 0, SizeConfig().w(20), 0),
                ),

                Align(child: Padding(child: Text(translate("labels.amount"), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    padding: EdgeInsetsDirectional.only(top: SizeConfig().h(10),
                    start:SizeConfig().w(20),
                    bottom: SizeConfig().h(10),

                )),
                  alignment: AlignmentDirectional.topStart,
                ),

                Padding(
                    padding:
                    EdgeInsetsDirectional.only(
                        start: SizeConfig().w(20), end: SizeConfig().w(20)),
                    child: CustomTextFieldWidget(
                        style: largeMediumPrimaryColor4(),
                        hintStyle: smallCustomGreyColor6(),
                        textFormatter: ThousandsSeparatorInputFormatter(),
                        color: backgroundColor3,
                        controller: amountController,
                        focusNode: amountNode,
                        validator: validateAmount,
                        hintText: translate("labels.amount"),
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(confirmAmountNode);
                        })),
                Align(child: Padding(child: Text(translate("labels.confirmAmount"),
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    padding: EdgeInsetsDirectional.only(start:SizeConfig().w(20), bottom: SizeConfig().h(10),

                )),
                  alignment: AlignmentDirectional.topStart,
                ),
                Padding(
                    padding:
                    EdgeInsetsDirectional.only(start: SizeConfig().w(20), end: SizeConfig().w(20)),
                    child: CustomTextFieldWidget(
                        style: largeMediumPrimaryColor4(),
                        hintStyle: smallCustomGreyColor6(),
                        textFormatter: ThousandsSeparatorInputFormatter(),
                        color: backgroundColor3,
                        controller: confirmAmountController,
                        focusNode: confirmAmountNode,
                        validator: validateAmount,
                        hintText: translate("labels.confirmAmount"),
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (_) {
                          hideKeyboard(context);
                        })),

                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(child: Text(translate("labels.fastfill"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      padding: EdgeInsetsDirectional.only(bottom: SizeConfig().h(10),

                      )),

                  Padding(child: Text(formatter.format(100.0)+" "+translate("labels.sdg"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      padding: EdgeInsetsDirectional.only(bottom: SizeConfig().h(10),

                      )),

                ],),padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), 0, SizeConfig().w(20), 0),),

                Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(20),
                        end: SizeConfig().w(20),
                        top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                    child: (paying) ? CustomLoading() : CustomButton(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: SizeConfig().h(60),
                        backColor: buttonColor1,
                        titleColor: Colors.white,
                        borderColor: buttonColor1,
                        title: translate("buttons.pay"),
                        onTap: () {

                            pay();
                        })),

              ],),),

                BackButtonWidget(context),

              ],)
            )),
        );
  }

  pay()
  async {
    if (amountController.text == confirmAmountController.text) {
      if (double.tryParse(amountController.text.replaceAll(",", "")) != null) {
        if (double.parse(amountController.text.replaceAll(",", "")) > 0.0) {
          if (double.parse(amountController.text.replaceAll(",", "")) >= 100) {
            if (mounted) {
              setState(() {
                paying = true;
              });
            }
            hideKeyboard(context);

            prb = PaymentResultBody(
                date: DateFormat('yyyy-MM-dd - hh:mm a').format(DateTime.now()),
                stationName: (isArabic())
                    ? widget.station.arabicName!
                    : widget
                    .station.englishName!,
                status: true,
                fuelTypeId: (_fuelTypeValue == FuelType.Gasoline) ? 1 : 2,
                amount: (double.tryParse(
                    amountController.text.replaceAll(",", "")) ?? 0.0),
                value: 100.0,
                fromList: false
            );

            User user = await LocalData().getCurrentUserValue();

            PaymentTransactionBody paymentTransactionBody = PaymentTransactionBody(
                userId: user.id,
                amount: (double.tryParse(
                    amountController.text.replaceAll(",", "")) ?? 0.0),
                fastfill: 100.0,
                fuelTypeId: (_fuelTypeValue == FuelType.Gasoline) ? 1 : 2,
                status: true,
                date: DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now()),
                companyId: widget.station.id
            );


            bloc.add(AddPaymentTransaction(paymentTransactionBody));
          }
          else
            {
              pushToast(translate("messages.minimumPaymentAmount"));
            }
        }
        else
          {
            pushToast(translate("messages.amountMustBeMoreThanZero"));
          }
      }
      else
        pushToast(translate("messages.amountMustBeMoreThanZero"));
    }
    else
      pushToast(translate("messages.confirmAmountPlease"));
  }

  KeyboardActionsConfig _buildConfig(BuildContext context){
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: amountNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(confirmAmountNode);
                }
                ,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(translate("buttons.next"), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            }
          ]),

          KeyboardActionsItem(focusNode: confirmAmountNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  hideKeyboard(context);
                }
                ,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(translate("buttons.done"), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            }
          ]),
        ]);
  }
}


