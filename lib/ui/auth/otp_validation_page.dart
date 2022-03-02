import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/event.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../utils/misc.dart';

class OTPValidationPage extends StatelessWidget {
  static const route = "/otp_validation_page";

  final String verificationId;

  const OTPValidationPage({Key? key, required this.verificationId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider<OTPBloc>(
          create: (BuildContext context) => OTPBloc()..add(OTPInitEvent()),
          child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final otpBloc = BlocProvider.of<OTPBloc>(context);

    return BlocListener<OTPBloc, OTPState>(
      listener: (context, state) async {
        if (state is InitOTPState) {
          otpBloc.add(OTPInitEvent());
        }
        if (state is ErrorOTPState)
          pushToast(state.error);
      },
      child: BlocBuilder(
          bloc: otpBloc,
          builder: (context, OTPState otpState) {
            return _BuildUI(otpBloc: otpBloc, otpState: otpState, verificationId: verificationId);
          }),
    );
  }
}

String code = "";

class _BuildUI extends StatelessWidget {
  final OTPBloc otpBloc;
  final OTPState otpState;
  final String verificationId;

  _BuildUI({required this.otpBloc, required this.otpState, required this.verificationId});

  final otpCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
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
                Align(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: SizeConfig().h(30)),
                    child: Text(
                      translate("labels.verifyAccount"),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  alignment: AlignmentDirectional.topStart,
                ),
                Text(translate("labels.verifyAccountDesc")
                    //+ ": " + ((otpArguments.otpForType == OtpForType.Signup) ? otpArguments.signupBody!.mobileNumber! :
                    //(otpArguments.otpForType == OtpForType.ResetPassword) ? otpArguments.resetPasswordBody!.mobileNumber! : "")
                ),
                Align(
                  child: Padding(
                      padding: EdgeInsetsDirectional.only(top: SizeConfig().h(25)),
                      child: Text(translate("labels.yourCodeHere"))),
                  alignment: AlignmentDirectional.topStart,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: SizeConfig().h(0)),
                  child: OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.center,
                    fieldWidth: SizeConfig().w(40),
                    fieldStyle: FieldStyle.underline,
                    outlineBorderRadius: 15,
                    otpFieldStyle: OtpFieldStyle(borderColor: Colors.red),
                    style: TextStyle(fontSize: 20),
                    onChanged: (pin) {
                      print("Changed: " + pin);
                      code = pin;
                    },
                    onCompleted: (pin) {
                      code = pin;
                    },
                  ),
                ),
                Align(
                  child: Padding(
                      padding: EdgeInsetsDirectional.only(top: SizeConfig().h(25)),
                      child: InkWell(
                        child: Text(translate("labels.resendCode"), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                        onTap: () {
                          hideKeyboard(context);
                        },
                      )),
                  alignment: AlignmentDirectional.bottomEnd,
                ),
                if (otpState is LoadingOTPState)
                  const CustomLoading()
                else
                  Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: SizeConfig().h(10), bottom: SizeConfig().h(25)),
                      child: CustomButton(
                          backColor: buttonColor1,
                          titleColor: Colors.white,
                          borderColor: buttonColor1,
                          title: translate("buttons.validate"),
                          onTap: () {
                            hideKeyboard(context);
                            if (code.isNotEmpty)
                              Navigator.pop(context, code);
                          })),
              ],
            ),
          ),
              BackButtonWidget(context)
        ])));
  }
}
