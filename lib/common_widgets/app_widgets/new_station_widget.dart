import 'dart:io';
import 'dart:math';

import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/methods.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/model/station/station_branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/station/bloc.dart';
import '../../bloc/station/event.dart';
import '../../bloc/station/state.dart';
import '../../model/station/station.dart';
import '../../ui/station/purchase_page.dart';
import '../../utils/misc.dart';
import 'favorite_button.dart';

class NewStationWidget extends StatefulWidget{

  final Station station;
  final StationBloc? stationBloc;
  final StationState? stationState;
  final bool? openPurchaseOnClick;
  final bool? hideFavorite;
  const NewStationWidget({required this.station, this.stationBloc, this.stationState,
  this.openPurchaseOnClick,
  this.hideFavorite
  });

  @override
  State<NewStationWidget> createState() => _NewStationWidgetState();
}

class _NewStationWidgetState extends State<NewStationWidget> {
  @override
  Widget build(BuildContext context) {
    return

      InkWell(child:
      Container(
      padding: EdgeInsetsDirectional.fromSTEB(25, 15, 25, 15),
      margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/station.png"),
          fit: BoxFit.fill
        )
      ),
      child:
      Row(children: [
        Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Align(
              child: Text(
                (isArabic()) ? widget.station.arabicName! : widget.station.englishName!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            alignment: AlignmentDirectional.topStart,),
            Align(child: Text(
                widget.station.code!,
                style: TextStyle(fontSize: 16),
              ),
            alignment: AlignmentDirectional.topStart,),
            Align(
              child: Text(
                (isArabic()) ? widget.station.arabicAddress! : widget.station.englishAddress!,
                style: TextStyle(fontSize: 16),
              ),
            alignment: AlignmentDirectional.topStart,),

          ],)),

        Row(children: [


          Padding(child:
        Image(
            width: SizeConfig().w(40),
            image: AssetImage(
                "assets/icon_station.png")),
          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
          ),

          (((widget.hideFavorite??false) == false) && (widget.stationBloc != null) && (widget.stationState != null)) ?
    Padding(child:
    ((widget.stationState is AddingRemovingStationToFavorite) &&
            ((widget.stationState as AddingRemovingStationToFavorite).stationId == widget.station.id)) ?
        CustomLoading()
            :
        FavoriteButtonWidget(isAddedToFavorite:widget.station.isFavorite!, onTap: () {
          hideKeyboard(context);
          if (widget.station.isFavorite!)
            widget.stationBloc!.add(RemoveStationFromFavoriteEvent(widget.station.id!));
          else
            widget.stationBloc!.add(AddStationToFavoriteEvent(widget.station.id!));
        },), padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),) : Container()
        ],)
      ],),
    ), onTap: () {
        if ((widget.openPurchaseOnClick??true)) {
            hideKeyboard(context);
            Navigator.pushNamed(
                context, PurchasePage.route,
                arguments: widget.station);
        }
      });
  }
}