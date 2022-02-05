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
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';

import 'helper/app_colors.dart';
import 'helper/methods.dart';
import 'ui/auth/login_page.dart';
import 'firebase_options.dart';


final logger = Logger();
bool isSigned=false;
String languageCode = "en";

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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


  LocalData().getLanguage().then((l) {
    if (l != null) {
      if (l.isNotEmpty)
        {
          languageCode = l;
        }
    }
  });

  runApp(LocalizedApp(delegate, FastFillApp()));
}

class FastFillApp extends StatefulWidget {
  @override
  _FastFillApp createState() => _FastFillApp();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _FastFillApp? state = context.findAncestorStateOfType<_FastFillApp>();
    state?.changeLanguage(newLocale);
  }

  static Locale? getLocale(BuildContext context) {
    _FastFillApp? state = context.findAncestorStateOfType<_FastFillApp>();
    return state?.getLanguage();
  }

  //static _FastFillApp? of(BuildContext context) => context.findAncestorStateOfType<_FastFillApp>();
}

class _FastFillApp extends State<FastFillApp> {
  Locale _locale = Locale.fromSubtags(languageCode: languageCode);

  changeLanguage(Locale value) {
    if (mounted) {
      setState(() {
        _locale = value;
      });
    }
  }

  Locale getLanguage()
  {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: GetMaterialApp(
            title: 'FastFill',
            onGenerateRoute: AppRouter.generateRoute,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              localizationDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: _locale,
            theme: ThemeData(
                primaryColor: primaryColor1,
                accentColor: primaryColor2,
                fontFamily: isArabic() ? 'Markazi' : 'Poppins'),
            initialRoute: (isSigned) ? HomePage.route : LanguagePage.route,
        ));
  }
}
