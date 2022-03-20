import 'dart:math';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/event.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/app_widgets/keyboard_done_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/station_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/streams/add_remove_favorite_stream.dart';
import 'package:fastfill/streams/update_profile_stream.dart';
import 'package:fastfill/ui/search/search_page.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common_widgets/app_widgets/favorite_button.dart';
import '../../model/station/station.dart';
import '../../utils/misc.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

List<Station> favoriteStations = [];
List<Station> frequentlyVistedStations = [];
List<Station> searchResult = [];
List<Station> allStations = [];
String searchText = "";
String userName = "";

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) =>
            StationBloc()..add(InitStationEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is InitStationState) {
            bloc.add(FavoriteStationsEvent());
            bloc.add(FrequentlyVisitedStationsEvent());
            bloc.add(AllStationsEvent());
            if (mounted) {
              setState(() {
                searchResult = [];
              });
            }
          } else if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotFavoriteStationsState) {
            if (state.favoriteStations.companies != null)
              favoriteStations =
                  state.favoriteStations.companies!;
            else
              favoriteStations = [];
          } else if (state is GotAllStationsState) {
            if (state.stations != null)
              allStations = state.stations.companies!;
            else
              allStations= [];
          } else if (state is GotFrequentlyVisitedStationsState) {
            if (state.frequentlyVisitedStations.companies !=
                null)
              frequentlyVistedStations =
                  state.frequentlyVisitedStations.companies!;
            else
              frequentlyVistedStations = [];
          } else if (state is GotStationsByTextState) {
            if (mounted) {
              setState(() {
                searchResult.clear();
                if (state.stations != null) {
                  if (state.stations.companies !=
                      null) if (state
                          .stations.companies!.length >
                      0)
                    searchResult
                        .addAll(state.stations.companies!);
                  else
                    searchResult = [];
                } else
                  searchResult = [];

                searchResetted = false;
              });
            }
          } else if (state is AddedStationToFavorite) {
            if (mounted) {
              setState(() {
                isAddedToFavorite = true;
                Station s = allStations
                    .firstWhere((s) => s.id == state.stationId);
                addRemoveFavoriteStreamController.sink.add(s);
              });
            }
          } else if (state is RemovedStationFromFavorite) {
            if (mounted) {
              setState(() {
                isAddedToFavorite = false;
                Station s = allStations
                    .firstWhere((s) => s.id == state.stationId);
                addRemoveFavoriteStreamController.sink.add(s);
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

User _buildUserInstance(AsyncSnapshot<User> snapshot) {
  if (snapshot.hasData && snapshot.data!.id != 0 && snapshot.data!.id != null)
    return snapshot.data!;
  return User();
}

class _BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> with WidgetsBindingObserver{
  OverlayEntry? overlayEntry;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();

    LocalData().getCurrentUserValue().then((value) {
      userName = value.firstName??"";
    });


    print("ddddd");

    searchController.addListener(() {
      if (mounted) {
        setState(() {
          searchText = searchController.text;
        });
      }

      if (searchController.text.trim() == "") {
        if (mounted) {
          setState(() {
            searchResetted = true;
            searchResult.clear();
          });
        }
      }
    });

    updateProfileStreamController.stream.listen((event) {
      if (mounted)
        {
          setState(() {
            userName = event.firstName??"";
          });
        }
    });

    addRemoveFavoriteStreamController.stream.listen((event) {
      if (mounted) {
        setState(() {
          Station s = Station(
              id: event.id,
              arabicName: event.arabicName,
              englishName: event.englishName,
              arabicAddress: event.arabicAddress,
              englishAddress: event.englishAddress,
              code: event.code,
              longitude: event.longitude,
              latitude: event.latitude,
              isFavorite: !event.isFavorite!);
          if (event.isFavorite != null) {
            if (event.isFavorite!)
              favoriteStations.removeWhere((fs) => fs.id == event.id);
            else
              favoriteStations.add(s);
          } else
            favoriteStations.removeWhere((fs) => fs.id == event.id);

          if (frequentlyVistedStations
                  .firstWhere((frs) => frs.id == event.id,
                      orElse: () => Station())
                  .id !=
              null) {
            int idx = frequentlyVistedStations
                .indexWhere((frs) => frs.id == event.id);
            frequentlyVistedStations[idx] = s;
          }

          if (allStations
                  .firstWhere((frs) => frs.id == event.id,
                      orElse: () => Station())
                  .id !=
              null) {
            int idx3 =
                allStations.indexWhere((frs) => frs.id == event.id);
            allStations[idx3] = s;
          }

          if (searchResult
                  .firstWhere((frs) => frs.id == event.id,
                      orElse: () => Station())
                  .id !=
              null) {
            int idx2 = searchResult.indexWhere((frs) => frs.id == event.id);
            searchResult[idx2] = s;
          }
        });
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.accountInfo"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          top: SizeConfig().h(10))),
                  alignment: AlignmentDirectional.topStart,
                ),
                Stack(
                  children: [
                    (isArabic())
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child:
                                Image(image: AssetImage("assets/home_box.png")))
                        : Image(image: AssetImage("assets/home_box.png")),
                    FutureBuilder<User>(
                        future: LocalData().getCurrentUserValue(),
                        builder: (context, AsyncSnapshot<User> snapshot) {
                          User usr = _buildUserInstance(snapshot);
                          if (usr.id != null) {
                            return Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  child: Padding(
                                    child: Text(
                                      userName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        start: SizeConfig().w(50),
                                        end: SizeConfig().w(50),
                                        top: SizeConfig().h(50)),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                                Align(
                                  child: Padding(
                                    child: Text(
                                      translate("labels.balance") +
                                          " : " +
                                          formatter.format(0) +
                                          " " +
                                          translate("labels.sdg"),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        start: SizeConfig().w(50),
                                        end: SizeConfig().w(50),
                                        top: SizeConfig().h(20)),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                                Align(
                                  child: Padding(
                                    child: CustomButton(
                                      title: translate("buttons.fastfill"),
                                      borderColor: Colors.white,
                                      titleColor: Colors.white,
                                      backColor: buttonColor1,
                                      onTap: () {
                                        hideKeyboard(context);
                                      },
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        start: SizeConfig().w(120),
                                        end: SizeConfig().w(120),
                                        top: SizeConfig().h(40)),
                                  ),
                                  alignment: AlignmentDirectional.centerStart,
                                ),
                              ],
                            ));
                          } else {
                            return CustomLoading();
                          }
                        })
                  ],
                ),
                (widget.state is LoadingStationState)
                    ? CustomLoading()
                    : Container(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                    child: CustomTextFieldWidget(
                                      icon: Icon(Icons.search),
                                      focusNode: searchFocusNode,
                                      controller: searchController,
                                      hintText:
                                          translate("labels.stationNumber"),
                                      textInputType: TextInputType.text,
                                      textInputAction: TextInputAction.search,
                                      onFieldSubmitted: (_) {
                                        hideKeyboard(context);
                                        widget.bloc.add(
                                            StationByTextEvent(
                                                searchController.text));
                                      },
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        start: SizeConfig().w(30),
                                        end: SizeConfig().w(30),
                                        top: SizeConfig().h(15),
                                        bottom: SizeConfig().h(0),)),
                                (!searchResetted) ?
                                ((searchText.trim() != ""))
                                    ? Align(
                                        child: Padding(
                                          child: Text(
                                            translate("labels.searchResult"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          padding: EdgeInsetsDirectional.only(
                                              start: SizeConfig().w(30),
                                              end: SizeConfig().w(30),
                                              bottom: SizeConfig().h(0)),
                                        ),
                                        alignment:
                                            AlignmentDirectional.topStart,
                                      )
                                    : Container() : Container(),
                                (!searchResetted) ?
                                (searchText.trim() != "")

                                        ? (searchResult.length > 0)
                                            ? Column(
                                                children: searchResult
                                                    .map((i) =>
                                                        StationWidget(
                                                            station: i,
                                                            stationBloc:
                                                                widget.bloc,
                                                            stationState:
                                                                widget.state))
                                                    .toList())
                                            : Align(
                                                child: Padding(
                                                  child: Text(
                                                    translate(
                                                        "labels.noSearchResult"),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  padding: EdgeInsetsDirectional
                                                      .only(
                                                          top: SizeConfig()
                                                              .h(15),
                                                          start: SizeConfig()
                                                              .w(30),
                                                          end: SizeConfig()
                                                              .w(30),
                                                          bottom: SizeConfig()
                                                              .h(15)),
                                                ),
                                                alignment: AlignmentDirectional
                                                    .topCenter,
                                              )
                                        : Container()
                                    : Container(),
                                Align(
                                  child: Padding(
                                    child: Text(
                                      translate("labels.favorites"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        start: SizeConfig().w(30),
                                        end: SizeConfig().w(30),
                                        bottom: SizeConfig().h(0),
                                        top: SizeConfig().h(0)),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                                (favoriteStations.length > 0)
                                    ? Column(
                                        children: favoriteStations
                                            .map((i) => StationWidget(
                                                  station: i,
                                                  stationBloc: widget.bloc,
                                                  stationState: widget.state,
                                                ))
                                            .toList())
                                    : Align(
                                        child: Padding(
                                          child: Text(
                                            translate("labels.noFavorites"),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          padding: EdgeInsetsDirectional.only(
                                              top: SizeConfig().w(15),
                                              start: SizeConfig().w(30),
                                              end: SizeConfig().w(30),
                                              bottom: SizeConfig().w(15)),
                                        ),
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                      ),
                                /*Align(
                                  child: Padding(
                                    child: Text(
                                      translate("labels.frequentlyVisited"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        top: SizeConfig().w(15),
                                        start: SizeConfig().w(30),
                                        end: SizeConfig().w(30),
                                        bottom: SizeConfig().w(15)),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),*/
                                /*(frequentlyVistedStationsBranches.length > 0)
                                    ? Column(
                                        children:
                                            frequentlyVistedStationsBranches
                                                .map((i) => StationBranchWidget(
                                                    stationBranch: i,
                                                    stationBloc: widget.bloc,
                                                    stationState: widget.state))
                                                .toList())
                                    : Align(
                                        child: Padding(
                                          child: Text(
                                            translate(
                                                "labels.noFrequentlyVisited"),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          padding: EdgeInsetsDirectional.only(
                                              top: SizeConfig().w(15),
                                              start: SizeConfig().w(30),
                                              end: SizeConfig().w(30),
                                              bottom: SizeConfig().w(15)),
                                        ),
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                      ),*/
                              ],
                            ),
                          ],
                        ),
                      )
              ],
            )));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (mounted) {
      setState(() {
        hideKeyboard(context);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
    searchController.dispose();
  }
}
