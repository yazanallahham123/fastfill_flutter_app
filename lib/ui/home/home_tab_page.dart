import 'dart:io';
import 'dart:math';

import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/ui/search/search_page.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class HomeTabPage extends StatelessWidget {
  const HomeTabPage({Key? key}) : super(key: key);

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

User _buildUserInstance(AsyncSnapshot<User> snapshot) {
  if (snapshot.hasData && snapshot.data!.id != 0 && snapshot.data!.id != null)
    return snapshot.data!;
  return User();
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
                  child: Text(
                    translate("labels.accountInfo"),
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
            Stack(
              children: [
                (isArabic())
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: Image(image: AssetImage("assets/home_box.png")))
                    : Image(image: AssetImage("assets/home_box.png")),
                FutureBuilder<User>(
                    future: LocalData().getCurrentUserValue(),
                    builder: (context, AsyncSnapshot<User> snapshot) {
                      User usr = _buildUserInstance(snapshot);
                      if (usr.id != null) {
                        return Container(
                            child: Column(
                          children: [
                            Align(
                              child: Padding(
                                child: Text(
                                  usr.firstName!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                padding: EdgeInsetsDirectional.only(
                                    start: SizeConfig().w(50),
                                    end: SizeConfig().w(50),
                                    top: SizeConfig().h(50)),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                            Align(
                              child: Padding(
                                child: Text(
                                  translate("labels.balance") +
                                      " : " +
                                      usr.id.toString() +
                                      " " +
                                      translate("labels.sdg"),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                padding: EdgeInsetsDirectional.only(
                                    start: SizeConfig().w(50),
                                    end: SizeConfig().w(50),
                                    top: SizeConfig().h(20)),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                            Align(
                              child: Padding(
                                child: CustomButton(
                                  title: translate("buttons.fastfill"),
                                  borderColor: Colors.white,
                                  titleColor: Colors.white,
                                  backColor: buttonColor1,
                                  onTap: () {},
                                ),
                                padding: EdgeInsetsDirectional.only(
                                    start: SizeConfig().w(120),
                                    end: SizeConfig().w(120),
                                    top: SizeConfig().h(60)),
                              ),
                              alignment: AlignmentDirectional.centerStart,
                            ),
                          ],
                        ));
                      } else {
                        return CustomLoading();
                      }
                    })
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                          child: CustomTextFieldWidget(
                              icon: Icon(Icons.search),
                              onFieldSubmitted: (_) {
                                Navigator.pushNamed(
                                    context, SearchPage.route, arguments: searchController.text);
                              },
                              controller: searchController,
                              hintText: translate("labels.stationNumber"),
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.done),
                          padding: EdgeInsetsDirectional.only(
                              start: SizeConfig().w(30),
                              end: SizeConfig().w(30),
                              top: SizeConfig().h(30))),
                      Align(
                        child: Padding(
                          child: Text(
                            translate("labels.favorites"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          padding: EdgeInsetsDirectional.only(
                              start: SizeConfig().w(30),
                              end: SizeConfig().w(30),
                              bottom: SizeConfig().w(15)),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      Column(
                          children: strings
                              .map((i) =>
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PurchasePage.route,
                                        arguments: StationBranch(id: 1, address: "this is the address", companyId: 1, companyName: "Company Name", longitude: 10.232154, latitude: 10.25454, name: "Station 1", number: "1545"));
                                  },
                                  child:
                              Stack(
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
                      Align(
                        child: Padding(
                          child: Text(
                            translate("labels.frequentlyVisited"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          padding: EdgeInsetsDirectional.only(
                              top: SizeConfig().w(15),
                              start: SizeConfig().w(30),
                              end: SizeConfig().w(30),
                              bottom: SizeConfig().w(15)),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      Column(
                          children: strings
                              .map((i) => Stack(
                                    children: [
                                      (isArabic())
                                          ? Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationY(pi),
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/station.png")))
                                          : Image(
                                              image: AssetImage(
                                                  "assets/station.png")),
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
                                  ))
                              .toList()),
                    ],
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
