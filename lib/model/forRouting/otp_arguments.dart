import 'package:fastfill/model/forRouting/enums.dart';
import 'package:fastfill/model/user/change_mobile_number_body.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signup_body.dart';

class OTPArguments {
  final OtpForType otpForType;
  final SignupBody? signupBody;
  final ResetPasswordBody? resetPasswordBody;
  final ChangeMobileNumberBody? changeMobileNumberBody;
  const OTPArguments({required this.otpForType, this.signupBody, this.resetPasswordBody, this.changeMobileNumberBody});
}