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
import 'package:fastfill/helper/firebase_helper.dart';
import 'package:fastfill/helper/font_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/user/update_profile_body.dart';
import 'package:fastfill/model/user/user.dart' as UserModel;
import 'package:fastfill/ui/auth/login_page.dart';
import 'package:fastfill/ui/auth/otp_validation_page.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:fastfill/utils/misc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';


class ProfilePage extends StatefulWidget {
  static const route = "/profile_page";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

String profilePhotoURL = "";

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
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is UploadedProfilePhoto)
            {
              if (mounted) {
                setState(() {
                  profilePhotoURL = state.profilePhotoURL;
                });
              }
            }
          else if (state is UserProfileUpdated) {
            UserModel.User user = UserModel.User(lastName: null, firstName: null, disabled: null, id: null, mobileNumber: null, roleId: null, username: null);
            await LocalData().setCurrentUserValue(user);
            Navigator.pushNamedAndRemoveUntil(
                context, LoginPage.route, (Route<dynamic> route) => false);
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
  XFile? imageFile = null;

  @override
  void initState() {
    super.initState();

    LocalData().getCurrentUserValue().then((user) {
      phoneController.text = user.mobileNumber??"";
      nameController.text = user.firstName??"";
      profilePhotoURL = user.imageURL??"";
    });

  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1 ,
        body:
        SingleChildScrollView(
            child:
            Stack(children: [

              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(25), SizeConfig().h(150), SizeConfig().h(25), 0),
                child:
            Column(
              children: [


                Align(child:

                InkWell(child: (profilePhotoURL != "") ? Image.network(profilePhotoURL, width: 100, height: 100,) : (imageFile != null) ? Image.file(File(imageFile!.path), width: 100, height: 100,) : SvgPicture.asset("assets/svg/profile_logo.svg"),
                onTap: () async {
                  hideKeyboard(context);
                  ImagePicker _picker = ImagePicker();
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
                  }
                },
                ),

                  alignment: AlignmentDirectional.topCenter,),

                Padding(
                  padding: EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                  child: CustomTextFieldWidget(
                      controller: nameController,
                      focusNode: nameNode,
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


              ],
            ),),
              BackButtonWidget(context)
            ],)
        ));
  }

  _updateProfile() async {
    if ((phoneController.text.isNotEmpty) && (nameController.text.isNotEmpty)){
      if (!validateMobile(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      if (!validateName(nameController.text))
        FocusScope.of(context).requestFocus(nameNode);

      hideKeyboard(context);

      UserModel.User u = await LocalData().getCurrentUserValue();

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

      if (u != null) {
        if (u.id != null) {
          if (u.mobileNumber != pn)
            {



              widget.bloc.add(CallOTPScreenEvent());
              await auth.verifyPhoneNumber(
                  phoneNumber: countryCode + pn,
                  timeout: const Duration(seconds: 5),
                  verificationCompleted: await (PhoneAuthCredential credential) {
                    print("OTP is valid");
                  },
                  verificationFailed: await (FirebaseAuthException e) {},
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
                          widget.bloc.add(UpdateProfileEvent(UpdateProfileBody(name: nameController.text, mobileNumber: pn, imageURL: profilePhotoURL)));
                        }).catchError((e) {
                          widget.bloc.add(ErrorUserOTPVerificationEvent(
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
                        widget.bloc.add(UpdateProfileEvent(UpdateProfileBody(name: nameController.text, mobileNumber: pn, imageURL: profilePhotoURL)));
                      }).catchError((e) {
                        widget.bloc.add(ErrorUserOTPVerificationEvent(
                            (e.message != null) ? e.message! : e.code));
                      });
                    }
                  });
            }
          else
            {
              widget.bloc.add(UpdateProfileEvent(UpdateProfileBody(name: nameController.text, mobileNumber: pn, imageURL: profilePhotoURL)));
            }
        }
      }

    }
    else {}
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
    nameController.dispose();
    phoneController.dispose();
    phoneNode.dispose();
    nameNode.dispose();
  }
}
