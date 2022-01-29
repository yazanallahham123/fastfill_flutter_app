import 'package:equatable/equatable.dart';
import 'package:fastfill/model/otp/otp_validation_body.dart';

abstract class OTPEvent extends Equatable{

  const OTPEvent();

  @override
  List<Object?> get props => [];
}

class OTPInitEvent extends OTPEvent {
  const OTPInitEvent();
}

class OTPSendCodeEvent extends OTPEvent{
  final String mobileNumber;

  const OTPSendCodeEvent(this.mobileNumber);

  @override
  List<Object?> get props => [this.mobileNumber];
}

class OTPResendCodeEvent extends OTPEvent{
  final String otp_id;

  const OTPResendCodeEvent(this.otp_id);

  @override
  List<Object?> get props => [this.otp_id];
}

class OTPVerifyCodeEvent extends OTPEvent{
  final String otp_id;
  final String code;

  const OTPVerifyCodeEvent(this.otp_id, this.code);

  @override
  List<Object?> get props => [this.otp_id, this.code];
}