import 'dart:io';
import 'dart:math';

import 'package:fastfill/bloc/login/bloc.dart';
import 'package:fastfill/bloc/login/event.dart';
import 'package:fastfill/bloc/login/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
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
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';

class SearchPage extends StatefulWidget {
  static const route = "/search_page";

  final String searchText;

  const SearchPage({required this.searchText});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is ErrorLoginState)
            pushToast(state.error);
          else if (state is SuccessLoginState) {
            await LocalData()
                .setCurrentUserValue(state.loginUser.value!.userDetails!);
            await LocalData().setTokenValue(state.loginUser.value!.token!);
            pushToast(translate("messages.youLoggedSuccessfully"));
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.route, (Route<dynamic> route) => false);
          }
        },
        bloc: bloc,
        child: BlocBuilder<LoginBloc, LoginState>(
            bloc: bloc,
            builder: (context, LoginState state) {
              return _BuildUI(
                  bloc: bloc, state: state, searchText: widget.searchText);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final LoginBloc bloc;
  final LoginState state;
  final String searchText;

  _BuildUI({required this.bloc, required this.state, required this.searchText});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final searchController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    searchController.text = widget.searchText;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: backgroundColor1,
        body: Stack(
          children: [
            Column(
              children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.searchResults"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          top: SizeConfig().h(125))),
                  alignment: AlignmentDirectional.topStart,
                ),
                Align(
                  child: Padding(
                      child: CustomTextFieldWidget(
                          icon: Icon(Icons.search),
                          onFieldSubmitted: (_) {},
                          controller: searchController,
                          hintText: translate("labels.stationNumber"),
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          top: SizeConfig().h(25))),
                  alignment: AlignmentDirectional.topCenter,
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                            children: strings
                                .map((i) => InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PurchasePage.route,
                                          arguments: StationBranch(
                                              id: 1,
                                              address: "this is the address",
                                              companyId: 1,
                                              companyName: "Company Name",
                                              longitude: 10.232154,
                                              latitude: 10.25454,
                                              name: "Station 1",
                                              number: "1545"));
                                    },
                                    child: Stack(
                                      children: [
                                        (isArabic())
                                            ? Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(pi),
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
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      start: SizeConfig().w(40),
                                                      end: SizeConfig().w(40),
                                                      top: SizeConfig().w(20)),
                                            ),
                                            Padding(
                                              child: Text(
                                                i,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: SizeConfig().w(40),
                                                end: SizeConfig().w(40),
                                              ),
                                            ),
                                            Padding(
                                              child: Text(
                                                i,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: SizeConfig().w(40),
                                                end: SizeConfig().w(40),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )))
                                .toList()))),
              ],
            ),
            Align(
                child: BackButtonWidget(context),
                alignment: AlignmentDirectional.topStart),
          ],
        ));
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
