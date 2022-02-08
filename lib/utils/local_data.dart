import 'dart:convert';
import 'package:fastfill/model/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static final LocalData _localData = LocalData._internal();

  factory LocalData() => _localData;

  SharedPreferences? _preferences;

  final _tokenKey = "Token";
  final _firebaseTokenKey = "FToken";
  final _user = "User";
  final _languageKey = "Language";
  final _receiveNotifications = "ReceiveNotifications";

  Future<SharedPreferences?> get _getSharedPref async {
    if (_preferences != null)
      return _preferences;
    else {
      _preferences = await SharedPreferences.getInstance();

      return _preferences;
    }
  }

  setLanguageValue(String language) async {
    await _getSharedPref;
    await _preferences!.setString(_languageKey, language);
  }

  setCurrentUserValue(User user) async {
    await _getSharedPref;
    await _preferences!.setString(_user, json.encode(user));
  }

  setReceiveNotifications(bool receiveNotifications) async {
    await _getSharedPref;
    await _preferences!.setBool(_receiveNotifications, receiveNotifications);
  }

  Future<User> getCurrentUserValue() async {
    await _getSharedPref;
    User user;
    if (_preferences!.getString(_user) != null) {
      if (_preferences!.getString(_user) != "") {
        String c = _preferences!.getString(_user)!;
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
    await _getSharedPref;
    await _preferences!.setString(_firebaseTokenKey, newValue);
  }

  Future<String> getFTokenValue() async {
    await _getSharedPref;
    return _preferences!.getString(_firebaseTokenKey) ?? "";
  }

  Future<bool> getReceiveNotifications() async {
    await _getSharedPref;
    return _preferences!.getBool(_receiveNotifications) ?? true;
  }

  setTokenValue(String newValue) async {
    await _getSharedPref;
    await _preferences!.setString(_tokenKey, newValue);
  }

  Future<String> getTokenValue() async {
    await _getSharedPref;
    return _preferences!.getString(_tokenKey) ?? "";
  }

  Future<String> getLanguage() async {
    await _getSharedPref;
    return _preferences!.getString(_languageKey) ?? "en";
  }

  Future<String?> getBearerTokenValue() async {
    await _getSharedPref;
    if (_preferences!.getString(_tokenKey) != null)
      return "Bearer " + _preferences!.getString(_tokenKey)!;
    return null;
  }

  static final LocalData pref = LocalData._internal();

  LocalData._internal();
}
