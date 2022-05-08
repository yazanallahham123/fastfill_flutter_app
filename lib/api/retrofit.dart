
import 'dart:io';

import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/login/login_user.dart';
import 'package:fastfill/model/notification/notification_body.dart';
import 'package:fastfill/model/notification/notifications_with_pagination.dart';
import 'package:fastfill/model/otp/otp_resend_response_body.dart';
import 'package:fastfill/model/otp/otp_send_response_body.dart';
import 'package:fastfill/model/otp/otp_validation_body.dart';
import 'package:fastfill/model/otp/otp_verify_response_body.dart';
import 'package:fastfill/model/station/add_remove_station_favorite_body.dart';
import 'package:fastfill/model/station/payment_transaction_body.dart';
import 'package:fastfill/model/station/payment_transactions_with_pagination.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/station/station_branches_with_pagination.dart';
import 'package:fastfill/model/syberPay/syber_pay_check_status_body.dart';
import 'package:fastfill/model/syberPay/syber_pay_get_url_body.dart';
import 'package:fastfill/model/syberPay/syber_pay_get_url_response_body.dart';
import 'package:fastfill/model/user/add_bank_card_body.dart';
import 'package:fastfill/model/user/bank_cards_with_pagination.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signedup_user.dart';
import 'package:fastfill/model/user/signup_body.dart';
import 'package:fastfill/model/user/update_firebase_token_body.dart';
import 'package:fastfill/model/user/update_profile_body.dart';
import 'package:fastfill/model/user/upload_result.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/model/user/user_refill_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../model/station/add_remove_station_branch_favorite_body.dart';
import '../model/station/stations_with_pagination.dart';
import '../model/syberPay/syber_pay_check_status_response_body.dart';
import '../model/user/update_user_language_body.dart';
import '../model/user/user_refill_transaction_dto.dart';
import 'apis.dart';
import 'package:http_parser/http_parser.dart';
part 'retrofit.g.dart';


