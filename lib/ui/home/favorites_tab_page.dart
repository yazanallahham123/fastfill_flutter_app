import 'dart:math';

import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/event.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/streams/add_remove_favorite_stream.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common_widgets/app_widgets/station_widget.dart';

class FavoritesTabPage extends StatefulWidget {
  const FavoritesTabPage({Key? key}) : super(key: key);

  @override
  State<FavoritesTabPage> createState() => _FavoritesTabPageState();
}

List<StationBranch> favoriteStations = [];
List<StationBranch> allStationsBranches = [];

class _FavoritesTabPageState extends State<FavoritesTabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) =>
            StationBloc()..add(InitStationEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is InitStationState) {
            bloc.add(FavoriteStationsBranchesEvent());
            bloc.add(AllStationsBranchesEvent());
          } else if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotFavoriteStationsBranchesState) {
            if (mounted) {
              setState(() {
                if (state.favoriteStationsBranches.companiesBranches != null)
                  favoriteStations =
                      state.favoriteStationsBranches.companiesBranches!;
                else
                  favoriteStations = [];
              });
            }
          }
          else if (state is GotAllStationsBranchesState) {
            if (state.stationsBranches != null)
              allStationsBranches = state.stationsBranches.companiesBranches!;
            else
              allStationsBranches = [];
          }
          else if (state is AddedStationBranchToFavorite) {
            if (mounted) {
              setState(() {
                isAddedToFavorite = true;
                StationBranch sb = allStationsBranches
                    .firstWhere((s) => s.id == state.stationBranchId);
                addRemoveFavoriteStreamController.sink.add(sb);
              });
            }
          } else if (state is RemovedStationBranchFromFavorite) {
            if (mounted) {
              setState(() {
                isAddedToFavorite = false;
                StationBranch sb = allStationsBranches
                    .firstWhere((s) => s.id == state.stationBranchId);
                addRemoveFavoriteStreamController.sink.add(sb);
              });
            }
          }
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, StationState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final otpCodeController = TextEditingController();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    addRemoveFavoriteStreamController.stream.listen((event) {
      if (mounted) {
        setState(() {
          StationBranch sb = StationBranch(
              id: event.id,
              arabicName: event.arabicName,
              englishName: event.englishName,
              arabicAddress: event.arabicAddress,
              englishAddress: event.englishAddress,
              code: event.code,
              companyId: event.companyId,
              longitude: event.longitude,
              latitude: event.latitude,
              isFavorite: !event.isFavorite!);
          if (event.isFavorite != null) {
            if (event.isFavorite!)
              favoriteStations.removeWhere((fs) => fs.id == event.id);
            else
              favoriteStations.add(sb);
          } else
            favoriteStations.removeWhere((fs) => fs.id == event.id);

        });
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Align(
              child: Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate("labels.favorites"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      )
                    ],
                  ),
                  padding: EdgeInsetsDirectional.only(
                      start: SizeConfig().w(25),
                      end: SizeConfig().w(25),
                      top: SizeConfig().h(10))),
              alignment: AlignmentDirectional.topStart,
            ),
            (widget.state is LoadingStationState ||
                    widget.state is InitStationState)
                ? CustomLoading()
                : (favoriteStations.length > 0)
                    ? Padding(
                        child: Column(
                            children: favoriteStations
                                .map((i) => StationBranchWidget(
                                      stationBranch: i,
                                      stationBloc: widget.bloc,
                                      stationState: widget.state,
                                    ))
                                .toList()),
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      )
                    : Container(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                        child: Column(
                          children: [
                            Text(
                              translate("labels.noFavorites"),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )
          ],
        )));
  }
}
