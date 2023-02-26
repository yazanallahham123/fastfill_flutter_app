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


class OTPResendCodeEvent extends OTPEvent{
  final String mobileNumber;

  const OTPResendCodeEvent(this.mobileNumber);

  @override
  List<Object?> get props => [this.mobileNumber];
}
