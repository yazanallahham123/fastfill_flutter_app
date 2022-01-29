import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/helper/firebase_helper.dart';
import 'package:fastfill/model/otp/otp_send_response_body.dart';
import 'package:fastfill/model/otp/otp_verify_response_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'event.dart';
import 'state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState>{
  late ApiClient mClient;

  OTPBloc() : super(InitOTPState()) {
    mClient = ApiClient(certificateClient());
    on<OTPInitEvent>((event, emit) {
      emit(InitOTPState());
    });

    on<OTPSendCodeEvent>((event, emit) async {
      try {
        emit(LoadingOTPState());
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorOTPState(translate("messages.incorrectOTPValidation")));
        else {
          print("Error" + e.toString());
          emit(ErrorOTPState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<OTPResendCodeEvent>((event, emit) async {
      try {
        emit(LoadingOTPState());
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorOTPState(translate("messages.incorrectOTPValidation")));
        else {
          print("Error" + e.toString());
          emit(ErrorOTPState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<OTPVerifyCodeEvent>((event, emit) async {
      try {
        emit(LoadingOTPState());
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorOTPState(translate("messages.incorrectOTPValidation")));
        else {
          print("Error" + e.toString());
          emit(ErrorOTPState(dioErrorMessageAdapter(e)));
        }
      }
    });
  }
}
