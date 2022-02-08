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

class FavoritesTabPage extends StatefulWidget {
  const FavoritesTabPage({Key? key}) : super(key: key);

  @override
  State<FavoritesTabPage> createState() => _FavoritesTabPageState();
}

List<StationBranch> favoriteStations = [];

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
            bloc.add(FavoriteStationsEvent());
          } else if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotFavoriteStationsState) {
            if (mounted) {
              setState(() {
                if (state.favoriteStations.companiesBranches != null)
                  favoriteStations = state.favoriteStations.companiesBranches!;
                else
                  favoriteStations = [];
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
          if (event.isFavorite != null) {
            if (!event.isFavorite!)
              favoriteStations.removeWhere((fs) => fs.id == event.id);
            else
              favoriteStations.add(event);
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
            (widget.state is LoadingStationState)
                ? CustomLoading()
                : (favoriteStations.length > 0)
                    ? Padding(
                        child: Column(
                            children: favoriteStations
                                .map((i) => InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PurchasePage.route,
                                          arguments: i);
                                    },
                                    child: Stack(
                                      children: [
                                        (isArabic())
                                            ? Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(pi),
                                                child: Image(
                                                    image: AssetImage(
                                                        "assets/station_row.png")))
                                            : Image(
                                                image: AssetImage(
                                                    "assets/station_row.png")),
                                        Column(
                                          children: [
                                            Align(
                                              child: Padding(
                                                child: Text(
                                                  (isArabic())
                                                      ? i.arabicName!
                                                      : i.englishName!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                        start:
                                                            SizeConfig().w(40),
                                                        end: SizeConfig().w(40),
                                                        top:
                                                            SizeConfig().w(20)),
                                              ),
                                              alignment:
                                                  AlignmentDirectional.topStart,
                                            ),
                                            Align(
                                              child: Padding(
                                                child: Text(
                                                  i.code!,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                  start: SizeConfig().w(40),
                                                  end: SizeConfig().w(40),
                                                ),
                                              ),
                                              alignment:
                                                  AlignmentDirectional.topStart,
                                            ),
                                            Align(
                                              child: Padding(
                                                child: Text(
                                                  (isArabic())
                                                      ? i.arabicAddress!
                                                      : i.englishAddress!,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                  start: SizeConfig().w(40),
                                                  end: SizeConfig().w(40),
                                                ),
                                              ),
                                              alignment:
                                                  AlignmentDirectional.topStart,
                                            ),
                                          ],
                                        )
                                      ],
                                    )))
                                .toList()),
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      )
                    : Container(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                        child: Column(
                          children: [
                            Text(
                              "You have no favorites",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )
          ],
        )));
  }
}
