
import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class TransactionsTabPage extends StatelessWidget {
  const TransactionsTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OTPBloc>(
        create: (BuildContext context) => OTPBloc(), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<OTPBloc>(context);

    return BlocListener<OTPBloc, OTPState>(
        listener: (context, state) async {
          if (state is ErrorOTPState)
            pushToast(state.error);
          else if (state is SuccessOTPCodeVerifiedState) {}
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, OTPState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatelessWidget {
  final OTPBloc bloc;
  final OTPState state;

  final List<String> strings = [
    "abc",
    "def",
    "ghi",
    "klm",
    "abc",
    "def",
    "ghi",
    "klm",
    "abc",
    "def",
    "ghi",
    "klm"
  ];

  _BuildUI({required this.bloc, required this.state});

  final otpCodeController = TextEditingController();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
            child:

            Column(
              children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.transactions"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          top: SizeConfig().h(10))),
                  alignment: AlignmentDirectional.topStart,
                ),

                Padding(child:
    (strings.length > 0) ?
                Column(children: strings.map((i) =>
                Padding(child: Row(children: [

                  SvgPicture.asset("assets/svg/refuel.svg", width: 50, height: 50,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child:
                    Padding(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Expanded(child:
                      Text(translate("labels.fuelRefueling"), style: TextStyle(color: Colors.white),),),

                      Text('10 '+translate("labels.l"), style: TextStyle(color: Colors.white),),
                    ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0)),),

                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child:
                        Padding(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child:
                            Text('Jun 25, 2021 / 12:00', style: TextStyle(color: textColor2),),),

                            Text('30 '+translate("labels.sdg"), style: TextStyle(color: textColor2),),
                          ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0)),),

                      Container(
                        width: MediaQuery.of(context).size.width - 110,
                        child:
                        Padding(child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child:
                            Text('Address', style: TextStyle(color: textColor2),),),

                          ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0)),),
                  ],)
                ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 15),)
                ).toList(),)
                  : Text(translate("labels.noTransactions"), style: TextStyle(color: Colors.white),)
                  ,padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),)
              ],
            )));
  }
}