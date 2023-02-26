import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/model/user/signedup_user.dart';
import 'package:fastfill/model/user/update_user_language_body.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fastfill/model/login/login_user.dart' as LoginModel;
import 'event.dart';
import 'state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late ApiClient mClient;

  UserBloc() : super(InitUserState()) {
    mClient = ApiClient(certificateClient());
     on<UserInitEvent>((event, emit){
       emit(InitUserState());
     });

    on<DeleteBankCardEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.deleteBankCard(token, event.bankCardId).then((v) {
            if (v != null)
              emit(DeletedBankCardState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotDeleteBankCard")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(translate("messages.couldNotDeleteBankCard")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(translate("messages.couldNotDeleteBankCard")));
      }
    });

    on<EditBankCardEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.editBankCard(token, event.editBankCardBody).then((v) {
            if (v != null)
              emit(EditedBankCardState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotAddBankCard")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(translate("messages.couldNotAddBankCard")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(translate("messages.couldNotAddBankCard")));
      }
    });

    on<AddBankCardEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.addBankCard(token, event.addBankCardBody).then((v) {
            if (v != null)
              emit(AddedBankCardState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotAddBankCard")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(translate("messages.couldNotAddBankCard")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(translate("messages.couldNotAddBankCard")));
      }
    });

    on<GetBankCardsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getBankCards(token, 1, 9999).then((v) {
            if (v != null)
              emit(GotBankCardsState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetBankCards")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(translate("messages.couldNotGetBankCards")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetBankCards")));
      }
    });


    on<GetSyberPayUrlEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = "eAGqwRPbYhFqCZOxywKS";
        if (token != null) {
          await mClient.syberPayGetUrl(token, event.syberPayGetUrlBody).then((v) {
            if (v != null)
              emit(GotSyberPayUrlState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetSyberPayUrl")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(translate("messages.couldNotGetSyberPayUrl")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetSyberPayUrl")));
      }
    });


    on<GetNotificationsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getNotifications(token, event.page, 10).then((v) {
            emit(GotNotificationsState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotGetNotifications")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });

    on<UploadProfileImageEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.uploadProfilePhoto(token, event.imageFile).then((v) {
            if (v.url != null)
              emit(UploadedProfilePhotoState(v.url!));
            else
              emit(ErrorUserState(
                  translate("messages.couldNotUploadProfilePhoto")));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotUploadProfilePhoto")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }

    });

     on<SuccessfulUserOTPVerificationEvent>((event, emit){
       emit(SuccessfulUserOTPVerificationState(event.signupBody, event.resetPasswordBody, event.updateProfileBody, event.removeAccount));
     });

     on<ErrorUserOTPVerificationEvent>((event, emit) {
       emit(ErrorUserState(event.errorMessage));
     });



     on<CallOTPScreenEvent>((event, emit) async {
       try {
         emit(LoadingUserState());
         await mClient.otpSendCode(event.mobileNumber).then((v) {
           emit(CalledOTPScreenState(v, event.mobileNumber, event.signupBody, event.updateProfileBody, event.resetPasswordBody,  event.removeAccount));
         });
       } on DioError catch (e) {
         if (e.response != null) {
           if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
             emit(ErrorUserState(
                 translate("messages.couldNotSendOtp")));
           else {
             print("Error" + e.toString());
             emit(ErrorUserState(dioErrorMessageAdapter(e)));
           }
         }
         else
           emit(ErrorUserState(dioErrorMessageAdapter(e)));
       }

     });

    on<UpdateProfileEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.updateUserProfile(token, event.updateProfileBody).then((v) {
            emit(UserProfileUpdated(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotUpdateUserProfile")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });


    on<VerifyOTPEvent>((event, emit) async {
      try {
        emit(LoadingUserState());

        await mClient.otpVerifyCode(event.registerId, event.code).then((v) {
          emit(VerifiedOTPCode(v, event.signupBody, event.mobileNumber, event.registerId, event.updateProfileBody, event.resetPasswordBody, event.removeAccount));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotVerifyOTPCode")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });


    on<CheckUserByPhoneEvent>((event, emit) async {
      try {
        emit(LoadingUserState());

        await mClient.checkUserByPhone(event.mobileNumber).then((v) {
          emit(CheckedUserByPhoneState(v, event.mobileNumber, event.signupBody, event.updateProfileBody, event.resetPasswordBody, event.removeAccount));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotCheckPhoneNumber")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
      //_loginUser(event).
    });

     on<SignupEvent>((event, emit) async {
       try {
         emit(LoadingUserState());

         await mClient.signup(event.signupBody).then((v) {
             emit(SignedUpState(v));
         });
       } on DioError catch (e) {
         if (e.response != null) {
           if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
             emit(ErrorUserState(
                 translate("messages.phoneNumberOrPasswordIncorrect")));
           else {
             print("Error" + e.toString());
             emit(ErrorUserState(dioErrorMessageAdapter(e)));
           }
         }
         else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
       }
       //_loginUser(event).
     });

    on<UpdateUserLanguageEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          UpdateUserLanguageBody uulb = UpdateUserLanguageBody(languageId: event.languageId);
          await mClient.updateUserLanguage(token, uulb).then((v) {
            if (v != null)
              emit(UpdatedUserLanguageState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotUpdateUserLanguage")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotUpdateUserLanguage")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetUserBalanceEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getUserBalance(token).then((v) {
            if (v != null)
              emit(GotUserBalanceState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetUserBalance")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotGetUserBalance")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      try {
        emit(LoadingUserState());

        await mClient.resetPassword(event.resetPasswordBody).then((v) {
          emit(PasswordResetState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.phoneNumberOrPasswordIncorrect")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }

    });


    on<ClearUserNotificationsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.clearUserNotifications(token).then((v) {
            if (v != null)
              emit(ClearedUserNotificationsState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotClearUserNotifications")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotClearUserNotifications")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<GetFastFillFeesEvent>((event, emit) async {
      try {

        emit(LoadingUserState());

        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getFastfillFees(token).then((v) {
            emit(GotFastFillFeesState(v));
          });
        }
        else
          emit(ErrorUserState(
              translate("messages.couldNotGetFastFillFees")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotGetFastFillFees")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }

    });


    on<RemoveAccountEvent>((event, emit) async {
      try {

        emit(LoadingUserState());

        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.removeAccount(token).then((v) {
            emit(RemovedAccountState(v));
          });
        }
        else
          emit(ErrorUserState(
              translate("messages.couldNotRemoveAccount")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotRemoveAccount")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }

    });
  }


}


