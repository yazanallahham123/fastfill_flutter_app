
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

import '../../common_widgets/app_widgets/account_refill_notification_widget.dart';
import '../../common_widgets/app_widgets/normal_notification_widget.dart';
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
          if (state is InitUserState) {
            if (!bloc.isClosed)
              bloc.add(GetNotificationsEvent(1));
          }
            else
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is GotNotificationsState) {
            if (mounted) {
              setState(() {
                if (state.notifications.notifications != null)
                  notifications = state.notifications.notifications!.where((x) => (x.content??"") != "").toList();
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


    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
        RefreshIndicator(onRefresh: () async {
          notifications.clear();
          if (!widget.bloc.isClosed)
            widget.bloc.add(GetNotificationsEvent(0));
    },
    color: Colors.white,
    backgroundColor: buttonColor1,
    triggerMode: RefreshIndicatorTriggerMode.anywhere,
    child:

        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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

                    ((i.typeId == "3") || (i.typeId == "4")) ?

                    AccountRefillNotificationWidget(notification: i,)


                        :
                    NormalNotificationWidget(notification: i)


                      , padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 10),)
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
            ))));
  }
}