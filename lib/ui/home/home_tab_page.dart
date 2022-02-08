import 'dart:math';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/event.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/app_widgets/keyboard_done_widget.dart';
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

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

List<StationBranch> favoriteStations = [];
List<StationBranch> frequentlyVistedStations = [];


class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) => StationBloc()..add(InitStationEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is InitStationState)
            {
              bloc.add(FavoriteStationsEvent());
              bloc.add(FrequentlyVisitedStationsEvent());
            }
          else if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotFavoriteStationsState)
            {
              if (state.favoriteStations.companiesBranches != null)
               favoriteStations = state.favoriteStations.companiesBranches!;
              else
                favoriteStations = [];
            }
          else if (state is GotFrequentlyVisitedStationsState)
            {
              if (state.frequentlyVisitedStations.companiesBranches != null)
                frequentlyVistedStations = state.frequentlyVisitedStations.companiesBranches!;
              else
                frequentlyVistedStations = [];
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
    searchFocusNode.addListener(() {
      bool hasFocus = searchFocusNode.hasFocus;
      if (hasFocus)
        showOverlay(context);
      else
        removeOverlay();
    });

    addRemoveFavoriteStreamController.stream.listen((event) {
      if (mounted) {
        setState(() {
          if (event.isFavorite != null) {
            if (!event.isFavorite!)
              favoriteStations.removeWhere((fs) => fs.id == event.id);
            else
              favoriteStations.add(event);
          }
          else
            favoriteStations.removeWhere((fs) => fs.id == event.id);

          if (frequentlyVistedStations
              .firstWhere((frs) => frs.id == event.id,
              orElse: () => StationBranch())
              .id != null) {
            int idx = frequentlyVistedStations.indexWhere((frs) =>
            frs.id == event.id);
            frequentlyVistedStations[idx] = event;
          }
        });
      };
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
                        child: Image(image: AssetImage("assets/home_box.png")))
                    : Image(image: AssetImage("assets/home_box.png")),
                FutureBuilder<User>(
                    future: LocalData().getCurrentUserValue(),
                    builder: (context, AsyncSnapshot<User> snapshot) {
                      User usr = _buildUserInstance(snapshot);
                      if (usr.id != null) {
                        return Container(
                            child: Column(
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
                                      usr.id.toString() +
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
                                    top: SizeConfig().h(60)),
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
            (widget.state is LoadingStationState) ? CustomLoading() : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
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
                              hintText: translate("labels.stationNumber"),
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.search),
                          padding: EdgeInsetsDirectional.only(
                              start: SizeConfig().w(30),
                              end: SizeConfig().w(30),
                              top: SizeConfig().h(30))),
                      Align(
                        child: Padding(
                          child: Text(
                            translate("labels.favorites"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          padding: EdgeInsetsDirectional.only(
                              start: SizeConfig().w(30),
                              end: SizeConfig().w(30),
                              bottom: SizeConfig().w(15)),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      Column(
                          children: favoriteStations
                              .map((i) =>
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PurchasePage.route,
                                        arguments: i);
                                  },
                                  child:
                              Stack(
                                    children: [
                                      (isArabic())
                                          ? Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationY(pi),
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/station_row.png")))
                                          : Image(
                                              image: AssetImage(
                                                  "assets/station_row.png")),
                                      Column(
                                        children: [
                                          Align(child: Padding(
                                            child: Text(
                                             (isArabic()) ? i.arabicName! : i.englishName!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                                start: SizeConfig().w(40),
                                                end: SizeConfig().w(40),
                                                top: SizeConfig().w(20)),
                                          ), alignment: AlignmentDirectional.topStart,),
                                          Align(child: Padding(
                                            child: Text(
                                              i.code!,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                              start: SizeConfig().w(40),
                                              end: SizeConfig().w(40),
                                            ),
                                          ), alignment: AlignmentDirectional.topStart,),
                                          Align(child: Padding(
                                            child: Text(
                                            (isArabic()) ? i.arabicAddress! : i.englishAddress!,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                              start: SizeConfig().w(40),
                                              end: SizeConfig().w(40),
                                            ),
                                          ), alignment: AlignmentDirectional.topStart,),
                                        ],
                                      )
                                    ],
                                  )))
                              .toList()),
                      Align(
                        child: Padding(
                          child: Text(
                            translate("labels.frequentlyVisited"),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          padding: EdgeInsetsDirectional.only(
                              top: SizeConfig().w(15),
                              start: SizeConfig().w(30),
                              end: SizeConfig().w(30),
                              bottom: SizeConfig().w(15)),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      ),
                      Column(
                          children: frequentlyVistedStations
                              .map((i) =>
                              InkWell(child:

                              Stack(
                                    children: [
                                      (isArabic())
                                          ? Transform(
                                              alignment: Alignment.center,
                                              transform: Matrix4.rotationY(pi),
                                              child: Image(
                                                  image: AssetImage(
                                                      "assets/station.png")))
                                          : Image(
                                              image: AssetImage(
                                                  "assets/station.png")),
                                      Column(
                                        children: [
                                          Align(child: Padding(
                                            child: Text(
                                              (isArabic()) ? i.arabicName! : i.englishName!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                                start: SizeConfig().w(40),
                                                end: SizeConfig().w(40),
                                                top: SizeConfig().w(20)),
                                          ),alignment: AlignmentDirectional.topStart,),
                                          Align(child: Padding(
                                            child: Text(
                                              i.code!,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                              start: SizeConfig().w(40),
                                              end: SizeConfig().w(40),
                                            ),
                                          ),alignment: AlignmentDirectional.topStart,),
                                          Align(child: Padding(
                                            child: Text(
                                              (isArabic()) ? i.arabicAddress! : i.englishAddress!,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                              start: SizeConfig().w(40),
                                              end: SizeConfig().w(40),
                                            ),
                                          ),alignment: AlignmentDirectional.topStart,)
                                        ],
                                      )
                                    ],
                                  ), onTap: () {
                                Navigator.pushNamed(
                                    context, PurchasePage.route,
                                    arguments: i);
                              },))
                              .toList()),
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

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context)!;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: InputDoneView(title: translate("buttons.search"), onPressed: ()
          {
            Navigator.pushNamed(
                context, SearchPage.route, arguments: searchController.text);
          },));
    });

    overlayState.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
}
