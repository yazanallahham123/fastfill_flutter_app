import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/ui/language/language_page.dart';
import 'package:fastfill/ui/splash_screen/splash_screen.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:fastfill/utils/local_notification_service.dart';
import 'package:fastfill/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:logger/logger.dart';

import 'helper/app_colors.dart';
import 'helper/methods.dart';
import 'ui/auth/login_page.dart';


final logger = Logger();
bool isSigned=false;

Future<void> backgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print(
        "The Notification from Background title is: " + message.notification!.title.toString());
    print("The Notification from Background Message is: " +
        message.notification!.body.toString());

  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'ar']);

  LocalData().getCurrentUserValue().then((v) {
    if (v != null)
      if (v.id != null)
        if (v.id != 0)
          isSigned = true;
  });

  runApp(LocalizedApp(delegate, FastFillApp()));
}

class FastFillApp extends StatefulWidget {
  @override
  _FastFillApp createState() => _FastFillApp();
}


class _FastFillApp extends State<FastFillApp> {

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: MaterialApp(
            title: 'FastFill',
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
            theme: ThemeData(
                primaryColor: primaryColor1,
                accentColor: primaryColor2,
                fontFamily: isArabic() ? 'Markazi' : 'Poppins'),
            initialRoute: LanguagePage.route//(isSigned) ? HomePage.route : LoginPage.route
          //initialRoute: SplashScreen.route
        ));
  }
}
