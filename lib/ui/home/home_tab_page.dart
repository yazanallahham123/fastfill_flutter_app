import 'dart:convert';
import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fastfill/api/apis.dart';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/event.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/bloc/user/state.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/app_widgets/home_box_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/keyboard_done_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/station_widget.dart';
import 'package:fastfill/common_widgets/buttons/custom_button.dart';
import 'package:fastfill/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:fastfill/model/syberPay/syber_pay_check_status_body.dart';
import 'package:fastfill/model/syberPay/top_up_param.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/model/user/user_refill_transaction_dto.dart';
import 'package:fastfill/streams/add_remove_favorite_stream.dart';
import 'package:fastfill/streams/update_profile_stream.dart';
import 'package:fastfill/ui/search/search_page.dart';
import 'package:fastfill/ui/station/purchase_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/user/event.dart';
import '../../common_widgets/app_widgets/favorite_button.dart';
import '../../common_widgets/app_widgets/new_station_widget.dart';
import '../../helper/const_styles.dart';
import '../../helper/font_styles.dart';
import '../../model/station/station.dart';
import '../../model/syberPay/syber_pay_get_url_body.dart';
import '../../utils/misc.dart';
import 'package:crypto/crypto.dart';

import '../../utils/notifications.dart';
import '../profile/top_up_page.dart';

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
double userBalance = 0.0;

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
            if (!bloc.isClosed) {
              bloc.add(GetUserBalanceInStationEvent());
              bloc.add(FavoriteStationsEvent());
              bloc.add(FrequentlyVisitedStationsEvent());
              bloc.add(AllStationsEvent());
            }
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
                if (!addRemoveFavoriteStreamController.isClosed)
                  addRemoveFavoriteStreamController.sink.add(s);
              });
            }
          } else if (state is RemovedStationFromFavorite) {
            if (mounted) {
              setState(() {
                isAddedToFavorite = false;
                Station s = allStations
                    .firstWhere((s) => s.id == state.stationId);
                if (!addRemoveFavoriteStreamController.isClosed)
                  addRemoveFavoriteStreamController.sink.add(s);
              });
            }
          }
          else if (state is GotUserBalanceInStationState) {
            if (mounted) {
              setState(() {
                userBalance = state.balance;
              });
            }
          }
          else if (state is CheckedSyberStatusState) {
            if (state.syberPayCheckStatusResponseBody.status == "Successful") {
              Widget okButton = TextButton(
                child: Text(translate("buttons.ok"),
                  style: TextStyle(color: Colors.black),),
                onPressed: () {
                  if (mounted)
                    hideKeyboard(context);
                  Navigator.pop(context);
                },
              );


              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text(translate("labels.refillTitle")),
                content: Text(translate("messages.successRefillMessage")),
                actions: [
                  okButton,
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
            else
            {
              Widget okButton = TextButton(
                child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
                onPressed:  () {
                  if (mounted)
                    hideKeyboard(context);
                  Navigator.pop(context);
                },
              );


              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text(translate("labels.refillTitle")),
                content: Text(translate("messages.unsuccessRefillMessage")),
                actions: [
                  okButton,
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            }
          }


          else if (state is AddedUserRefillTransactionState)
            {
              if (state.syberPayGetUrlResponseBody.paymentUrl != null) {

                TopUpParam topUpParam = new TopUpParam(
                  paymentUrl: state.syberPayGetUrlResponseBody.paymentUrl,
                  transactionId: state.syberPayGetUrlResponseBody.transactionId
                );

                await Navigator.pushNamed(
                    context, TopUpPage.route,
                    arguments: topUpParam);



                String transactionId = state.syberPayGetUrlResponseBody.transactionId??"";
                String key = r"f@$tf!llK3y";
                String salt = r"f@$tf!ll$@lt";
                String applicationId = r'f@$tf!llApp';
                String all = key + "|" + applicationId + "|" + transactionId + "|" + salt;
                var AllInBytes = utf8.encode(all);
                String value = sha256.convert(AllInBytes).toString();

                SyberPayCheckStatusBody spcsb = SyberPayCheckStatusBody(
                    applicationId: applicationId,
                    transactionId: transactionId,
                    hash: value);

                if (!bloc.isClosed)
                  bloc.add(CheckSyberStatusEvent(spcsb));
              }
              else
              {
                Widget okButton = TextButton(
                  child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
                  onPressed:  () {
                    if (mounted)
                      hideKeyboard(context);
                    Navigator.pop(context);
                  },
                );


                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text(translate("labels.refillTitle")),
                  content: Text(translate("messages.unsuccessRefillMessage")),
                  actions: [
                    okButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }
            }
          else if (state is Station_GotSyberPayUrlState){

            if (state.syberPayGetUrlResponseBody.responseCode != null)
            {
              if (state.syberPayGetUrlResponseBody.responseCode == 1)
              {
                User user = await  getCurrentUserValue();

                UserRefillTransactionDto userRefillTransactionDto = UserRefillTransactionDto(
                transactionId: state.syberPayGetUrlResponseBody.transactionId,
                date: DateTime.now().toString(),
                userId: user.id, amount: state.syberPayGetUrlResponseBody.amount, status: false);
                bloc.add(AddUserRefillTransactionEvent(userRefillTransactionDto, state.syberPayGetUrlResponseBody));
              }
              else
                pushToast("messages.couldNotGetSyberPayUrl");
            }
            else
              pushToast("messages.couldNotGetSyberPayUrl");

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

class _BuildUIState extends State<_BuildUI>{
  OverlayEntry? overlayEntry;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();

    if (!notificationsController.isClosed)
    {
      notificationsController.stream.listen((notificationBody) {
        if (mounted) {
          hideKeyboard(context);
          if (!widget.bloc.isClosed)
            widget.bloc.add(GetUserBalanceInStationEvent());
        }
      });
    }


    getCurrentUserValue().then((value) {
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

    if (!updateProfileStreamController.isClosed) {
      updateProfileStreamController.stream.listen((event) {
        if (mounted) {
          setState(() {
            userName = event.firstName ?? "";
          });
        }
      });
    }

    if (!addRemoveFavoriteStreamController.isClosed) {
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
  }

  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:

        RefreshIndicator(onRefresh: () async {
          if (!widget.bloc.isClosed)
            widget.bloc.add(InitStationEvent());
    },
    color: Colors.white,
    backgroundColor: buttonColor1,
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    child:

        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                /*Stack(
                  children: [
                    (isArabic())
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(pi),
                            child:
                                Image(image: AssetImage("assets/home_box.png")))
                        : Image(image: AssetImage("assets/home_box.png")),
                    FutureBuilder<User>(
                        future: getCurrentUserValue(),
                        builder: (context, AsyncSnapshot<User> snapshot) {
                          User usr = _buildUserInstance(snapshot);
                          if (usr.id != null) {
                            return Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  child: Padding(
                                    child: AutoSizeText(
                                      userName,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black,
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
                                    child: (widget.state is LoadingStationState) ? CustomLoading() : Text(
                                      translate("labels.balance") +
                                          " : " +
                                          formatter.format(userBalance) +
                                          " " +
                                          translate("labels.sdg"),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    padding: EdgeInsetsDirectional.only(
                                        start: SizeConfig().w(50),
                                        end: SizeConfig().w(50),
                                        top: SizeConfig().h(20)),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),


                                Padding(child:
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: radiusAll10,
                                      border: Border.all(color: Colors.white, width: 0.5),
                                      color: Colors.white30,),
                                  margin: EdgeInsets.fromLTRB(SizeConfig().w(115),  0, SizeConfig().w(115), 0),
                                  child:
                                      Padding(child:
                                      (widget.state is LoadingStationState) ? CustomLoading() : InkWell(child:

                                      Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Image.asset(
                                    'assets/syber_pay_icon.png',
                                    width: SizeConfig().w(40),
                                    height: SizeConfig().h(40),
                                  ),
                                  Text(
                                    translate("labels.refillAccount"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                ],), onTap: (){
                                        _topUp();
                                      },),padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5)),),padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),)
                              ],
                            ));
                          } else {
                            return CustomLoading();
                          }
                        })
                  ],
                ), */
                HomeBoxWidget(stationBloc: widget.bloc, stationState: widget.state, userBalance: userBalance,),
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
                                      hintStyle: smallCustomBlackColor6(),
                                      style: largeMediumPrimaryColor4(),
                                      icon: Icon(Icons.search),
                                      focusNode: searchFocusNode,
                                      controller: searchController,
                                      hintText:
                                          translate("labels.stationNumber"),
                                      textInputType: TextInputType.text,
                                      textInputAction: TextInputAction.search,
                                      onFieldSubmitted: (_) {

                                        searchText = searchController.text;
                                        searchText = convertArabicToEnglishNumbers(searchText);

                                        hideKeyboard(context);
                                        widget.bloc.add(
                                            StationByTextEvent(
                                                searchText));

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
                                                        NewStationWidget(
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

                                Align(
                                  child: Padding(
                                    child: Text(
                                      translate("labels.currently_available_stations"),
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
                                  AlignmentDirectional.center,
                                ),
                                (favoriteStations.length > 0)
                                    ? Column(
                                        children: favoriteStations
                                            .map((i) => NewStationWidget(
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
                                Align(
                                  child: Padding(
                                    child: Text(
                                      translate("labels.more_gas_stations_coming_soon"),
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
                                  AlignmentDirectional.center,
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
            ))));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (mounted) {
      setState(() {
        hideKeyboard(context);
      });
    }
  }

  String convertArabicToEnglishNumbers(String input)
  {
    const english = ['0','1','2','3','4','5','6','7','8','9'];
    const arabic = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];

    for (int i = 0; i < arabic.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    return input;
  }


  _topUp()
  {
    final amountToRefillController = TextEditingController();
    final amountToRefillFocusNode = FocusNode();

    Widget cancelButton = TextButton(
      child: Text(translate("buttons.cancel"), style: TextStyle(color: Colors.black),),
      onPressed:  () {
        if (mounted)
          hideKeyboard(context);
        Navigator.pop(context);
      },
    );

    Widget okButton = TextButton(
      child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
      onPressed:  () async {
        if (mounted)
          hideKeyboard(context);
        Navigator.pop(context);
        await calcHashAndGetSyberPayUrl(double.parse(amountToRefillController.text));
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(translate("labels.refillPopupTitle")),
      content: Padding(
          child: CustomTextFieldWidget(
            hintStyle: smallCustomGreyColor6(),
            style: largeMediumPrimaryColor4(),
            focusNode: amountToRefillFocusNode,
            controller: amountToRefillController,
            hintText:
            translate("labels.amount"),
            textInputType: TextInputType.numberWithOptions(signed: false, decimal: true),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) async {
              hideKeyboard(context);
              if (amountToRefillController.text.trim() != "")
                await calcHashAndGetSyberPayUrl(double.parse(amountToRefillController.text));
            },
          ),
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig().w(30),
            end: SizeConfig().w(30),
            top: SizeConfig().h(15),
            bottom: SizeConfig().h(0),)),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


  }


  calcHashAndGetSyberPayUrl(double topUpAmount)
  async {
    if (topUpAmount > 0) {
      User u = await getCurrentUserValue();
      String key = r"f@$tf!llK3y";
      String salt = r"f@$tf!ll$@lt";
      String applicationId = r'f@$tf!llApp';//"0000000361";
      String serviceId = r"f@$tf!ll267";
      String amount = topUpAmount.toString();
      String currency = "SDG";
      String customerRef = u.firstName!;
      String all = key + "|" + applicationId + "|" + serviceId + "|" + amount +
          "|" + currency + "|" + customerRef + "|" + salt;
      var AllInBytes = utf8.encode(all);
      String value = sha256.convert(AllInBytes).toString();

      SyberPayGetUrlBody spgub = SyberPayGetUrlBody(
          applicationId: applicationId,
          serviceId: serviceId,
          amount: topUpAmount,
          currency: currency,
          customerRef: customerRef,
          hash: value);

      if (!widget.bloc.isClosed)
        widget.bloc.add(Station_GetSyberPayUrlEvent(spgub));
    }
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
