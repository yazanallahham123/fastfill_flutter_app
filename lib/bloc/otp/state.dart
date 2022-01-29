import 'package:equatable/equatable.dart';
import 'package:fastfill/model/otp/otp_resend_response_body.dart';
import 'package:fastfill/model/otp/otp_send_response_body.dart';
import 'package:fastfill/model/otp/otp_verify_response_body.dart';

abstract class OTPState extends Equatable{

  const OTPState();

  @override
  List<Object?> get props => [];
}

class InitOTPState extends OTPState{
  const InitOTPState();
}

class LoadingOTPState extends OTPState{
  const LoadingOTPState();
}

class ErrorOTPState extends OTPState{
  final String error;

  const ErrorOTPState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class SuccessOTPCodeSentState extends OTPState{
  final OTPSendResponseBody otpSendResponseBody;

  const SuccessOTPCodeSentState(this.otpSendResponseBody);

  @override
  List<Object?> get props => [this.otpSendResponseBody];
}

class SuccessOTPCodeResentState extends OTPState{
  final OTPResendResponseBody otpResendResponseBody;

  const SuccessOTPCodeResentState(this.otpResendResponseBody);

  @override
  List<Object?> get props => [this.otpResendResponseBody];
}

class SuccessOTPCodeVerifiedState extends OTPState{
  final OTPVerifyResponseBody otpVerifyResponseBody;

  const SuccessOTPCodeVerifiedState(this.otpVerifyResponseBody);

  @override
  List<Object?> get props => [this.otpVerifyResponseBody];
}

class OTPResendCode extends OTPState{
  final String otp_id;

  const OTPResendCode(this.otp_id);

  @override
  List<Object?> get props => [this.otp_id];
}