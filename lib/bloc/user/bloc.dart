import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/model/user/signedup_user.dart';
import 'package:fastfill/model/user/user.dart';
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

     on<SuccessfulUserOTPVerificationEvent>((event, emit){
       emit(SuccessfulUserOTPVerificationState(event.signupBody, event.resetPasswordBody));
     });

     on<ErrorUserOTPVerificationEvent>((event, emit) {
       emit(ErrorUserState(event.errorMessage));
     });

     on<CallOTPScreenEvent>((event, emit) async {
       emit(LoadingUserState());
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
  }
}


