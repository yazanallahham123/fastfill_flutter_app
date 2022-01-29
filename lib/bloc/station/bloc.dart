import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fastfill/model/login/login_user.dart' as LoginModel;
import 'event.dart';
import 'state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  late ApiClient mClient;

  StationBloc() : super(InitStationState()) {
    mClient = ApiClient(certificateClient());
     on<InitEvent>((event, emit){
       InitStationState();
     });

    on<FavoriteStationsEvent>((event, emit) async {
      try {
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getFrequentlyVisitedStationsBranches(token).then((v) {
            if (v.stationBranches != null)
              emit(GotFavoriteStationsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.youAreNotSignedIn")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.youAreNotSignedIn")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

     on<FrequentlyVisitedStationsEvent>((event, emit) async {
       try {
         var token = await LocalData().getBearerTokenValue();
         if (token != null) {
           await mClient.getFrequentlyVisitedStationsBranches(token).then((v) {
             if (v.stationBranches != null)
               emit(GotFrequentlyVisitedStationsState(v));
           });
         }
         else
           emit(ErrorStationState(translate("messages.youAreNotSignedIn")));
       } on DioError catch (e) {
         if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
           emit(ErrorStationState(translate("messages.youAreNotSignedIn")));
         else {
           print("Error" + e.toString());
           emit(ErrorStationState(dioErrorMessageAdapter(e)));
         }
       }
     });

    on<StationByNumberEvent>((event, emit) async {
      try {
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getStationByNumber(token, event.number).then((v) {
            if (v != null)
              emit(GotStationByNumberState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.youAreNotSignedIn")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.youAreNotSignedIn")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });
  }
}


