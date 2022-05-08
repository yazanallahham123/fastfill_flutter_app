import 'package:equatable/equatable.dart';
import 'package:fastfill/model/notification/notification_body.dart';
import 'package:fastfill/model/notification/notifications_with_pagination.dart';
import 'package:fastfill/model/user/bank_cards_with_pagination.dart';
import 'package:fastfill/model/user/reset_password_body.dart';
import 'package:fastfill/model/user/signedup_user.dart';
import 'package:fastfill/model/user/signup_body.dart';

import '../../model/syberPay/syber_pay_get_url_response_body.dart';

abstract class UserState extends Equatable{

  const UserState();

  @override
  List<Object?> get props => [];
}

class InitUserState extends UserState{
  const InitUserState();
}

class LoadingUserState extends UserState{
  const LoadingUserState();
}

class CallOTPScreenState extends UserState{
  const CallOTPScreenState();
}

class ErrorUserState extends UserState{
  final String error;

  const ErrorUserState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class SignedUpState extends UserState{
  final SignedUpUser signedUpUser;

  const SignedUpState(this.signedUpUser);

  @override
  List<Object?> get props => [this.signedUpUser];
}

class SuccessfulUserOTPVerificationState extends UserState{
  final SignupBody? signupBody;
  final ResetPasswordBody? resetPasswordBody;

  const SuccessfulUserOTPVerificationState(this.signupBody, this.resetPasswordBody);

  @override
  List<Object?> get props => [this.signupBody, this.resetPasswordBody];
}

class PasswordResetState extends UserState{
  final String passwordReset;

  const PasswordResetState(this.passwordReset);

  @override
  List<Object?> get props => [this.passwordReset];
}

class UserProfileUpdated extends UserState{
  final String profileUpdated;

  const UserProfileUpdated(this.profileUpdated);

  @override
  List<Object?> get props => [this.profileUpdated];

}

class GotNotificationsState extends UserState{
  final NotificationsWithPagination notifications;

  const GotNotificationsState(this.notifications);

  @override
  List<Object?> get props => [this.notifications];

}

class UploadedProfilePhotoState extends UserState{
  final String profilePhotoURL;

  const UploadedProfilePhotoState(this.profilePhotoURL);

  @override
  List<Object?> get props => [this.profilePhotoURL];

}

class GotSyberPayUrlState extends UserState{
  final SyberPayGetUrlResponseBody syberPayGetUrlResponseBody;

  const GotSyberPayUrlState(this.syberPayGetUrlResponseBody);

  @override
  List<Object?> get props => [this.syberPayGetUrlResponseBody];
}


class GotBankCardsState extends UserState{
  final BankCardsWithPagination bankCardsWithPagination;

  const GotBankCardsState(this.bankCardsWithPagination);

  @override
  List<Object?> get props => [this.bankCardsWithPagination];
}

class AddedBankCardState extends UserState{
  final bool result;

  const AddedBankCardState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class DeletedBankCardState extends UserState{
  final bool result;

  const DeletedBankCardState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class GotUserBalanceState extends UserState{
  final double balance;

  const GotUserBalanceState(this.balance);

  @override
  List<Object?> get props => [this.balance];
}

class UpdatedUserLanguageState extends UserState{
  final bool result;

  const UpdatedUserLanguageState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class ClearedUserNotificationsState extends UserState {
  final bool result;

  const ClearedUserNotificationsState(this.result);

  @override
  List<Object?> get props => [this.result];
}



