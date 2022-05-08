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
  Future<StationsWithPagination> getFrequentlyVisitedStations(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationsWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Company/FrequentlyVisitedCompanies',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationsWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StationsWithPagination> getFavoritesStations(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationsWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Company/FavoriteCompanies',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationsWithPagination.fromJson(_result.data!);
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
  Future<StationBranchesWithPagination> getStationBranchByText(
      token, text, page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationBranchesWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'Company/CompaniesBranchesByText/${text}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationBranchesWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StationsWithPagination> getStationByText(
      token, text, page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationsWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Company/CompaniesByText/${text}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationsWithPagination.fromJson(_result.data!);
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
  Future<bool> addStationBranchToFavorite(
      token, addRemoveStationBranchFavoriteBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(addRemoveStationBranchFavoriteBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'Company/AddBranchToFavorite',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> removeStationBranchFromFavorite(
      token, addRemoveStationBranchFavoriteBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(addRemoveStationBranchFavoriteBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'Company/RemoveBranchFromFavorite',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<StationBranchesWithPagination> getAllStationsBranches(
      token, page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationBranchesWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Company/AllCompaniesBranches',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationBranchesWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StationsWithPagination> getAllStations(token, page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StationsWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'Company/AllCompanies',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StationsWithPagination.fromJson(_result.data!);
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

  @override
  Future<String> updateFirebaseToken(token, updateFirebaseTokenBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateFirebaseTokenBody.toJson());
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/UpdateFirebaseToken',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> addNotification(token, notificationBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(notificationBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/AddNotification',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<NotificationsWithPagination> getNotifications(
      token, page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NotificationsWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'User/GetNotifications',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NotificationsWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<bool> addPaymentTransaction(token, paymentTransactionBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(paymentTransactionBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/AddPaymentTransaction',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<PaymentTransactionsWithPagination> getPaymentTransactions(
      token, page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentTransactionsWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'User/GetPaymentTransactions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PaymentTransactionsWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UploadResult> uploadProfilePhoto(token, file) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'multi-part/form-data',
      r'accept': '*/*',
      r'Authorization': token
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = FormData();
    _data.files.add(MapEntry(
        'file',
        MultipartFile.fromFileSync(file.path,
            filename: file.path.split(Platform.pathSeparator).last,
            contentType: MediaType.parse('image/*'))));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UploadResult>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'User/UploadLogo',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UploadResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SyberPayGetUrlResponseBody> syberPayGetUrl(
      token, syberPayGetUrlBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(syberPayGetUrlBody.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SyberPayGetUrlResponseBody>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'https://syberpay.sybertechnology.com/syberpay/getUrl',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SyberPayGetUrlResponseBody.fromJson(_result.data!);
    return value;
  }

  @override
  Future<bool> addBankCard(token, addBankCardBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(addBankCardBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/AddBankCard',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<BankCardsWithPagination> getBankCards(token, page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BankCardsWithPagination>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'User/GetBankCards',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BankCardsWithPagination.fromJson(_result.data!);
    return value;
  }

  @override
  Future<bool> deleteBankCard(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'DELETE', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/DeleteBankCard/${id}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> addUserRefillTransaction(token, userRefillTransactionDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(userRefillTransactionDto.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/addUserRefillTransaction',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> updateUserLanguage(token, updateUserLanguageBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(updateUserLanguageBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'PUT', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/UpdateUserLanguage',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<double> getUserBalance(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<double>(_setStreamType<double>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/GetUserBalance',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> clearUserNotifications(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'User/ClearNotifications',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<SyberPayCheckStatusResponseBody> syberCheckStatus(
      syberPayCheckStatusBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(syberPayCheckStatusBody.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SyberPayCheckStatusResponseBody>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options,
                'https://syberpay.sybertechnology.com/syberpay/payment_status',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SyberPayCheckStatusResponseBody.fromJson(_result.data!);
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
