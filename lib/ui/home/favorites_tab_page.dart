import 'dart:math';

import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

class FavoritesTabPage extends StatelessWidget {
  const FavoritesTabPage({Key? key}) : super(key: key);

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
            child: Column(
          children: [
            Align(
              child: Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate("labels.favorites"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      )
                    ],
                  ),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(10))),
              alignment: AlignmentDirectional.topStart,
            ),
            (strings.length > 0)
                ? Padding(
                    child: Column(
                        children: strings
                            .map((i) => InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PurchasePage.route,
                                      arguments: StationBranch(id: 1, address: "this is the address", companyId: 1, companyName: "Company Name", longitude: 10.232154, latitude: 10.25454, name: "Station 1", number: "1545"));

                                },
                                child: Stack(
                                  children: [
                                    (isArabic())
                                        ? Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.rotationY(pi),
                                            child: Image(
                                                image: AssetImage(
                                                    "assets/station_row.png")))
                                        : Image(
                                            image: AssetImage(
                                                "assets/station_row.png")),
                                    Column(
                                      children: [
                                        Padding(
                                          child: Text(
                                            i,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          padding: EdgeInsetsDirectional.only(
                                              start: SizeConfig().w(40),
                                              end: SizeConfig().w(40),
                                              top: SizeConfig().w(20)),
                                        ),
                                        Padding(
                                          child: Text(
                                            i,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          padding: EdgeInsetsDirectional.only(
                                            start: SizeConfig().w(40),
                                            end: SizeConfig().w(40),
                                          ),
                                        ),
                                        Padding(
                                          child: Text(
                                            i,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          padding: EdgeInsetsDirectional.only(
                                            start: SizeConfig().w(40),
                                            end: SizeConfig().w(40),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )))
                            .toList()),
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  )
                : Container(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          "You have no favorites",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
          ],
        )));
  }
}
