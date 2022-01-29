
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/login/login_user.dart';
import 'package:fastfill/model/otp/otp_resend_response_body.dart';
import 'package:fastfill/model/otp/otp_send_response_body.dart';
import 'package:fastfill/model/otp/otp_validation_body.dart';
import 'package:fastfill/model/otp/otp_verify_response_body.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/station/station_branches_with_pagination.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signedup_user.dart';
import 'package:fastfill/model/user/signup_body.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
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

  @GET(Apis.station+"/frequentlyVisited")
  Future<StationBranchesWithPagination> getFrequentlyVisitedStationsBranches(@Header("Authorization") String token);

  @GET(Apis.station+"/favorites")
  Future<StationBranchesWithPagination> getFavoritesStationsBranches(@Header("Authorization") String token);

  @GET(Apis.station+"/getByNumber/{Number}")
  Future<StationBranch> getStationByNumber(@Header("Authorization") String token,
      @Path("Number") int number);

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

}
