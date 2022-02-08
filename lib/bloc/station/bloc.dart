import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/model/station/add_remove_station_favorite_body.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fastfill/model/login/login_user.dart' as LoginModel;
import 'event.dart';
import 'state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  late ApiClient mClient;

  StationBloc() : super(InitStationState()) {
    mClient = ApiClient(certificateClient());
     on<InitStationEvent>((event, emit){
       emit(InitStationState());
     });


    on<FavoriteStationsEvent>((event, emit) async {
      try {
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getFavoritesStationsBranches(token).then((v) {
            if (v.companiesBranches != null)
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

    on<RemoveStationFromFavoriteEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.removeStationFromFavorite(token, AddRemoveStationFavoriteBody(companyId: event.stationId)).then((v) {
            emit(RemovedStationFromFavorite(v));
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

    on<AddStationToFavoriteEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.addStationToFavorite(token, AddRemoveStationFavoriteBody(companyId: event.stationId)).then((v) {
              emit(AddedStationToFavorite(v));
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
             if (v.companiesBranches != null)
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

    on<StationByCodeEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getStationByCode(token, event.code).then((v) {
            if (v != null)
              emit(GotStationByCodeState(v));
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


