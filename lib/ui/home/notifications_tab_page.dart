
import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/bloc/user/bloc.dart';
import 'package:fastfill/bloc/user/event.dart';
import 'package:fastfill/bloc/user/state.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/notification/notification_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../utils/misc.dart';

class NotificationsTabPage extends StatefulWidget {
  const NotificationsTabPage({Key? key}) : super(key: key);

  @override
  State<NotificationsTabPage> createState() => _NotificationsTabPageState();
}

List<NotificationBody> notifications = [];

class _NotificationsTabPageState extends State<NotificationsTabPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc()..add(UserInitEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is InitUserState)
            bloc.add(GetNotificationsEvent());
            else
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is GotNotificationsState) {
            if (mounted) {
              setState(() {
                if (state.notifications.notifications != null)
                  notifications = state.notifications.notifications!;
                else
                  notifications = [];
              });
            }
          }
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, UserState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final UserBloc bloc;
  final UserState state;


  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
            child:

            Column(
              children: [
                Align(
                  child: Padding(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Text(
                        translate("labels.notifications"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: buttonColor1),
                      ),
                          (notifications.length > 0) ? Text(translate("buttons.clear"),style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: buttonColor1)) : Container()
                      ],),
                      padding: EdgeInsetsDirectional.only(
                          start: SizeConfig().w(25),
                          end: SizeConfig().w(25),
                          top: SizeConfig().h(10))),
                  alignment: AlignmentDirectional.topStart,
                ),

                (widget.state is LoadingUserState) ?
                    CustomLoading()
                    :

                (notifications.length > 0) ?
                Padding(child:

                Column(children: notifications.map((i) =>
                    Padding(child:

                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white, borderRadius: radiusAll16),

                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child:
                        Column(children: [
                          Padding(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(((i.liters != null) ? (translate("labels.youBought")+" " + i.liters! + " "+translate("labels.litersOf")+" "+translate("labels."+((i.material != null) ? i.material! : ""))) : "")),
                              Text((i.time != null) ? i.time! : "")
                            ],),padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),
                    Divider(color: Colors.black45, thickness: 0.3,),

                    Row(children: [

                      SvgPicture.asset("assets/svg/refuel.svg", width: 50, height: 50,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 120,
                            child:
                            Padding(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child:
                                Text(translate("labels.fuelRefueling"), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),),

                                Text(((i.liters != null) ? i.liters!+' L.' : ""), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0)),),

                          Container(
                            width: MediaQuery.of(context).size.width - 120,
                            child:
                            Padding(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child:
                                Text(((i.date != null) ? i.date! : "") + " / " + ((i.time != null) ? i.time! : ""), style: TextStyle(color: Colors.black),),),

                                Text(((i.price != null) ? (i.price != "") ? formatter.format(double.parse(i.price!)) +' '+translate("labels.sdg") : "" : ""), style: TextStyle(color: Colors.black),),
                              ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0)),),

                          Container(
                            width: MediaQuery.of(context).size.width - 120,
                            child:
                            Padding(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child:
                                Text(((i.address != null) ? i.address! : ""), style: TextStyle(color: Colors.black),),),

                              ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0)),),
                        ],)
                    ],)],)), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),)
                ).toList(),),padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),) :

                    Container(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 150, 0, 0),
                      child:
                    Column(children: [
                    SvgPicture.asset("assets/svg/no_notifications.svg"),
                      Text(translate("labels.noNotifications"), style: TextStyle(color: Colors.white),)
                    ],)
                      ,)
              ],
            )));
  }
}