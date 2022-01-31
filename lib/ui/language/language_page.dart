import 'package:fastfill/bloc/login/bloc.dart';
import 'package:fastfill/bloc/login/event.dart';
import 'package:fastfill/bloc/login/state.dart';
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
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';


class LanguagePage extends StatefulWidget {
  static const route = "/language_page";

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
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
  String? currentLanguage = (isArabic()) ? "عربي" : "English";

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
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsetsDirectional. only(top: SizeConfig().h(175), start: SizeConfig().w(20), end: SizeConfig().w(20)),
            padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
            decoration:
            BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
            child:
                    Column(children: [
                    Text(translate("labels.language"), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text(translate("labels.selectYourLanguage")),
            DropdownButton<String>(
              value: "English",
              items: <String>["English", "عربي"].map((String value) {
                return DropdownMenuItem<String>(
                  value: currentLanguage,
                  child: Text(currentLanguage!),
                );
              }).toList(),
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    currentLanguage = value;
                  });
                }
              },
            )






              ],
            ),
          ),
        ));
  }
}
