import 'dart:math';

import 'package:fastfill/bloc/user/bloc.dart';
import 'package:fastfill/bloc/user/event.dart';
import 'package:fastfill/bloc/user/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/methods.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/textfield_password_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/firebase_helper.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/user/signup_body.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'otp_validation_page.dart';

class SignupPage extends StatefulWidget {
  static const route = "/signup_page";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc()..add(UserInitEvent()),
          child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        if (state is ErrorUserState)
          pushToast(state.error);
        else if (state is SuccessfulUserOTPVerificationState)
          {
            pushToast(translate(translate("messages.otpCodeIsVerified")));
            userBloc.add(SignupEvent(state.signupBody));
          }
        else if (state is SignedUpState) {
          await LocalData()
              .setCurrentUserValue(state.signedUpUser.userDetails!);
          await LocalData().setTokenValue(state.signedUpUser.token!);
          pushToast(translate("messages.youSignedupSuccessfully"));
          Navigator.pushNamedAndRemoveUntil(context, HomePage.route,(Route<dynamic> route) => false);
        }
      },
      child: BlocBuilder(
          bloc: userBloc,
          builder: (context, UserState userState) {
            return _BuildUI(userBloc: userBloc, userState: userState);
          })
    );
  }
}


class _BuildUI extends StatefulWidget {
  final UserBloc userBloc;
  final UserState userState;

  _BuildUI({required this.userBloc, required this.userState});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final firstNameNode = FocusNode();
  final phoneNode = FocusNode();
  final passNode = FocusNode();
  final confirmPassNode = FocusNode();

  final firstNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

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
            child: Stack(children: [
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
                      padding: EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                      child: CustomTextFieldWidget(
                          controller: firstNameController,
                          focusNode: firstNameNode,
                          validator: validateName,
                          hintText: translate("labels.name"),
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(phoneNode)),
                    ),
                    CustomTextFieldWidget(
                        controller: phoneController,
                        focusNode: phoneNode,
                        validator: validateMobile,
                        hintText: translate("labels.phoneNumber"),
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(passNode)),
                    TextFieldPasswordWidget(
                        controller: passController,
                        focusNode: passNode,
                        hintText: translate("labels.password"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(confirmPassNode)),
                    TextFieldPasswordWidget(
                        controller: confirmPassController,
                        textInputAction: TextInputAction.send,
                        focusNode: confirmPassNode,
                        hintText: translate("labels.confirmPassword"),
                        onFieldSubmitted: (_) {
                          _signUp(context);
                        }),
                      if (widget.userState is LoadingUserState)
                        Padding(child: const CustomLoading(),
                          padding: EdgeInsetsDirectional.only(top: SizeConfig().h(20), bottom:SizeConfig().h(50)),)
                    else
                    Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                          child: CustomButton(
                              backColor: buttonColor1,
                              titleColor: Colors.white,
                              borderColor: buttonColor1,
                              title: translate("buttons.signUp"),
                              onTap: () {
                                _signUp(context);
                                //Navigator.pushNamed(context, OTPValidationPage.route);
                              })),
                  ],
                ),
              ),
              // Back Button
              /*InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                    alignment: Alignment.topLeft,
                    height: SizeConfig().h(50),
                    width: SizeConfig().h(50),
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig().w(12),
                        vertical: SizeConfig().h(55)),
                    child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: SvgPicture.asset(
                          'assets/svg/backarrow.svg',
                          width: SizeConfig().w(50),
                        ))),
              )*/
              BackButtonWidget(context)
            ])));
  }

  void _signUp(BuildContext context) async {

    if (phoneController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        confirmPassController.text.isNotEmpty) {
      if (!validateMobile(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      else if (!isStrongPassword(passController.text))
        FocusScope.of(context).requestFocus(passNode);
      else if (!validateName(firstNameController.text))
        FocusScope.of(context).requestFocus(firstNameNode);
      else if (!validateName(confirmPassController.text))
        FocusScope.of(context).requestFocus(confirmPassNode);
      else if (confirmPassController.text != passController.text)
        FocusScope.of(context).requestFocus(confirmPassNode);
      else {
        widget.userBloc.add(CallOTPScreenEvent());
        await auth.verifyPhoneNumber(
            phoneNumber: phoneController.text,
            verificationCompleted: await (PhoneAuthCredential credential) {
            },
            verificationFailed: await (FirebaseAuthException e) {
            },
            codeSent : await (String verificationId, int? resendToken) async {
              String smsCode = await Navigator.pushNamed(context, OTPValidationPage.route, arguments: verificationId) as String;
              if (smsCode.isNotEmpty) {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: smsCode);
                auth.signInWithCredential(credential).then((value) {
                  widget.userBloc.add(SuccessfulUserOTPVerificationEvent(
                      SignupBody(
                          firstName: firstNameController.text,
                          lastName: firstNameController.text,
                          username: phoneController.text,
                          mobileNumber: phoneController.text,
                          password: passController.text), null

                  ));
                }).catchError((e) {
                  widget.userBloc.add(ErrorUserOTPVerificationEvent(
                      (e.message != null) ? e.message! : e.code));
                });
              }
            },
            codeAutoRetrievalTimeout: await (String verificationId) {
            });
      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    phoneController.dispose();
    passController.dispose();
    confirmPassController.dispose();

    firstNameNode.dispose();
    confirmPassNode.dispose();
    passNode.dispose();
    phoneNode.dispose();
  }
}

