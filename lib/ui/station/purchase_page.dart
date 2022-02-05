import 'dart:io';
import 'dart:math';

import 'package:fastfill/bloc/login/bloc.dart';
import 'package:fastfill/bloc/login/event.dart';
import 'package:fastfill/bloc/login/state.dart';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/app_widgets/favorite_button.dart';
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
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/ui/station/payment_result_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';


enum FuelType {Benzine, Gasoline}

class PurchasePage extends StatefulWidget {
  static const route = "/purchase_page";

  final StationBranch stationBranch;

  const PurchasePage({Key? key, required this.stationBranch})
      : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePage(this.stationBranch);
}

class _PurchasePage extends State<PurchasePage> {

  final StationBranch stationBranch;
  _PurchasePage(this.stationBranch);

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
        },
        bloc: bloc,
        child: BlocBuilder<StationBloc, StationState>(
            bloc: bloc,
            builder: (context, StationState state) {
              return BuildUI(bloc: bloc, state: state, stationBranch: stationBranch,);
            }));
  }
}

class BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;
  final StationBranch stationBranch;

  const BuildUI({Key? key, required this.bloc, required this.state, required this.stationBranch})
      : super(key: key);

  @override
  State<BuildUI> createState() => _BuildUI(this.bloc, this.state, this.stationBranch);
}

class _BuildUI extends State<BuildUI> {
  final StationBloc bloc;
  final StationState state;
  final StationBranch stationBranch;

  _BuildUI(this.bloc,this.state,this.stationBranch);

  final amountController = TextEditingController();
  final confirmAmountController = TextEditingController();

  final amountNode = FocusNode();
  final confirmAmountNode = FocusNode();

  FuelType _fuelTypeValue = FuelType.Benzine;

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

                Stack(children: [
                  (isArabic()) ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: Image(
                          image: AssetImage("assets/station_row.png"))) :
                  Image(image: AssetImage("assets/station_row.png")),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Padding(child: Text(stationBranch.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), padding:
                    EdgeInsetsDirectional.only(
                        start: SizeConfig().w(40),
                        end: SizeConfig().w(40),
                        top: SizeConfig().w(20))
                      ,),
                    Padding(child: Text(stationBranch.address!, style: TextStyle(fontSize: 16),), padding:
                    EdgeInsetsDirectional.only(
                      start: SizeConfig().w(40),
                      end: SizeConfig().w(40),
                    )
                      ,),
                    Padding(child: Text(stationBranch.number!, style: TextStyle(fontSize: 16),), padding:
                    EdgeInsetsDirectional.only(
                      start: SizeConfig().w(40),
                      end: SizeConfig().w(40),
                    )
                      ,),
                  ],)],),

                Align(child: Padding(child: Text(translate("labels.choose"), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),), padding: EdgeInsetsDirectional.only(top: SizeConfig().h(20),
                start:SizeConfig().w(20),
                  bottom: SizeConfig().h(10)
                )),
                alignment: AlignmentDirectional.topStart,
                ),

                Padding(child:
                InkWell(
                    onTap: () {
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
                        color: backgroundColor3,
                        controller: amountController,
                        focusNode: amountNode,
                        validator: validateMobile,
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
                        color: backgroundColor3,
                        controller: confirmAmountController,
                        focusNode: confirmAmountNode,
                        validator: validateMobile,
                        hintText: translate("labels.confirmAmount"),
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (_) {
                          pay();
                        })),

                Padding(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(child: Text(translate("labels.fastfill"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      padding: EdgeInsetsDirectional.only(bottom: SizeConfig().h(10),

                      )),

                  Padding(child: Text(translate("10.0")+" "+translate("labels.sdg"),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      padding: EdgeInsetsDirectional.only(bottom: SizeConfig().h(10),

                      )),

                ],),padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20), 0, SizeConfig().w(20), 0),),

                Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(20),
                        end: SizeConfig().w(20),
                        top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                    child: CustomButton(
                      fontSize: 12,
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
                Align(child: FavoriteButtonWidget(context), alignment: AlignmentDirectional.topEnd),

              ],)
            ),
        );
  }

  pay()
  {
    Navigator.pushNamed(context, PaymentResultPage.route);
  }
}
