import 'dart:io';
import 'dart:math';

import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/helper/app_colors.dart';
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

class StationWidget extends StatefulWidget{

  final Station station;
  final StationBloc stationBloc;
  final StationState stationState;
  const StationWidget({required this.station, required this.stationBloc, required this.stationState});

  @override
  State<StationWidget> createState() => _StationWidgetState();
}

class _StationWidgetState extends State<StationWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(child:
      Stack(
      children: [
        InkWell(child:

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

            onTap: () {
              hideKeyboard(context);
              Navigator.pushNamed(
                  context, PurchasePage.route,
                  arguments: widget.station);
            }
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(child:
              Image(
                  width: SizeConfig().w(40),
                  image: AssetImage(
                      "assets/icon_station.png")), padding: EdgeInsetsDirectional.fromSTEB(0, 25, 20, 0),),


              Padding(child:((widget.stationState is AddingRemovingStationToFavorite) &&
              ((widget.stationState as AddingRemovingStationToFavorite).stationId == widget.station.id)) ?
                  CustomLoading()
                  :
              FavoriteButtonWidget(isAddedToFavorite:widget.station.isFavorite!, onTap: () {
                hideKeyboard(context);
                if (widget.station.isFavorite!)
                  widget.stationBloc.add(RemoveStationFromFavoriteEvent(widget.station.id!));
                else
                  widget.stationBloc.add(AddStationToFavoriteEvent(widget.station.id!));
              },),padding: EdgeInsetsDirectional.fromSTEB(0, 40, 20, 0) ,)
            ]),
        Column(
          children: [
            Align(child: Padding(
              child: Text(
                (isArabic()) ? widget.station.arabicName! : widget.station.englishName!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              padding: EdgeInsetsDirectional.only(
                  start: SizeConfig().w(40),
                  end: SizeConfig().w(40),
                  top: SizeConfig().w(16)),
            ), alignment: AlignmentDirectional.topStart,),
            Align(child: Padding(
              child: Text(
                widget.station.code!,
                style: TextStyle(fontSize: 16),
              ),
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig().w(40),
                end: SizeConfig().w(40),
              ),
            ), alignment: AlignmentDirectional.topStart,),
            Align(child: Padding(
              child: Text(
                (isArabic()) ? widget.station.arabicAddress! : widget.station.englishAddress!,
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
    ), padding: EdgeInsetsDirectional.fromSTEB(10, 1, 10, 1),);
  }
}