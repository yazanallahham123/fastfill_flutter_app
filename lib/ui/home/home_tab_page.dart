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
import 'package:fastfill/ui/search/search_page.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../common_widgets/app_widgets/favorite_button.dart';
import '../../utils/misc.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

List<StationBranch> favoriteStationsBranches = [];
List<StationBranch> frequentlyVistedStationsBranches = [];
List<StationBranch> searchResult = [];
List<StationBranch> allStationsBranches = [];
String searchText = "";

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
            bloc.add(FavoriteStationsBranchesEvent());
            bloc.add(FrequentlyVisitedStationsBranchesEvent());
            bloc.add(AllStationsBranchesEvent());
            if (mounted) {
              setState(() {
                searchResult = [];
              });
            }

          } else if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotFavoriteStationsBranchesState) {
            if (state.favoriteStationsBranches.companiesBranches != null)
              favoriteStationsBranches =
                  state.favoriteStationsBranches.companiesBranches!;
            else
              favoriteStationsBranches = [];
          } else if (state is GotAllStationsBranchesState) {
            if (state.stationsBranches != null)
              allStationsBranches = state.stationsBranches.companiesBranches!;
            else
              allStationsBranches = [];
          } else if (state is GotFrequentlyVisitedStationsBranchesState) {
            if (state.frequentlyVisitedStationsBranches.companiesBranches !=
                null)
              frequentlyVistedStationsBranches =
                  state.frequentlyVisitedStationsBranches.companiesBranches!;
            else
              frequentlyVistedStationsBranches = [];
          } else if (state is GotStationBranchByCodeState) {
            if (mounted) {
              setState(() {
                searchResult.clear();
                if (state.stationsBranches != null) {
                  if (state.stationsBranches.companiesBranches !=
                      null) if (state
                          .stationsBranches.companiesBranches!.length >
                      0)
                    searchResult
                        .addAll(state.stationsBranches.companiesBranches!);
                  else
                    searchResult = [];
                } else
                  searchResult = [];
              });
            }
          } else if (state is AddedStationBranchToFavorite) {
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

class _BuildUIState extends State<_BuildUI> {
  OverlayEntry? overlayEntry;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      if (mounted) {
        setState(() {
          searchText = searchController.text;
        });
      }

      if (searchController.text.trim() == "")
        {
          if (mounted) {
            setState(() {
              searchResult.clear();
            });
          }
        }
    });
    
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
              favoriteStationsBranches.removeWhere((fs) => fs.id == event.id);
            else
              favoriteStationsBranches.add(sb);
          } else
            favoriteStationsBranches.removeWhere((fs) => fs.id == event.id);

          if (frequentlyVistedStationsBranches
                  .firstWhere((frs) => frs.id == event.id,
                      orElse: () => StationBranch())
                  .id !=
              null) {
            int idx = frequentlyVistedStationsBranches
                .indexWhere((frs) => frs.id == event.id);
            frequentlyVistedStationsBranches[idx] = sb;
          }

          if (allStationsBranches
                  .firstWhere((frs) => frs.id == event.id,
                      orElse: () => StationBranch())
                  .id !=
              null) {
            int idx3 =
                allStationsBranches.indexWhere((frs) => frs.id == event.id);
            allStationsBranches[idx3] = sb;
          }

          if (searchResult
                  .firstWhere((frs) => frs.id == event.id,
                      orElse: () => StationBranch())
                  .id !=
              null) {
            int idx2 = searchResult.indexWhere((frs) => frs.id == event.id);
            searchResult[idx2] = sb;
          }
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                                      usr.firstName!,
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
                                      onTap: () {},
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
                                        widget.bloc.add(
                                            StationBranchByCodeEvent(
                                                searchController.text));
                                      },
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        start: SizeConfig().w(30),
                                        end: SizeConfig().w(30),
                                        top: SizeConfig().h(30))),
                                ((searchText.trim() != "") && (widget.state == GotStationBranchByCodeState))
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
                                              bottom: SizeConfig().w(15)),
                                        ),
                                        alignment:
                                            AlignmentDirectional.topStart,
                                      )
                                    : Container(),
                                (searchText.trim() != "")
                                    ? (widget.state is GotStationBranchByCodeState) ?
                                (searchResult.length > 0) ?
                                      Column(
                                        children: searchResult
                                            .map((i) => StationBranchWidget(
                                                stationBranch: i,
                                                stationBloc: widget.bloc,
                                                stationState: widget.state))
                                            .toList()) :
    Align(
    child: Padding(
    child: Text(
    translate("labels.noSearchResult"),
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
    )
                                    : Container() : Container(),
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
                                        bottom: SizeConfig().w(15)),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                                (favoriteStationsBranches.length > 0)
                                    ? Column(
                                        children: favoriteStationsBranches
                                            .map((i) => StationBranchWidget(
                                                  stationBranch: i,
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
                                Align(
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
                                ),
                                (frequentlyVistedStationsBranches.length > 0)
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
                                      ),
                              ],
                            ),
                          ],
                        ),
                      )
              ],
            )));
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
