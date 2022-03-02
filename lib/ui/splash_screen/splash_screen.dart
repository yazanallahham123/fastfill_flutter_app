import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  static const route = "/splash_screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSigned=false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    SizeConfig().init(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1,
        body: Container());
  }

  @override
  void initState() {
    super.initState();

    LocalData().getCurrentUserValue().then((v) {
      if (v != null)
        if (v.id != null)
          if (v.id != 0)
            isSigned = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }
}
