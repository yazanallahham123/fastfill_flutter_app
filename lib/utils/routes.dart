import 'package:fastfill/model/payment/payment_result_body.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/ui/auth/login_page.dart';
import 'package:fastfill/ui/auth/otp_validation_page.dart';
import 'package:fastfill/ui/auth/reset_password_password_page.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/contact_us/contact_us_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/ui/language/language_page.dart';
import 'package:fastfill/ui/profile/profile_page.dart';
import 'package:fastfill/ui/search/search_page.dart';
import 'package:fastfill/ui/settings/settings_page.dart';
import 'package:fastfill/ui/splash_screen/splash_screen.dart';
import 'package:fastfill/ui/station/payment_result_page.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:fastfill/ui/terms/terms_page.dart';
import 'package:flutter/material.dart';

import '../model/station/station.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case SplashScreen.route:
        return PageRouteBuilder(
             pageBuilder: (context, animation, secondaryAnimation) => SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          }
        );
      case ProfilePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case SearchPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => SearchPage(searchText: settings.arguments as String,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case LoginPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case ResetPassword_PhoneNumberPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ResetPassword_PhoneNumberPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case ResetPassword_PasswordPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ResetPassword_PasswordPage(resetPasswordBody: settings.arguments as ResetPasswordBody,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case ContactUsPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ContactUsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case SettingsPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case LanguagePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => LanguagePage(forSettings: (settings.arguments != null) ? settings.arguments as bool : false,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case TermsPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => TermsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case PaymentResultPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => PaymentResultPage(paymentResultBody: settings.arguments as PaymentResultBody,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case SignupPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => SignupPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case PurchasePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => PurchasePage(station: settings.arguments as Station,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case OTPValidationPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => OTPValidationPage(verificationId: settings.arguments as String),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case HomePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },);
      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
    }
  }
}
