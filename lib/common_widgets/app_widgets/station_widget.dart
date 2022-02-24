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
import '../../ui/station/purchase_page.dart';
import 'favorite_button.dart';

class StationBranchWidget extends StatefulWidget{

  final StationBranch stationBranch;
  final StationBloc stationBloc;
  final StationState stationState;
  const StationBranchWidget({required this.stationBranch, required this.stationBloc, required this.stationState});

  @override
  State<StationBranchWidget> createState() => _StationBranchWidgetState();
}

class _StationBranchWidgetState extends State<StationBranchWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              Navigator.pushNamed(
                  context, PurchasePage.route,
                  arguments: widget.stationBranch);
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


              Padding(child:((widget.stationState is AddingRemovingStationBranchToFavorite) &&
              ((widget.stationState as AddingRemovingStationBranchToFavorite).stationBranchId == widget.stationBranch.id)) ?
                  CustomLoading()
                  :
              FavoriteButtonWidget(isAddedToFavorite:widget.stationBranch.isFavorite!, onTap: () {
                if (widget.stationBranch.isFavorite!)
                  widget.stationBloc.add(RemoveStationBranchFromFavoriteEvent(widget.stationBranch.id!));
                else
                  widget.stationBloc.add(AddStationBranchToFavoriteEvent(widget.stationBranch.id!));
              },),padding: EdgeInsetsDirectional.fromSTEB(0, 40, 20, 0) ,)
            ]),
        Column(
          children: [
            Align(child: Padding(
              child: Text(
                (isArabic()) ? widget.stationBranch.arabicName! : widget.stationBranch.englishName!,
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
                widget.stationBranch.code!,
                style: TextStyle(fontSize: 16),
              ),
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig().w(40),
                end: SizeConfig().w(40),
              ),
            ), alignment: AlignmentDirectional.topStart,),
            Align(child: Padding(
              child: Text(
                (isArabic()) ? widget.stationBranch.arabicAddress! : widget.stationBranch.englishAddress!,
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
    );
  }
}