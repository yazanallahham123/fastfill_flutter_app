import 'dart:convert';
import 'dart:io';

import 'package:fastfill/bloc/login/bloc.dart';
import 'package:fastfill/bloc/login/event.dart';
import 'package:fastfill/bloc/login/state.dart';
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
import 'package:fastfill/helper/const_sizes.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/font_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/syberPay/syber_pay_get_url_body.dart';
import 'package:fastfill/model/user/update_profile_body.dart';
import 'package:fastfill/model/user/user.dart' as UserModel;
import 'package:fastfill/streams/update_profile_stream.dart';
import 'package:fastfill/ui/auth/login_page.dart';
import 'package:fastfill/ui/auth/otp_validation_page.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/ui/profile/top_up_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:fastfill/utils/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:crypto/crypto.dart';

import '../../model/otp/otp_code_verification_body.dart';
import '../../model/otp/otp_verification_phone_body.dart';
import '../../model/syberPay/top_up_param.dart';

class ProfilePage extends StatefulWidget {
  static const route = "/profile_page";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String profilePhotoURL = "";
bool phoneIsChanged = false;
String name = "";
bool removeAccount = false;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(),//.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is SuccessfulUserOTPVerificationState)
            {
              if ((state.removeAccount??false) == true)
                bloc.add(RemoveAccountEvent());
              else
                bloc.add(UpdateProfileEvent(state.updateProfileBody!));
            }
          if (state is VerifiedOTPCode)
            {
              if (state.result) {
                bloc.add(SuccessfulUserOTPVerificationEvent(
                    state.signupBody,
                    state.resetPasswordBody,
                    state.updateProfileBody,state.removeAccount));
              }
              else
              {
                bloc.add(ErrorUserOTPVerificationEvent(translate("messages.otpCodeIsIncorrect")));
              }
            }
          else
          if (state is CalledOTPScreenState)
            {
              OTPVerificationPhoneBody otpVerificationPhoneBody = OTPVerificationPhoneBody(registerId: state.registerId, phoneNumber: state.mobileNumber);
              OTPCodeVerificationBody? otpCodeVerification = await Navigator.pushNamed(
                  context, OTPValidationPage.route,
                  arguments: otpVerificationPhoneBody) as OTPCodeVerificationBody?;

              if (otpCodeVerification != null)
              {
                if (otpCodeVerification.code != null)
                {
                  if (otpCodeVerification.code.isNotEmpty)
                  {
                    if (!bloc.isClosed) {
                      bloc.add(VerifyOTPEvent(
                          otpCodeVerification.registerId,
                          otpCodeVerification.code,
                          state.signupBody,
                          state.mobileNumber,
                          state.updateProfileBody,
                          state.resetPasswordBody,
                          state.removeAccount
                      ));
                    }
                  }
                }
              }
            }
            else
          if (state is RemovedAccountState)
            {
              if (state.result)
                {
                  hideKeyboard(context);
                  UserModel.User usr = UserModel.User(lastName: null, firstName: null, disabled: null, id: null, mobileNumber: null, roleId: null, username: null);
                  await setCurrentUserValue(usr);
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, LoginPage.route, (Route<dynamic> route) => false);
                }
            }
          else
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is UploadedProfilePhotoState)
            {
              if (mounted) {
                setState(() {
                  profilePhotoURL = state.profilePhotoURL;
                });
              }
            }
          else if (state is GotSyberPayUrlState){
            pushToast(state.syberPayGetUrlResponseBody.paymentUrl!);

            if (state.syberPayGetUrlResponseBody.responseCode != null)
              {
                if (state.syberPayGetUrlResponseBody.responseCode == 1)
                  {

                    TopUpParam topUpParam = new TopUpParam(paymentUrl:state.syberPayGetUrlResponseBody.paymentUrl,
                    transactionId: state.syberPayGetUrlResponseBody.transactionId
                    );

                    bool result = await Navigator.pushNamed(
                        context, TopUpPage.route, arguments: topUpParam) as bool;
                    if (result)
                      {

                        Widget okButton = TextButton(
                          child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
                          onPressed:  () {
                            hideKeyboard(context);
                            Navigator.pop(context);
                          },
                        );


                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text(translate("labels.refillTitle")),
                          content: Text(translate("messages.successRefillMessage")),
                          actions: [
                            okButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );

                      }
                    else
                      {
                        Widget okButton = TextButton(
                          child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
                          onPressed:  () {
                            hideKeyboard(context);
                            Navigator.pop(context);
                          },
                        );


                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text(translate("labels.refillTitle")),
                          content: Text(translate("messages.unsuccessRefillMessage")),
                          actions: [
                            okButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                  }
                else
                  pushToast("messages.couldNotGetSyberPayUrl");
              }
            else
              pushToast("messages.couldNotGetSyberPayUrl");

          }
          else if (state is UserProfileUpdated) {
            if (phoneIsChanged) {
              UserModel.User user = UserModel.User(lastName: null, firstName: null, disabled: null, id: null, mobileNumber: null, roleId: null, username: null);
              await setCurrentUserValue(user);
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginPage.route, (Route<dynamic> route) => false);
            }
            else
              {
                UserModel.User u = await getCurrentUserValue();
                updateProfileStreamController.sink.add(u);
                Navigator.pop(context);
              }
          }
        },
        bloc: bloc,
        child: BlocBuilder<UserBloc, UserState>(
            bloc: bloc,
            builder: (context, UserState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final UserBloc bloc;
  final UserState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final phoneNode = FocusNode();
  final nameNode = FocusNode();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getCurrentUserValue().then((user) {
      phoneController.text = user.mobileNumber??"";
      nameController.text = user.firstName??"";
      profilePhotoURL = user.imageURL??"";
    });

  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1 ,
        body:
        KeyboardActions(
        config: _buildConfig(context),
    child:

        SingleChildScrollView(
            child:
            Stack(children: [

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(150), SizeConfig().h(25), 0),
                child:
            Column(
              children: [

                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.profile"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(25),
                        end: SizeConfig().w(25),
                      )),
                  alignment: AlignmentDirectional.topStart,
                ),

                /*Align(child:

                InkWell(child: (profilePhotoURL != "") ? Image.network(
                  profilePhotoURL, width: 100, height: 100,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return CustomLoading();
                  },
                ) : (imageFile != null) ? Image.file(File(imageFile!.path), width: 100, height: 100,) : SvgPicture.asset("assets/svg/profile_logo.svg"),
                onTap: () async {
                  hideKeyboard(context);
                  /*ImagePicker _picker = ImagePicker();
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(()  {
                      profilePhotoURL = "";
                      imageFile = image;
                    });

                    if (imageFile != null)
                    {
                      File f = File(imageFile!.path);
                      widget.bloc.add(UploadProfileImageEvent(f));
                    }
                  }*/
                },
                ),

                  alignment: AlignmentDirectional.topCenter,),*/

                Padding(
                  padding: EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                  child: CustomTextFieldWidget(
                      controller: nameController,
                      focusNode: nameNode,
                      errorText: translate("messages.thisFieldMustBeFilledIn"),
                      validator: validateName,
                      hintText: translate("labels.name"),
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(phoneNode)),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.only(top: SizeConfig().h(0)),
                  child: CustomTextFieldWidget(
                      controller: phoneController,
                      errorText: translate("messages.phoneNumberValidation"),
                      focusNode: phoneNode,
                      validator: validateMobile,
                      hintText: translate("labels.phoneNumber"),
                      textInputType: TextInputType.phone,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (_) {}
                ),
                ),


                if (widget.state is LoadingUserState)
                  Padding(child: const CustomLoading(),
                    padding: EdgeInsetsDirectional.only(top: SizeConfig().h(72), bottom:SizeConfig().h(92)),)
                else
                    Padding(
                        padding: EdgeInsetsDirectional.only(top: SizeConfig().h(10)),
                        child: CustomButton(
                            backColor: buttonColor1,
                            titleColor: Colors.white,
                            borderColor: buttonColor1,
                            title: translate("buttons.save"),
                            onTap: () {

                              _updateProfile();

                            })),
                (widget.state is LoadingUserState) ? Container() :
                Padding(
                    padding: EdgeInsetsDirectional.only(top: SizeConfig().h(10)),
                    child: CustomButton(
                        backColor: buttonColor1,
                        titleColor: Colors.white,
                        borderColor: buttonColor1,
                        title: translate("buttons.removeAccount"),
                        onTap: () {

                          _removeAccount();

                        })),


              ],
            ),),
              BackButtonWidget(context)
            ],)
        )));
  }


  _removeAccount() async {

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

    String fullNumber = countryCode+pn;

    if (!widget.bloc.isClosed)
      widget.bloc.add(CallOTPScreenEvent(fullNumber, null, null, null, true));
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


  _updateProfile() async {
    if ((phoneController.text.isNotEmpty) && (nameController.text.isNotEmpty)){
      if (!validateMobile(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      if (!validateName(nameController.text))
        FocusScope.of(context).requestFocus(nameNode);

      hideKeyboard(context);

      UserModel.User u = await getCurrentUserValue();

      UserModel.User newUser = new UserModel.User(id: u.id,
        firstName: nameController.text,
        lastName: nameController.text,
        username: nameController.text,
        mobileNumber: convertArabicToEnglishNumbers(u.mobileNumber!),
        roleId: u.roleId,
        imageURL: profilePhotoURL,
        disabled: u.disabled
      );

      await setCurrentUserValue(newUser);

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

      pn = convertArabicToEnglishNumbers(pn);

      if (u != null) {
        if (u.id != null) {
          if (u.mobileNumber != pn)
            {
              phoneIsChanged = true;



              if (!widget.bloc.isClosed) {
                String fullNumber = countryCode + pn;
                UpdateProfileBody updateProfileBody = UpdateProfileBody(name: nameController.text, mobileNumber: pn, imageURL: profilePhotoURL);
                widget.bloc.add(CallOTPScreenEvent(fullNumber, null, updateProfileBody, null, false));
              }



              /*
              await auth.verifyPhoneNumber(
                  phoneNumber: countryCode + pn,
                  timeout: const Duration(seconds: 5),
                  verificationCompleted: await (PhoneAuthCredential credential) {
                    print("OTP is valid");
                  },
                  verificationFailed: await (FirebaseAuthException e) {},
                  codeSent: await (String verificationId, int? resendToken) async {
                    String verId = verificationId;
                    String smsCode = "";

                    if (Platform.isIOS) {

                      OTPVerificationPhoneBody otpVerificationPhoneBody = OTPVerificationPhoneBody(verificationId: verId, phoneNumber: fullNumber);

                      OTPCodeVerificationBody? otpCodeVerification = await Navigator.pushNamed(
                          context, OTPValidationPage.route,
                          arguments: otpVerificationPhoneBody) as OTPCodeVerificationBody?;

                      if (otpCodeVerification != null) {
                        smsCode = otpCodeVerification.code;
                        verId = otpCodeVerification.verificationId;
                      }
                      if (smsCode.isNotEmpty) {
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                            verificationId: verId, smsCode: smsCode);
                        auth.signInWithCredential(credential).then((value) {
                          if (!widget.bloc.isClosed)
                            widget.bloc.add(UpdateProfileEvent(UpdateProfileBody(name: nameController.text, mobileNumber: pn, imageURL: profilePhotoURL)));
                          print(value);
                        }).catchError((e) {
                          if (!widget.bloc.isClosed)
                            widget.bloc.add(ErrorUserOTPVerificationEvent(
                              (e.message != null) ? e.message! : e.code));
                        });
                      }
                      else
                      if (!widget.bloc.isClosed)
                        widget.bloc.add(ErrorUserOTPVerificationEvent(
                            translate("messages.emptyCode")));

                    }
                  },
                  codeAutoRetrievalTimeout: await (String verificationId) async {

                    String verId = verificationId;
                    String smsCode = "";

                    OTPVerificationPhoneBody otpVerificationPhoneBody = OTPVerificationPhoneBody(verificationId: verId, phoneNumber: fullNumber);

                    OTPCodeVerificationBody? otpCodeVerification = await Navigator.pushNamed(
                        context, OTPValidationPage.route,
                        arguments: otpVerificationPhoneBody) as OTPCodeVerificationBody?;

                    if (otpCodeVerification != null) {
                      smsCode = otpCodeVerification.code;
                      verId = otpCodeVerification.verificationId;
                    }
                    if (smsCode.isNotEmpty) {

                      PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verId, smsCode: smsCode);
                      auth.signInWithCredential(credential).then((value) {
                        if (!widget.bloc.isClosed)
                          widget.bloc.add(UpdateProfileEvent(UpdateProfileBody(name: nameController.text, mobileNumber: pn, imageURL: profilePhotoURL)));
                      }).catchError((e) {
                        if (!widget.bloc.isClosed)
                          widget.bloc.add(ErrorUserOTPVerificationEvent(
                            (e.message != null) ? e.message! : e.code));
                      });
                    }
                  }); */
            }
          else
            {
              phoneIsChanged = false;
              if (!widget.bloc.isClosed)
                widget.bloc.add(UpdateProfileEvent(UpdateProfileBody(name: nameController.text, mobileNumber: pn, imageURL: profilePhotoURL)));
            }
        }
      }

    }
    else {}
  }




  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    phoneNode.dispose();
    nameNode.dispose();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context){
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: nameNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(phoneNode);
                }
                ,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(translate("buttons.next"), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            }
          ]),

          KeyboardActionsItem(focusNode: phoneNode, toolbarButtons: [
                (node) {
              return GestureDetector(
                onTap: () {
                  _updateProfile();
                }
                ,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(translate("buttons.apply"), style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            }
          ]),

        ]);
  }
}
