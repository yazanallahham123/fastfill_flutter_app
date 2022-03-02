import 'package:fastfill/bloc/login/bloc.dart';
import 'package:fastfill/bloc/login/event.dart';
import 'package:fastfill/bloc/login/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/common_widgets/custom_drop_down_button/custom_drop_down_button.dart';
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
import 'package:fastfill/main.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/ui/auth/login_page.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

import '../../utils/misc.dart';

class LanguagePage extends StatefulWidget {
  static const route = "/language_page";

  final bool forSettings;

  const LanguagePage({required this.forSettings});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

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
              return _BuildUI(bloc: bloc, state: state, forSettings: widget.forSettings);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final LoginBloc bloc;
  final LoginState state;
  final bool forSettings;

  _BuildUI({required this.bloc, required this.state, required this.forSettings});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  String? currentLanguage = (languageCode == "en") ? "English" : "عربي";

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
          child: Stack(children: [Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsetsDirectional.only(
                top: SizeConfig().h(175),
                start: SizeConfig().w(20),
                end: SizeConfig().w(20)),
            padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
            child: Column(
              crossAxisAlignment : CrossAxisAlignment.start,
              children: [
                Padding(child:
                Text(
                  translate("labels.language"),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(40), 0, 0),),
      Padding(child:
      Text(translate("labels.selectYourLanguage")),padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(20), 0, 0)),
      Padding(child:
                CustomDropDownButton(items: ["English", "عربي"],
                  icon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black12,),
                  onChanged: (v) async {

                      currentLanguage = v;
                      if (currentLanguage == "English") {
                        await LocalData().setLanguageValue("en");
                        languageCode = "en";
                        FastFillApp.setLocale(context, Locale.fromSubtags(languageCode: "en"));
                        changeLocale(context, "en");
                        Get.updateLocale(Locale.fromSubtags(languageCode: "en"));
                      }
                      else
                        if (currentLanguage == "عربي") {
                          await LocalData().setLanguageValue("ar");
                          languageCode = "ar";
                          FastFillApp.setLocale(context, Locale.fromSubtags(languageCode: "ar"));
                          changeLocale(context, "ar");
                          Get.updateLocale(Locale.fromSubtags(languageCode: "ar"));
                        }
                  },
                  currentValue: currentLanguage,
                  popupTitle: Text(translate("labels.languages")),
                ),
                padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(40), 0, SizeConfig().h(20)),),

                Padding(
                    padding: EdgeInsetsDirectional.only(top: SizeConfig().h(10), bottom:  SizeConfig().h(40)),
                    child: CustomButton(
                        backColor: buttonColor1,
                        titleColor: Colors.white,
                        borderColor: buttonColor1,
                        title: (!widget.forSettings) ? translate("buttons.next") : translate("buttons.apply"),
                        onTap: () {
                          hideKeyboard(context);
                          if (!widget.forSettings) {
                            Navigator.pushNamed(context, LoginPage.route);
                          }
                          else
                            Navigator.pop(context, languageCode);
                        })),
              ],
            ),
          ),

            (widget.forSettings) ? BackButtonWidget(context) : Container()],),
        ));
  }
}
