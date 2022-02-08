// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://fastfill.developitech.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginUser> loginUser(loginBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginBody.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginUser>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignedUpUser> signup(signupBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(signupBody?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignedUpUser>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'User/user',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignedUpUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> resetPassword(resetPasswordBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(resetPasswordBody?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/resetPassword',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<OTPSendResponseBody> otpSendCode(
      mobile, senderId, message, expiry) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'multi-part/form-data',
      r'accept': '*/*',
      r'Authorization': 'Token ba7758237f501dcc97cf77292607640a4afd32bb'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry('mobile', mobile));
    _data.fields.add(MapEntry('sender_id', senderId));
    _data.fields.add(MapEntry('message', message));
    _data.fields.add(MapEntry('expiry', expiry));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OTPSendResponseBody>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'https://d7networks.com/api/verifier/send',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OTPSendResponseBody.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OTPResendResponseBody> otpResendCode(otp_id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'multi-part/form-data',
      r'accept': '*/*',
      r'Authorization': 'Token ba7758237f501dcc97cf77292607640a4afd32bb'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry('otp_id', otp_id));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OTPResendResponseBody>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'https://d7networks.com/api/verifier/resend',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OTPResendResponseBody.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OTPVerifyResponseBody> otpVerifyCode(otp_id, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'multi-part/form-data',
      r'accept': '*/*',
      r'Authorization': 'Token ba7758237f501dcc97cf77292607640a4afd32bb'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.fields.add(MapEntry('otp_id', otp_id));
    _data.fields.add(MapEntry('code', code));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OTPVerifyResponseBody>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'https://d7networks.com/api/verifier/verify',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OTPVerifyResponseBody.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StationBranchesWithPagination> getFrequentlyVisitedStationsBranches(
      token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationBranchesWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'Company/FrequentlyVisitedCompaniesBranches',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationBranchesWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StationBranchesWithPagination> getFavoritesStationsBranches(
      token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationBranchesWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Company/FavoriteCompaniesBranches',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationBranchesWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StationBranch> getStationByCode(token, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationBranch>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Company/CompanyBranchByCode/${code}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationBranch.fromJson(_result.data!);
    return value;
  }

  @override
  Future<bool> addStationToFavorite(token, addRemoveStationFavoriteBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(addRemoveStationFavoriteBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'Company/AddToFavorite',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> removeStationFromFavorite(
      token, addRemoveStationFavoriteBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(addRemoveStationFavoriteBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'Company/RemoveFromFavorite',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> updateUserProfile(token, updateProfileBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateProfileBody.toJson());
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/UpdateUserProfile',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
