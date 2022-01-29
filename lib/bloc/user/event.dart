import 'package:equatable/equatable.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signup_body.dart';

abstract class UserEvent extends Equatable{

  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserInitEvent extends UserEvent {
  const UserInitEvent();
}

class SignupEvent extends UserEvent{
  final SignupBody? signupBody;

  const SignupEvent(this.signupBody);

  @override
  List<Object?> get props => [this.signupBody];
}

class SuccessfulUserOTPVerificationEvent extends UserEvent{
  final SignupBody? signupBody;
  final ResetPasswordBody? resetPasswordBody;

  const SuccessfulUserOTPVerificationEvent(this.signupBody, this.resetPasswordBody);

  @override
  List<Object?> get props => [this.signupBody, this.resetPasswordBody];
}

class ErrorUserOTPVerificationEvent extends UserEvent{
  final String errorMessage;
  const ErrorUserOTPVerificationEvent(this.errorMessage);

  @override
  List<Object?> get props => [this.errorMessage];
}

class CallOTPScreenEvent extends UserEvent{
  const CallOTPScreenEvent();
}

class ResetPasswordEvent extends UserEvent{
  final ResetPasswordBody? resetPasswordBody;

  const ResetPasswordEvent(this.resetPasswordBody);

  @override
  List<Object?> get props => [this.resetPasswordBody];
}