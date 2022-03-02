import 'dart:io';
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
import 'package:fastfill/model/forRouting/enums.dart';
import 'package:fastfill/model/forRouting/otp_arguments.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signup_body.dart';
import 'package:fastfill/ui/auth/reset_password_password_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:fastfill/utils/misc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'login_page.dart';
import 'otp_validation_page.dart';

class ResetPassword_PhoneNumberPage extends StatefulWidget {
  static const route = "/resetpassword_phonenumber_page";

  @override
  State<ResetPassword_PhoneNumberPage> createState() => _ResetPassword_PhoneNumberPageState();
}

class _ResetPassword_PhoneNumberPageState extends State<ResetPassword_PhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc()..add(UserInitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is SuccessfulUserOTPVerificationState) {
            pushToast(translate(translate("messages.otpCodeIsVerified")));

            Navigator.pushNamed(context, ResetPassword_PasswordPage.route,
                arguments: state.resetPasswordBody);
          }
        },
        child: BlocBuilder(
            bloc: userBloc,
            builder: (context, UserState userState) {
              return _BuildUI(userBloc: userBloc, userState: userState);
            }));
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
  final phoneController = TextEditingController();

  final phoneNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    padding:
                        EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                    child: CustomTextFieldWidget(
                        controller: phoneController,
                        focusNode: phoneNode,
                        validator: validateMobile,
                        hintText: translate("labels.phoneNumber"),
                        textInputType: TextInputType.phone,
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (_) {
                          _resetPassword(context);
                        })),
                if (widget.userState is LoadingUserState)
                  Padding(
                    child: const CustomLoading(),
                    padding: EdgeInsetsDirectional.only(
                        top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                  )
                else
                  Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: SizeConfig().h(10), bottom: SizeConfig().h(35)),
                      child: CustomButton(
                          backColor: buttonColor1,
                          titleColor: Colors.white,
                          borderColor: buttonColor1,
                          title: translate("buttons.next"),
                          onTap: () {
                            _resetPassword(context);
                          })),
              ],
            ),
          ),
          // Back Button
              BackButtonWidget(context)
        ])));
  }

  void _resetPassword(BuildContext context) async {
    if (phoneController.text.isNotEmpty) {
      if (!validateMobile(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      else {

        hideKeyboard(context);
        widget.userBloc.add(CallOTPScreenEvent());


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


        await auth.verifyPhoneNumber(
            phoneNumber: countryCode + pn,
            timeout: const Duration(seconds: 5),
            verificationCompleted: await (PhoneAuthCredential credential) {

              auth.signInWithCredential(credential).then((value) {
                widget.userBloc.add(SuccessfulUserOTPVerificationEvent(
                    null,
                    ResetPasswordBody(
                        verificationId: credential.verificationId,
                        newPassword: "",
                        mobileNumber: pn)));
              }).catchError((e) {
                widget.userBloc.add(ErrorUserOTPVerificationEvent(
                    (e.message != null) ? e.message! : e.code));
              });

            },
            verificationFailed: await (FirebaseAuthException e) async {
              widget.userBloc.add(ErrorUserOTPVerificationEvent(
                  (e.message != null)
                      ? e.message! + " " + e.code + countryCode + pn
                      : e.code));
            },
            codeSent: await (String verificationId, int? resendToken) async {
              if (Platform.isIOS) {

                String? smsCode = await Navigator.pushNamed(
                    context, OTPValidationPage.route,
                    arguments: verificationId) as String?;
                if (smsCode == null)
                  smsCode = "";
                if (smsCode.isNotEmpty) {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: smsCode);
                  auth.signInWithCredential(credential).then((value) {


                    widget.userBloc.add(SuccessfulUserOTPVerificationEvent(
                        null,
                        ResetPasswordBody(
                            verificationId: verificationId,
                            newPassword: "",
                            mobileNumber: pn)));
                  }).catchError((e) {
                    widget.userBloc.add(ErrorUserOTPVerificationEvent(
                        (e.message != null) ? e.message! : e.code));
                  });
                }
              }
            },
            codeAutoRetrievalTimeout: await (String verificationId) async {

              String? smsCode = await Navigator.pushNamed(
                  context, OTPValidationPage.route,
                  arguments: verificationId) as String?;
              if (smsCode == null)
                smsCode = "";
              if (smsCode.isNotEmpty) {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: smsCode);
                auth.signInWithCredential(credential).then((value) {
                  widget.userBloc.add(SuccessfulUserOTPVerificationEvent(
                      null,
                      ResetPasswordBody(
                          verificationId: verificationId,
                          newPassword: "",
                          mobileNumber:pn)));
                }).catchError((e) {
                  widget.userBloc.add(ErrorUserOTPVerificationEvent(
                      (e.message != null) ? e.message! : e.code));
                });
              }
            });
      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }
}
