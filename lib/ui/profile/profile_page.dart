import 'dart:io';

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
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/utils/local_data.dart';
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

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(),//.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is ErrorLoginState)
            pushToast(state.error);
          else if (state is SuccessLoginState) {
            await LocalData().setCurrentUserValue(
                state.loginUser.value!.userDetails!);
            await LocalData().setTokenValue(state.loginUser.value!.token!);
            pushToast(translate("messages.youLoggedSuccessfully"));
            Navigator.pushNamedAndRemoveUntil(context, HomePage.route, (Route<dynamic> route) => false);
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
  final phoneNode = FocusNode();
  final nameNode = FocusNode();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  XFile? imageFile = null;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    SizeConfig().init(context);
    return Scaffold(

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

                InkWell(child: (imageFile != null) ? Image.file(File(imageFile!.path), width: 100, height: 100,) : SvgPicture.asset("assets/svg/profile_logo.svg"),
                onTap: () async {
                  ImagePicker _picker = ImagePicker();
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(()  {
                      imageFile = image;
                    });
                    File f = File(image.path);
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

                if (widget.state is LoadingLoginState)
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

                            })),


              ],
            ),),
              BackButtonWidget(context)
            ],)
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
    nameController.dispose();
    phoneController.dispose();
    phoneNode.dispose();
    nameNode.dispose();
  }
}
