import 'dart:convert';
import 'package:fastfill/model/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


  final _tokenKey = "Token";
  final _firebaseTokenKey = "FToken";
  final _user = "User";
  final _languageKey = "Language";
  final _receiveNotifications = "ReceiveNotifications";
  final _agreementStatus = "AgreementStatus";

  setLanguageValue(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language);
  }

  setAgreementStatus(bool agree) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_agreementStatus, agree);
  }

  setCurrentUserValue(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_user, json.encode(user));
  }

  setReceiveNotifications(bool receiveNotifications) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_receiveNotifications, receiveNotifications);
  }

  Future<User> getCurrentUserValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user;
    if (prefs.getString(_user) != null) {
      if (prefs.getString(_user) != "") {
        String c = prefs.getString(_user)!;
        var companyJson = json.decode(c);
        user = User.fromJson(companyJson);
        return user;
      }
      else
        return User();
    }
    else
      return User();
  }

  setFTokenValue(String newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firebaseTokenKey, newValue);
  }

  Future<String> getFTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_firebaseTokenKey) ?? "";
  }

  Future<bool> getReceiveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_receiveNotifications) ?? true;
  }


  setTokenValue(String newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, newValue);
  }

  Future<bool> getAgreementStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_agreementStatus) ?? false;
  }

  Future<String> getTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? "";
  }

  Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? "en";
  }

  Future<String?> getBearerTokenValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_tokenKey) != null)
      return "Bearer " + prefs.getString(_tokenKey)!;
    return null;
  }

