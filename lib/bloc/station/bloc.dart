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

    on<GetUserBalanceInStationEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getUserBalance(token).then((v) {
            if (v != null)
              emit(GotUserBalanceInStationState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetUserBalance")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotGetUserBalance")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetPaymentTransactionsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getPaymentTransactions(token, event.page, 10).then((v) {
            if (v != null)
              emit(GotPaymentTransactionsState(v));
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


    on<AddUserRefillTransactionEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.addUserRefillTransaction(token, event.userRefillTransactionDto).then((v) {
            if (v != null)
              emit(AddedUserRefillTransactionState(v, event.syberPayGetUrlResponseBody));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldAddUserRefillTransaction")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(translate("messages.couldAddUserRefillTransaction")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorStationState(translate("messages.couldAddUserRefillTransaction")));
      }
    });


    on<CheckSyberStatusEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = "eAGqwRPbYhFqCZOxywKS";//"eAGqwRPbYhFqCZOxywKS";
        if (token != null) {
          await mClient.syberCheckStatus(token, event.syberPayCheckStatusBody).then((v) {
            if (v != null)
              emit(CheckedSyberStatusState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotCheckSyberStatus")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(translate("messages.couldNotCheckSyberStatus")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorStationState(translate("messages.couldNotCheckSyberStatus")));
      }
    });

    on<AddPaymentTransaction>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          double balance = await mClient.getUserBalance(token);
          double val = (event.paymentTransactionBody.amount!);
          if (balance >= val) {
            await mClient.addPaymentTransaction(
                token, event.paymentTransactionBody).then((v) {
              if (v != null)
                emit(AddedPaymentTransaction(v, false));
            });
          }
          else
            {
              emit(AddedPaymentTransaction(false, true));
            }
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



    on<AllStationsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllStations(token, 1, 10000).then((v) {
            if (v.companies != null)
              emit(GotAllStationsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotLoadAllStation")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotLoadAllStation")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AllStationsBranchesEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllStationsBranches(token, 1, 10000).then((v) {
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
        var token = await getBearerTokenValue();
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
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getFavoritesStations(token).then((v) {
            if (v.companies != null)
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
        var token = await getBearerTokenValue();
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
        var token = await getBearerTokenValue();
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
        emit(AddingRemovingStationToFavorite(event.stationId));

        var token = await getBearerTokenValue();
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
        emit(AddingRemovingStationToFavorite(event.stationId));
        var token = await getBearerTokenValue();
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
        var token = await getBearerTokenValue();
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
         var token = await getBearerTokenValue();
         if (token != null) {
           await mClient.getFrequentlyVisitedStations(token).then((v) {
             if (v.companies != null)
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

    on<StationBranchByTextEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getStationBranchByText(token, event.text, 1, 1000).then((v) {
            if (v != null)
              emit(GotStationBranchByTextState(v));
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

    on<StationByTextEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getStationByText(token, event.text, 1, 10000).then((v) {
            if (v != null)
              emit(GotStationsByTextState(v));
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

    on<Station_GetSyberPayUrlEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = "eAGqwRPbYhFqCZOxywKS";//"eAGqwRPbYhFqCZOxywKS";
        if (token != null) {
          await mClient.syberPayGetUrl(token, event.syberPayGetUrlBody).then((v) {
            if (v != null)
              emit(Station_GotSyberPayUrlState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetSyberPayUrl")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(translate("messages.couldNotGetSyberPayUrl")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorStationState(translate("messages.couldNotGetSyberPayUrl")));
      }
    });


    on<GetFastFillFeesEvent>((event, emit) async {
      try {

        emit(LoadingStationState());

        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getFastfillFees(token).then((v) {
            emit(GotFastFillFeesState(v));
          });
        }
        else
          emit(ErrorStationState(
              translate("messages.couldNotGetFastFillFees")));
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorStationState(
                translate("messages.couldNotGetFastFillFees")));
          else {
            print("Error" + e.toString());
            emit(ErrorStationState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
      }

    });

    on<ClearTransactionsEvent>((event, emit) async {
      try {
        emit(LoadingStationState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.clearUserTransactions(token).then((v) {
            if (v != null)
              emit(ClearedTransactionsState(v));
          });
        }
        else
          emit(ErrorStationState(translate("messages.couldNotClearUserNotifications")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorStationState(translate("messages.couldNotClearUserNotifications")));
        else {
          print("Error" + e.toString());
          emit(ErrorStationState(dioErrorMessageAdapter(e)));
        }
      }
    });

  }
}


