
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
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signedup_user.dart';
import 'package:fastfill/model/user/signup_body.dart';
import 'package:fastfill/model/user/update_firebase_token_body.dart';
import 'package:fastfill/model/user/update_profile_body.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../model/station/add_remove_station_branch_favorite_body.dart';
import 'apis.dart';
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

  //Station

  @GET(Apis.frequentlyVisitedCompaniesBranches)
  Future<StationBranchesWithPagination> getFrequentlyVisitedStationsBranches(@Header("Authorization") String token);

  @GET(Apis.favoriteCompaniesBranches)
  Future<StationBranchesWithPagination> getFavoritesStationsBranches(@Header("Authorization") String token);

  @GET(Apis.companyBranchByCode+"/{text}")
  Future<StationBranchesWithPagination> getStationBranchByCode(@Header("Authorization") String token,
      @Path("text") String text, @Query("page") int page, @Query("pageSize") int pageSize);

  @GET(Apis.companyByCode+"/{code}")
  Future<StationBranch> getStationByCode(@Header("Authorization") String token,
      @Path("code") String code);

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
  Future<StationBranchesWithPagination> getAllStationsBranches(@Header("Authorization") String token);


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

}
