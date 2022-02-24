import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fastfill/model/login/login_user.dart' as LoginModel;
import '../../model/user/update_firebase_token_body.dart';
import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late ApiClient mClient;

  LoginBloc() : super(InitLoginState()) {
    mClient = ApiClient(certificateClient());
     on<InitEvent>((event, emit){
       InitLoginState();
     });

     on<LoginUserEvent>((event, emit) async {
       try {

         emit(LoadingLoginState());

         await mClient.loginUser(event.loginBody).then((v) async {
           if (v.statusCode == 200) {
             String firebaseTokenText = await LocalData().getFTokenValue();

             await mClient.updateFirebaseToken("Bearer "+v.value!.token!, UpdateFirebaseTokenBody(firebaseToken: firebaseTokenText));

             emit(SuccessLoginState(v));
           }
         });
       } on DioError catch (e) {
         if (e.response != null) {
           if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
             emit(ErrorLoginState(
                 translate("messages.phoneNumberOrPasswordIncorrect")));
           else {
             print("Error" + e.toString());
             emit(ErrorLoginState(dioErrorMessageAdapter(e)));
           }
         }
         else
           {
             emit(ErrorLoginState(dioErrorMessageAdapter(e)));
           }
       }
       //_loginUser(event).
     });
  }



  /*@override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {

    if (event is InitEvent) yield InitLoginState();
    if(event is LoginUserEvent) yield* _loginUser(event);
  }*/

  Stream<LoginState> _loginUser(LoginUserEvent event) async*{
    late LoginModel.LoginUser response;
    try {
      yield LoadingLoginState();
      response = await mClient.loginUser(event.loginBody);
      print(response.toString());
      if (response.statusCode == 200) yield SuccessLoginState(response);
    } on DioError catch (e) {
      if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
        yield ErrorLoginState(translate("messages.phoneNumberOrPasswordIncorrect"));
      else {
        print("Error" + e.toString());
        yield ErrorLoginState(dioErrorMessageAdapter(e));
      }
    }
  }
}


