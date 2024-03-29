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
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/ui/language/language_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

import '../../main.dart';
import '../../utils/misc.dart';

class LoginPage extends StatefulWidget {
  static const route = "/login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            await setCurrentUserValue(state.loginUser.value!.userDetails!);
            await setTokenValue(state.loginUser.value!.token!);
            pushToast(translate("messages.youLoggedSuccessfully"));
            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.route, (Route<dynamic> route) => false);
          }
        },
        bloc: bloc,
        child: BlocBuilder<LoginBloc, LoginState>(
            bloc: bloc,
            builder: (context, LoginState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final LoginBloc bloc;
  final LoginState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}


class _BuildUIState extends State<_BuildUI> {

  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final phoneNode = FocusNode();
  final passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
        KeyboardActions(
        config: _buildConfig(context),
    child:

    SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                  top: SizeConfig().h(175),
                  start: SizeConfig().w(20),
                  end: SizeConfig().w(20)),
              padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                    child: CustomTextFieldWidget(
                        controller: phoneController,
                        focusNode: phoneNode,
                        validator: validateMobile,
                        hintText: translate("labels.phoneNumber"),
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        errorText: translate("messages.phoneNumberValidation"),
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(passNode)),
                  ),
                  TextFieldPasswordWidget(
                      controller: passController,
                      textInputAction: TextInputAction.go,
                      focusNode: passNode,
                      hintText: translate("labels.password"),
                      onFieldSubmitted: (_) {
                        _login(context);
                      }),
                  if (widget.state is LoadingLoginState)
                    Padding(
                      child: const CustomLoading(),
                      padding: EdgeInsetsDirectional.only(
                          top: SizeConfig().h(72), bottom: SizeConfig().h(92)),
                    )
                  else
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: SizeConfig().h(10)),
                            child: CustomButton(
                                backColor: buttonColor1,
                                titleColor: Colors.white,
                                borderColor: buttonColor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                title: translate("buttons.signIn"),
                                onTap: () {
                                  _login(context);
                                })),
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: SizeConfig().h(10),
                                bottom: SizeConfig().h(10)),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Divider(color: customGreyColor3),
                                Text(translate("labels.or"))
                              ],
                            )),
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: SizeConfig().h(0),
                                bottom: SizeConfig().h(20)),
                            child: CustomButton(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                backColor: buttonColor1,
                                titleColor: Colors.white,
                                borderColor: buttonColor1,
                                title: translate("buttons.signUp"),
                                onTap: () {
                                  hideKeyboard(context);
                                  Navigator.pushNamed(
                                      context, SignupPage.route);
                                })),
                        InkWell(
                            onTap: () {

                              Navigator.pushNamed(
                                  context, ResetPassword_PhoneNumberPage.route);
                            },
                            child: Padding(
                              child: Text(translate("labels.forgotPassword"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              padding: EdgeInsetsDirectional.only(
                                  bottom: SizeConfig().h(20)),
                            ))
                      ],
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (isArabic()) {
                  await setLanguageValue("en");
                  languageCode = "en";
                  FastFillApp.setLocale(context, Locale.fromSubtags(languageCode: "en"));
                  changeLocale(context, "en");
                }
                else
                  {
                    await setLanguageValue("ar");
                    languageCode = "ar";
                    FastFillApp.setLocale(context, Locale.fromSubtags(languageCode: "ar"));
                    changeLocale(context, "ar");
                  }
              },
              child: Container(
                  alignment: Alignment.topLeft,
                  height: SizeConfig().h(50),
                  width: SizeConfig().w(75),
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig().w(12),
                      vertical: SizeConfig().h(55)),
                  child: (isArabic())
                      ? Text("English", style: TextStyle(color: buttonColor1),)
                      : Text("عربي", style: TextStyle(color: buttonColor1))),
            )
          ],
        ))));
  }

  String convertArabicToEnglishNumbers(String input)
  {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    for (int i = 0; i < arabic.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }


  void _login(BuildContext context) async {
    hideKeyboard(context);
    final bloc = BlocProvider.of<LoginBloc>(context);
    if (phoneController.text.isNotEmpty && passController.text.isNotEmpty) {
      if (!validateMobile(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      else if (!isStrongPassword(passController.text))
        FocusScope.of(context).requestFocus(passNode);
      else {

        String pn = "";
        if (phoneController.text != null) {
          if ((phoneController.text.length == 9) ||
              (phoneController.text.length == 10)) {
            if ((phoneController.text.length == 10) &&
                (phoneController.text.substring(0, 1) == "0")) {
              pn = phoneController.text
                  .substring(1, phoneController.text.length);
            } else {
              if (phoneController.text.length == 9) {
                pn = phoneController.text;
              }
            }
          }
        }

        int languageId = (languageCode=="en") ? 1 : 2;

        pn = convertArabicToEnglishNumbers(pn);

        if (!bloc.isClosed)
          bloc.add(LoginUserEvent(LoginBody(
            mobileNumber: pn,
            password: passController.text,
            language: languageId)));
      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }

  KeyboardActionsConfig _buildConfig(BuildContext context){
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: phoneNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(passNode);
                }
                ,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(translate("buttons.next"), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            }
          ]),

          KeyboardActionsItem(focusNode: passNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  _login(context);
                }
                ,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(translate("buttons.signIn"), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            }
          ]),
        ]);
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passController.dispose();
    passNode.dispose();
    phoneNode.dispose();
  }
}


