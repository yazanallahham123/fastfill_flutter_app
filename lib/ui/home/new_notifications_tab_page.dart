
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
import '../../utils/notifications.dart';

class NewNotificationsTabPage extends StatefulWidget {
  const NewNotificationsTabPage({Key? key}) : super(key: key);

  @override
  State<NewNotificationsTabPage> createState() => _NewNotificationsTabPageState();
}

List<NotificationBody> notifications = [];
bool hasNext = false;
int currentPage = 1;

class _NewNotificationsTabPageState extends State<NewNotificationsTabPage> {
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
            notifications = [];
            currentPage = 1;
            bloc.add(GetNotificationsEvent(1));
          }
          else
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is GotNotificationsState) {
            if (mounted) {
              setState(() {
                if (state.notifications != null) {
                  if (state.notifications.paginationInfo != null)
                    hasNext = state.notifications.paginationInfo!.hasNext!;
                  else
                    hasNext = false;

                  if (state.notifications.notifications != null)
                    notifications.addAll(state.notifications.notifications!);
                  else {
                    hasNext = false;
                  }
                }
                else
                  {
                    hasNext = false;
                  }

                print("Current Page:");
                print(currentPage);
                print("hasNext:");
                print(hasNext);
              });
            }
          }
          else
            if (state is ClearedUserNotificationsState)
              {
                if (mounted) {
                  setState(() {
                    currentPage = 1;
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

  ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);

    notificationsController.stream.listen((notificationBody) {
      hideKeyboard(context);
      notifications = [];
      currentPage = 1;
      widget.bloc.add(GetNotificationsEvent(1));
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
            Column(children: [
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
                        (notifications.length > 0) ?

                            InkWell(child:
                            Text(translate("buttons.clear"),style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: buttonColor1)), onTap: () {
                              widget.bloc.add(ClearUserNotificationsEvent());
                            },) :

                        Container()
                      ],),
                    padding: EdgeInsetsDirectional.only(
                        start: SizeConfig().w(25),
                        end: SizeConfig().w(25),
                        top: SizeConfig().h(10))),
                alignment: AlignmentDirectional.topStart,
              ),
                  Expanded(child:
                  (widget.state is LoadingUserState) ? Center(child:
                  CustomLoading(),) :

                  LayoutBuilder(builder: (context, constraints) =>
                      RefreshIndicator(onRefresh: () async {
                        currentPage = 1;
                        notifications = [];
                        widget.bloc.add(GetNotificationsEvent(1));
                      },
                          color: Colors.white,
                          backgroundColor: buttonColor1,
                          triggerMode: RefreshIndicatorTriggerMode.anywhere,
                          child:


                          (notifications.length == 0) ?
                          SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child:
                                  ConstrainedBox(
    constraints: BoxConstraints(minHeight: constraints.maxHeight),
    child:

                              Center(child: ListView(
                                shrinkWrap: true,
                                children: [

                                  Align(child: SvgPicture.asset("assets/svg/no_notifications.svg"),alignment: AlignmentDirectional.center,),
                                  Align(child: Text(translate("labels.noNotifications"), style: TextStyle(color: Colors.white),),alignment: AlignmentDirectional.center,)

                                ],

                              )))) :
                          ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: controller,
                            itemBuilder: (context, index)
                            {
                              if ((notifications[index].typeId == "3") ||  (notifications[index].typeId == "4"))
                                return Padding(child: AccountRefillNotificationWidget(notification: notifications[index]), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),);
                              else
                                return Padding(child: NormalNotificationWidget(notification: notifications[index]), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10));
                            },
                            itemCount: notifications.length,
                          ))
                  )
                 ),
                ],)
        );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if (hasNext) {
      if (controller.position.pixels ==
          (controller.position.maxScrollExtent * .75)) {
        setState(() {
          currentPage = currentPage + 1;
          widget.bloc.add(GetNotificationsEvent(currentPage));
        });
      }
    }
  }
}