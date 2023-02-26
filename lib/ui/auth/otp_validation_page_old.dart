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


import '../../common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
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
          if (!otpBloc.isClosed)
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

class _BuildUI extends StatefulWidget {
  final OTPBloc otpBloc;
  final OTPState otpState;
  final String verificationId;

  _BuildUI({required this.otpBloc, required this.otpState, required this.verificationId});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final otpCodeController = TextEditingController();

  final controller1 = TextEditingController();

  final controller2 = TextEditingController();

  final controller3 = TextEditingController();

  final controller4 = TextEditingController();

  final controller5 = TextEditingController();

  final controller6 = TextEditingController();

  final focusNode1 = FocusNode();

  final focusNode2 = FocusNode();

  final focusNode3 = FocusNode();

  final focusNode4 = FocusNode();

  final focusNode5 = FocusNode();

  final focusNode6 = FocusNode();

  String convertArabicToEnglishNumbers(String input)
  {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    for (int i = 0; i < arabic.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }

  @override
  void initState() {
    super.initState();
    focusNode1.addListener(_onFocusChange1);
    focusNode2.addListener(_onFocusChange2);
    focusNode3.addListener(_onFocusChange3);
    focusNode4.addListener(_onFocusChange4);
    focusNode5.addListener(_onFocusChange5);
    focusNode6.addListener(_onFocusChange6);

  }

  @override
  void dispose() {
    super.dispose();
    focusNode1.removeListener(_onFocusChange1);
    focusNode2.removeListener(_onFocusChange2);
    focusNode3.removeListener(_onFocusChange3);
    focusNode4.removeListener(_onFocusChange4);
    focusNode5.removeListener(_onFocusChange5);
    focusNode6.removeListener(_onFocusChange6);

    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
  }

  void _onFocusChange1() {
    if (controller1.text == "")
      focusNode1.requestFocus();
    else
    if (controller2.text == "")
      focusNode2.requestFocus();
    else
    if (controller3.text == "")
      focusNode3.requestFocus();
    else
    if (controller4.text == "")
      focusNode4.requestFocus();
    else
    if (controller5.text == "")
      focusNode5.requestFocus();
    else
    if (controller6.text == "")
      focusNode6.requestFocus();
  }
  void _onFocusChange2() {
    if (controller1.text == "")
      focusNode1.requestFocus();
    else
    if (controller2.text == "")
      focusNode2.requestFocus();
    else
    if (controller3.text == "")
      focusNode3.requestFocus();
    else
    if (controller4.text == "")
      focusNode4.requestFocus();
    else
    if (controller5.text == "")
      focusNode5.requestFocus();
    else
    if (controller6.text == "")
      focusNode6.requestFocus();
  }
  void _onFocusChange3() {
    if (controller1.text == "")
      focusNode1.requestFocus();
    else
    if (controller2.text == "")
      focusNode2.requestFocus();
    else
    if (controller3.text == "")
      focusNode3.requestFocus();
    else
    if (controller4.text == "")
      focusNode4.requestFocus();
    else
    if (controller5.text == "")
      focusNode5.requestFocus();
    else
    if (controller6.text == "")
      focusNode6.requestFocus();
  }
  void _onFocusChange4() {
    if (controller1.text == "")
      focusNode1.requestFocus();
    else
    if (controller2.text == "")
      focusNode2.requestFocus();
    else
    if (controller3.text == "")
      focusNode3.requestFocus();
    else
    if (controller4.text == "")
      focusNode4.requestFocus();
    else
    if (controller5.text == "")
      focusNode5.requestFocus();
    else
    if (controller6.text == "")
      focusNode6.requestFocus();
  }
  void _onFocusChange5() {
    if (controller1.text == "")
      focusNode1.requestFocus();
    else
    if (controller2.text == "")
      focusNode2.requestFocus();
    else
    if (controller3.text == "")
      focusNode3.requestFocus();
    else
    if (controller4.text == "")
      focusNode4.requestFocus();
    else
    if (controller5.text == "")
      focusNode5.requestFocus();
    else
    if (controller6.text == "")
      focusNode6.requestFocus();
  }
  void _onFocusChange6() {
    if (controller1.text == "")
      focusNode1.requestFocus();
    else
    if (controller2.text == "")
      focusNode2.requestFocus();
    else
    if (controller3.text == "")
      focusNode3.requestFocus();
    else
    if (controller4.text == "")
      focusNode4.requestFocus();
    else
    if (controller5.text == "")
      focusNode5.requestFocus();
    else
    if (controller6.text == "")
      focusNode6.requestFocus();
  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
            child: Stack(children: [
          Container(
            margin: EdgeInsetsDirectional.only(
                top: SizeConfig().h(175),
                start: SizeConfig().w(20),
                end: SizeConfig().w(20)),
            padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(13)),
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
                  child:
                      Directionality(
                          
                          textDirection: TextDirection.ltr,
                          child: 
                      Row(children: [
                        Flexible(child:
                        Padding(child: CustomTextFieldWidget(
                          textInputType: TextInputType.number,
                          onChanged: (x) {
                            if (x.length > 1) {
                              controller1.text = x[x.length - 1];
                              controller1.selection = TextSelection.fromPosition(TextPosition(offset: controller1.text.length));
                            }

                            if (x.length > 0)
                              focusNode2.requestFocus();
                            code =  convertArabicToEnglishNumbers(controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text);
                          },
                          focusNode: focusNode1,
                          onFieldSubmitted: (x)
                          {
                            focusNode2.requestFocus();
                          },
                          controller: controller1,), padding: EdgeInsetsDirectional.all(2),)),
                        Flexible(child:
                        Padding(child: CustomTextFieldWidget(
                          textInputType: TextInputType.number,
                          onChanged: (x) {
                            if (x == "") {
                              if (mounted) {
                                setState(() {
                                  String v = controller1.text;
                                  controller1.text = "";
                                  focusNode1.requestFocus();
                                  controller1.text = v;
                                  controller1.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controller1.text.length);
                                });
                              }
                            }

                            if (x.length > 1) {
                              controller2.text = x[x.length - 1];
                              controller2.selection = TextSelection.fromPosition(TextPosition(offset: controller2.text.length));
                            }

                            if (x.length > 0)
                              focusNode3.requestFocus();

                            code =  convertArabicToEnglishNumbers(controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text);
                          },
                          focusNode: focusNode2,
                          onFieldSubmitted: (x)
                          {
                            focusNode3.requestFocus();
                          },
                          controller: controller2,), padding: EdgeInsetsDirectional.all(2),)),
                        Flexible(child:
                        Padding(child: CustomTextFieldWidget(
                          textInputType: TextInputType.number,
                          onChanged: (x) {
                            if (x == "") {
                              if (mounted) {
                                setState(() {
                                  String v = controller2.text;
                                  controller2.text = "";
                                  focusNode2.requestFocus();
                                  controller2.text = v;
                                  controller2.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controller2.text.length);
                                });
                              }
                            }

                            if (x.length > 1) {
                              controller3.text = x[x.length - 1];
                              controller3.selection = TextSelection.fromPosition(TextPosition(offset: controller3.text.length));
                            }

                            if (x.length > 0)
                              focusNode4.requestFocus();

                            code =  convertArabicToEnglishNumbers(controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text);
                          },
                          focusNode: focusNode3,
                          onFieldSubmitted: (x)
                          {
                            focusNode4.requestFocus();
                          },
                          controller: controller3,), padding: EdgeInsetsDirectional.all(2),)),
                        Flexible(child:
                        Padding(child: CustomTextFieldWidget(
                          textInputType: TextInputType.number,
                          onChanged: (x) {
                            if (x == "") {
                              if (mounted) {
                                setState(() {
                                  String v = controller3.text;
                                  controller3.text = "";
                                  focusNode3.requestFocus();
                                  controller3.text = v;
                                  controller3.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controller3.text.length);
                                });
                              }
                            }


                            if (x.length > 1) {
                              controller4.text = x[x.length - 1];
                              controller4.selection = TextSelection.fromPosition(TextPosition(offset: controller4.text.length));
                            }

                            if (x.length > 0)
                              focusNode5.requestFocus();

                            code =  convertArabicToEnglishNumbers(controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text);
                          },
                          focusNode: focusNode4,
                          onFieldSubmitted: (x)
                          {
                            focusNode5.requestFocus();
                          },
                          controller: controller4,), padding: EdgeInsetsDirectional.all(2),)),
                        Flexible(child:
                        Padding(child: CustomTextFieldWidget(
                          textInputType: TextInputType.number,
                          onChanged: (x) {
                            if (x == "") {
                              if (mounted) {
                                setState(() {
                                  String v = controller4.text;
                                  controller4.text = "";
                                  focusNode4.requestFocus();
                                  controller4.text = v;
                                  controller4.selection = TextSelection(
                                      baseOffset: 0,
                                      extentOffset: controller4.text.length);
                                });
                              }
                            }


                            if (x.length > 1) {
                              controller5.text = x[x.length - 1];
                              controller5.selection = TextSelection.fromPosition(TextPosition(offset: controller5.text.length));
                            }

                            if (x.length > 0)
                              focusNode6.requestFocus();

                            code =  convertArabicToEnglishNumbers(controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text);
                          },
                          focusNode: focusNode5,
                          onFieldSubmitted: (x)
                          {
                            focusNode6.requestFocus();
                          },
                          controller: controller5,), padding: EdgeInsetsDirectional.all(2),)),
                        Flexible(child:
                        Padding(child: CustomTextFieldWidget(
                          textInputType: TextInputType.number,
                          onChanged: (x) {
                              if (x == "") {
                                if (mounted) {
                                  setState(() {
                                    String v = controller5.text;
                                    controller5.text = "";
                                    focusNode5.requestFocus();
                                    controller5.text = v;
                                    setState(() {
                                      controller5.selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset: controller5.value.text.length);
                                    });
                                  });
                                }
                              }


                            if (x.length > 1) {
                              controller6.text = x[x.length - 1];
                              controller6.selection = TextSelection.fromPosition(TextPosition(offset: controller6.text.length));
                            }

                            code =  convertArabicToEnglishNumbers(controller1.text+controller2.text+controller3.text+controller4.text+controller5.text+controller6.text);
                          },
                          focusNode: focusNode6,
                          onFieldSubmitted: (x)
                          {
                            if (code.length == 6) {
                              hideKeyboard(context);
                              if (code.isNotEmpty)
                                Navigator.pop(context, code);
                            }
                          },
                          controller: controller6,), padding: EdgeInsetsDirectional.all(2),)),
                      ],))

                    /*OTPTextField(
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
                      code = convertArabicToEnglishNumbers(pin);
                      //code = pin;
                    },
                    onCompleted: (pin) {
                      code = convertArabicToEnglishNumbers(pin);
                      //code = pin;
                    },
                  )*/

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
                if (widget.otpState is LoadingOTPState)
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
                            if (code.length == 6) {
                              hideKeyboard(context);
                              if (code.isNotEmpty)
                                Navigator.pop(context, code);
                            }
                          })),
              ],
            ),
          ),
              BackButtonWidget(context)
        ])));
  }
}
