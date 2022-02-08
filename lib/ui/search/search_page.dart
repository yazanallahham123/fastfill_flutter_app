import 'dart:io';
import 'dart:math';

import 'package:fastfill/bloc/login/bloc.dart';
import 'package:fastfill/bloc/login/event.dart';
import 'package:fastfill/bloc/login/state.dart';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/event.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/app_widgets/keyboard_done_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/methods.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/textfield_password_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_sizes.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/font_styles.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/login/login_body.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/ui/auth/reset_password_phone_number_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';

class SearchPage extends StatefulWidget {
  static const route = "/search_page";

  final String searchText;

  const SearchPage({required this.searchText});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<StationBranch> listOfStations = [];

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
        create: (BuildContext context) => StationBloc()..add(InitStationEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }



  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<StationBloc>(context);

    return BlocListener<StationBloc, StationState>(
        listener: (context, state) async {
          if (state is ErrorStationState) {
            pushToast(state.error);
            listOfStations.clear();
          }
          else if (state is InitStationState) {
            bloc.add(StationByCodeEvent(widget.searchText));
          } else if (state is GotStationByCodeState)
            {
              listOfStations.clear();
              listOfStations.add(state.stationBranch);
            }
        },
        bloc: bloc,
        child: BlocBuilder<StationBloc, StationState>(
            bloc: bloc,
            builder: (context, StationState state) {
              return _BuildUI(
                  bloc: bloc, state: state, searchText: widget.searchText);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;
  final String searchText;

  _BuildUI({required this.bloc, required this.state, required this.searchText});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}



class _BuildUIState extends State<_BuildUI> {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    searchController.text = widget.searchText;

    searchFocusNode.addListener(() {

      bool hasFocus = searchFocusNode.hasFocus;
      if (hasFocus)
        showOverlay(context);
      else
        removeOverlay();
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
        body: Stack(
          children: [
            Column(
              children: [
                Align(
                  child: Padding(
                      child: Text(
                        translate("labels.searchResults"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          top: SizeConfig().h(125))),
                  alignment: AlignmentDirectional.topStart,
                ),
                Align(
                  child: Padding(
                      child: CustomTextFieldWidget(
                          icon: Icon(Icons.search),
                          onFieldSubmitted: (_) {

                            widget.bloc.add(StationByCodeEvent(searchController.text));

                          },
                          controller: searchController,
                          focusNode: searchFocusNode,
                          hintText: translate("labels.stationNumber"),
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.search),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          top: SizeConfig().h(25))),
                  alignment: AlignmentDirectional.topCenter,
                ),
                (widget.state is LoadingStationState) ? CustomLoading() : (listOfStations.isEmpty) ?
                    Image(image: AssetImage("assets/fail.png"))
                    : Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                            children: listOfStations
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              child: Align(child: Text(
                                                (isArabic()) ? i.arabicName! : i.englishName!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ), alignment: AlignmentDirectional.topStart,),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      start: SizeConfig().w(40),
                                                      end: SizeConfig().w(40),
                                                      top: SizeConfig().w(20)),
                                            ),
                                            Padding(
                                              child: Align(child: Text(
                                                i.code!,
                                                style: TextStyle(fontSize: 16),
                                              ), alignment: AlignmentDirectional.topStart,),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: SizeConfig().w(40),
                                                end: SizeConfig().w(40),
                                              ),
                                            ),
                                            Padding(
                                              child: Align(child: Text(
                                                (isArabic()) ? i.arabicAddress! : i.englishAddress!,
                                                style: TextStyle(fontSize: 16),
                                              ), alignment: AlignmentDirectional.topStart,),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: SizeConfig().w(40),
                                                end: SizeConfig().w(40),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )))
                                .toList()))),
              ],
            ),
            Align(
                child: BackButtonWidget(context),
                alignment: AlignmentDirectional.topStart),
          ],
        ));
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.focusedChild!.unfocus();
    }
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
          widget.bloc.add(StationByCodeEvent(searchController.text));
          },));
    });

    overlayState.insert(overlayEntry!);
  }

  search(){
    widget.bloc.add(StationByCodeEvent(searchController.text));
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
}
