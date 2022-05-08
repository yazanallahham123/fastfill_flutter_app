import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/user/add_bank_card_body.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signup_body.dart';
import 'package:fastfill/model/user/update_profile_body.dart';
import 'package:fastfill/model/user/user_refill_transaction_dto.dart';

import '../../model/syberPay/syber_pay_get_url_body.dart';

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

class UpdateProfileEvent extends UserEvent{
  final UpdateProfileBody updateProfileBody;

  const UpdateProfileEvent(this.updateProfileBody);

  @override
  List<Object?> get props => [this.updateProfileBody];
}

class GetNotificationsEvent extends UserEvent{
  final int page;
  const GetNotificationsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class UploadProfileImageEvent extends UserEvent{
  final File imageFile;

  const UploadProfileImageEvent(this.imageFile);

  @override
  List<Object?> get props => [this.imageFile];
}

class GetSyberPayUrlEvent extends UserEvent {
  final SyberPayGetUrlBody syberPayGetUrlBody;

  const GetSyberPayUrlEvent(this.syberPayGetUrlBody);

  @override
  List<Object?> get props => [this.syberPayGetUrlBody];
}



class GetBankCardsEvent extends UserEvent {
  const GetBankCardsEvent();
}

class AddBankCardEvent extends UserEvent {
  final AddBankCardBody addBankCardBody;

  const AddBankCardEvent(this.addBankCardBody);

  @override
  List<Object?> get props => [this.addBankCardBody];
}

class DeleteBankCardEvent extends UserEvent {
  final int bankCardId;
  const DeleteBankCardEvent(this.bankCardId);

  @override
  List<Object?> get props => [this.bankCardId];

}

class GetUserBalanceEvent extends UserEvent {
  const GetUserBalanceEvent();
}

class UpdateUserLanguageEvent extends UserEvent {
  final int languageId;

  const UpdateUserLanguageEvent(this.languageId);

  @override
  List<Object?> get props => [this.languageId];
}

class ClearUserNotificationsEvent extends UserEvent {
  const ClearUserNotificationsEvent();
}

