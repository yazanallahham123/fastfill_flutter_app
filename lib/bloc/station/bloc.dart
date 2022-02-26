import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/model/station/add_remove_station_favorite_body.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fastfill/model/login/login_user.dart' as LoginModel;
import '../../model/station/add_remove_station_branch_favorite_body.dart';
import 'event.dart';
import 'state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  late ApiClient mClient;

  StationBloc() : super(InitStationState()) {
    mClient = ApiClient(certificateClient());
     on<InitStationEvent>((event, emit){
       emit(InitStationState());
     });

    on<GetPaymentTransactions>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getPaymentTransactions(token, 1, 999999).then((v) {
            if (v != null)
              emit(GotPaymentTransactions(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadTransaction")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AddPaymentTransaction>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.addPaymentTransaction(token, event.paymentTransactionBody).then((v) {
            if (v != null)
              emit(AddedPaymentTransaction(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotAddTransaction")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotAddTransaction")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AllStationsBranchesEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getAllStationsBranches(token).then((v) {
            if (v.companiesBranches != null)
              emit(GotAllStationsBranchesState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadAllStationBranches")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadAllStationBranches")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<FavoriteStationsBranchesEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getFavoritesStationsBranches(token).then((v) {
            if (v.companiesBranches != null)
              emit(GotFavoriteStationsBranchesState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadFavoriteStationBranches")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadFavoriteStationBranches")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<FavoriteStationsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getFavoritesStationsBranches(token).then((v) {
            if (v.companiesBranches != null)
              emit(GotFavoriteStationsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadFavoriteStations")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadFavoriteStations")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<RemoveStationBranchFromFavoriteEvent>((event, emit) async {
      try {
        emit(AddingRemovingStationBranchToFavorite(event.stationBranchId));
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.removeStationBranchFromFavorite(token, AddRemoveStationBranchFavoriteBody(companyBranchId: event.stationBranchId)).then((v) {
            if (v)
              emit(RemovedStationBranchFromFavorite(event.stationBranchId));
            else
              emit(ErrorStationState(translate("messages.couldNotRemoveStationBranchFromFavorite")));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotRemoveStationBranchFromFavorite")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotRemoveStationBranchFromFavorite")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AddStationBranchToFavoriteEvent>((event, emit) async {
      try {
        emit(AddingRemovingStationBranchToFavorite(event.stationBranchId));
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.addStationBranchToFavorite(token, AddRemoveStationBranchFavoriteBody(companyBranchId: event.stationBranchId)).then((v) {
            if (v)
              emit(AddedStationBranchToFavorite(event.stationBranchId));
            else
              emit(ErrorStationState(translate("messages.couldNotAddStationBranchToFavorite")));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotAddStationBranchToFavorite")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotAddStationBranchToFavorite")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });



    on<RemoveStationFromFavoriteEvent>((event, emit) async {
      try {
        emit(LoadingFavoriteStationState());

        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.removeStationFromFavorite(token, AddRemoveStationFavoriteBody(companyId: event.stationId)).then((v) {
            if (v)
              emit(RemovedStationFromFavorite(event.stationId));
            else
              emit(ErrorStationState(translate("messages.couldNotRemoveStationFromFavorite")));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotRemoveStationFromFavorite")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotRemoveStationFromFavorite")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AddStationToFavoriteEvent>((event, emit) async {
      try {
        emit(LoadingFavoriteStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.addStationToFavorite(token, AddRemoveStationFavoriteBody(companyId: event.stationId)).then((v) {
            if (v)
              emit(AddedStationToFavorite(event.stationId));
            else
              emit(ErrorStationState(translate("messages.couldNotAddStationToFavorite")));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotAddStationToFavorite")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotAddStationToFavorite")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<FrequentlyVisitedStationsBranchesEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getFrequentlyVisitedStationsBranches(token).then((v) {
            if (v.companiesBranches != null)
              emit(GotFrequentlyVisitedStationsBranchesState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadFrequentlyVisitedStationBranches")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadFrequentlyVisitedStationBranches")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<FrequentlyVisitedStationsEvent>((event, emit) async {
       try {
         emit(LoadingStationState());
         var token = await LocalData().getBearerTokenValue();
         if (token != null) {
           await mClient.getFrequentlyVisitedStationsBranches(token).then((v) {
             if (v.companiesBranches != null)
               emit(GotFrequentlyVisitedStationsState(v));
           });
         }
         else
           emit(ErrorStationState(translate("messages.couldNotLoadFrequentlyVisitedStation")));
       } on DioError catch (e) {
         if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
           emit(ErrorStationState(translate("messages.couldNotLoadFrequentlyVisitedStation")));
         else {
           print("Error" + e.toString());
           emit(ErrorStationState(dioErrorMessageAdapter(e)));
         }
       }
     });

    on<StationBranchByCodeEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await LocalData().getBearerTokenValue();
        if (token != null) {
          await mClient.getStationBranchByCode(token, event.code, 1, 1000).then((v) {
            if (v != null)
              emit(GotStationBranchByCodeState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotSearchStationBranchByCode")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotSearchStationBranchByCode")));
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
          emit(ErrorStationState(translate("messages.couldNotSearchStationByCode")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotSearchStationByCode")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });
  }
}