@RestApi(baseUrl: Apis.baseURL)
@Headers(<String, dynamic>{"Content-Type": "application/json"})
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  //=========== Login ==============

  @POST(Apis.login)
  Future<LoginUser> loginUser(@Body() LoginBody loginBody);

  @POST(Apis.user+"/user")
  Future<SignedUpUser> signup(@Body() SignupBody? signupBody);

  @PUT(Apis.user+"/resetPassword")
  Future<String> resetPassword(@Body() ResetPasswordBody? resetPasswordBody);

  //SMS

  @POST(Apis.otpSendCode)
  @MultiPart()
  @Headers(<String, dynamic>{"Content-Type": "multi-part/form-data", "accept":"*/*", "Authorization":"Token ba7758237f501dcc97cf77292607640a4afd32bb"})
  Future<OTPSendResponseBody> otpSendCode(@Part(name: "mobile") String mobile, @Part(name: "sender_id") String senderId, @Part(name: "message") String message, @Part(name: "expiry") String expiry);

  @POST(Apis.otpResendCode)
  @MultiPart()
  @Headers(<String, dynamic>{"Content-Type": "multi-part/form-data", "accept":"*/*", "Authorization":"Token ba7758237f501dcc97cf77292607640a4afd32bb"})
  Future<OTPResendResponseBody> otpResendCode(@Part(name: "otp_id") String otp_id);

  @POST(Apis.otpVerifyCode)
  @MultiPart()
  @Headers(<String, dynamic>{"Content-Type": "multi-part/form-data", "accept":"*/*", "Authorization":"Token ba7758237f501dcc97cf77292607640a4afd32bb"})
  Future<OTPVerifyResponseBody> otpVerifyCode(@Part(name: "otp_id") String otp_id, @Part(name: "code") String code);


  @GET(Apis.frequentlyVisitedCompanies)
  Future<StationsWithPagination> getFrequentlyVisitedStations(@Header("Authorization") String token);

  @GET(Apis.favoriteCompanies)
  Future<StationsWithPagination> getFavoritesStations(@Header("Authorization") String token);


  //Station

  @GET(Apis.frequentlyVisitedCompaniesBranches)
  Future<StationBranchesWithPagination> getFrequentlyVisitedStationsBranches(@Header("Authorization") String token);

  @GET(Apis.favoriteCompaniesBranches)
  Future<StationBranchesWithPagination> getFavoritesStationsBranches(@Header("Authorization") String token);

  @GET(Apis.companyBranchByText+"/{text}")
  Future<StationBranchesWithPagination> getStationBranchByText(@Header("Authorization") String token,
      @Path("text") String text, @Query("page") int page, @Query("pageSize") int pageSize);

  @GET(Apis.companyByText+"/{text}")
  Future<StationsWithPagination> getStationByText(@Header("Authorization") String token,
      @Path("text") String text, @Query("page") int page, @Query("pageSize") int pageSize);

  @PUT(Apis.addCompanyToFavorite)
  Future<bool> addStationToFavorite(@Header("Authorization") String token,
      @Body() AddRemoveStationFavoriteBody addRemoveStationFavoriteBody);

  @PUT(Apis.removeCompanyFromFavorite)
  Future<bool> removeStationFromFavorite(@Header("Authorization") String token,
      @Body() AddRemoveStationFavoriteBody addRemoveStationFavoriteBody);

  @PUT(Apis.addCompanyBranchToFavorite)
  Future<bool> addStationBranchToFavorite(@Header("Authorization") String token,
      @Body() AddRemoveStationBranchFavoriteBody addRemoveStationBranchFavoriteBody);

  @PUT(Apis.removeCompanyBranchFromFavorite)
  Future<bool> removeStationBranchFromFavorite(@Header("Authorization") String token,
      @Body() AddRemoveStationBranchFavoriteBody addRemoveStationBranchFavoriteBody);

  @GET(Apis.allCompaniesBranches)
  Future<StationBranchesWithPagination> getAllStationsBranches(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  @GET(Apis.allCompanies)
  Future<StationsWithPagination> getAllStations(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @PUT(Apis.updateUserProfile)
  Future<String> updateUserProfile(@Header("Authorization") String token, @Body() UpdateProfileBody updateProfileBody);

  //User
  @PUT(Apis.updateFirebaseToken)
  Future<String> updateFirebaseToken(@Header("Authorization") String token, @Body() UpdateFirebaseTokenBody updateFirebaseTokenBody);

  //User
  @POST(Apis.addNotification)
  Future<bool> addNotification(@Header("Authorization") String token, @Body() NotificationBody notificationBody);

  //User
  @GET(Apis.getNotifications)
  Future<NotificationsWithPagination> getNotifications(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  //User
  @POST(Apis.addPaymentTransaction)
  Future<bool> addPaymentTransaction(@Header("Authorization") String token, @Body() PaymentTransactionBody paymentTransactionBody);

  @GET(Apis.getPaymentTransactions)
  Future<PaymentTransactionsWithPagination> getPaymentTransactions(@Header("Authorization") String token, @Query("page") int page, @Query("pageSize") int pageSize);

  @POST(Apis.uploadProfilePhoto)
  @MultiPart()
  @Headers(<String, dynamic>{"Content-Type":"multi-part/form-data", "accept":"*/*"})
  Future<UploadResult> uploadProfilePhoto(@Header("Authorization") String token, @Part(contentType: "image/*", name: "file") File file);

  //User
  @POST(Apis.syberGetUrl)
  Future<SyberPayGetUrlResponseBody> syberPayGetUrl(@Header("Authorization") String token, @Body() SyberPayGetUrlBody syberPayGetUrlBody);

  @POST(Apis.addBankCard)
  Future<bool> addBankCard(@Header("Authorization") String token, @Body() AddBankCardBody addBankCardBody);

  @GET(Apis.getBankCards)
  Future<BankCardsWithPagination> getBankCards(@Header("Authorization") String token,  @Query("page") int page, @Query("pageSize") int pageSize);

  @DELETE(Apis.deleteBankCard)
  Future<bool> deleteBankCard(@Header("Authorization") String token, @Path("id") int id);

  @POST(Apis.addUserRefillTransaction)
  Future<bool> addUserRefillTransaction(@Header("Authorization") String token, @Body() UserRefillTransactionDto userRefillTransactionDto);

  @PUT(Apis.updateUserLanguage)
  Future<bool> updateUserLanguage(@Header("Authorization") String token, @Body() UpdateUserLanguageBody updateUserLanguageBody);

  @GET(Apis.getUserBalance)
  Future<double> getUserBalance(@Header("Authorization") String token);

  @GET(Apis.clearUserNotifications)
  Future<bool> clearUserNotifications(@Header("Authorization") String token);

  @POST(Apis.syberCheckStatus)
  Future<SyberPayCheckStatusResponseBody> syberCheckStatus(@Body() SyberPayCheckStatusBody syberPayCheckStatusBody);

}
