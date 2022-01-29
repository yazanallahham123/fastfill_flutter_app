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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'login_page.dart';
import 'otp_validation_page.dart';

class ResetPassword_PhoneNumberPage extends StatelessWidget {
  static const route = "/resetpassword_phonenumber_page";

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

class _BuildUI extends StatelessWidget {
  final UserBloc userBloc;
  final UserState userState;

  final phoneController = TextEditingController();

  final phoneNode = FocusNode();

  _BuildUI({required this.userBloc, required this.userState});

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
                if (userState is LoadingUserState)
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
        userBloc.add(CallOTPScreenEvent());
        await auth.verifyPhoneNumber(
            phoneNumber: phoneController.text,
            verificationCompleted: await (PhoneAuthCredential credential) {},
            verificationFailed: await (FirebaseAuthException e) {},
            codeSent: await (String verificationId, int? resendToken) async {
              String smsCode = await Navigator.pushNamed(
                  context, OTPValidationPage.route,
                  arguments: verificationId) as String;

              if (smsCode.isNotEmpty) {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId, smsCode: smsCode);
                auth.signInWithCredential(credential).then((value) {
                  userBloc.add(SuccessfulUserOTPVerificationEvent(
                      null,
                      ResetPasswordBody(
                          verificationId: verificationId,
                          newPassword: "",
                          mobileNumber: phoneController.text)));
                }).catchError((e) {
                  userBloc.add(ErrorUserOTPVerificationEvent(
                      (e.message != null) ? e.message! : e.code));
                });
              }
            },
            codeAutoRetrievalTimeout: await (String verificationId) {});
      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }
}