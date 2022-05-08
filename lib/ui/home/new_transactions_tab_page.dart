
import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/bloc/station/event.dart';
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

import '../../bloc/station/bloc.dart';
import '../../bloc/station/state.dart';
import '../../common_widgets/app_widgets/account_refill_notification_widget.dart';
import '../../common_widgets/app_widgets/new_transaction_widget.dart';
import '../../common_widgets/app_widgets/normal_notification_widget.dart';
import '../../common_widgets/app_widgets/transaction_widget.dart';
import '../../model/station/payment_transaction_result.dart';
import '../../utils/misc.dart';
import '../../utils/notifications.dart';

class NewTransactionsTabPage extends StatefulWidget {
  const NewTransactionsTabPage({Key? key}) : super(key: key);

  @override
  State<NewTransactionsTabPage> createState() => _NewTransactionsTabPageState();
}

List<PaymentTransactionResult> paymentTransactions = [];
bool hasNext = false;
int currentPage = 1;

class _NewTransactionsTabPageState extends State<NewTransactionsTabPage> {
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
          if (state is InitStationState) {
            paymentTransactions = [];
            currentPage = 1;
            bloc.add(GetPaymentTransactionsEvent(1));
          }
          else
          if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotPaymentTransactionsState) {
            if (mounted) {
              setState(() {
                if (state.paymentTransactionsWithPagination != null) {
                  if (state.paymentTransactionsWithPagination.paginationInfo != null)
                    hasNext = state.paymentTransactionsWithPagination.paginationInfo!.hasNext!;
                  else
                    hasNext = false;

                  if (state.paymentTransactionsWithPagination.paymentTransactions != null)
                    paymentTransactions.addAll(state.paymentTransactionsWithPagination.paymentTransactions!);
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
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, StationState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final StationBloc bloc;
  final StationState state;


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
      paymentTransactions = [];
      currentPage = 1;
      widget.bloc.add(GetPaymentTransactionsEvent(1));
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
                      translate("labels.transactions"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: buttonColor1),
                    ),
                  ],),
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig().w(25),
                    end: SizeConfig().w(25),
                    top: SizeConfig().h(10))),
            alignment: AlignmentDirectional.topStart,
          ),
          Expanded(child:
          (widget.state is LoadingStationState) ? Center(child:
          CustomLoading(),) :

          LayoutBuilder(builder: (context, constraints) =>
              RefreshIndicator(onRefresh: () async {
                currentPage = 1;
                paymentTransactions = [];
                widget.bloc.add(GetPaymentTransactionsEvent(1));
              },
                  color: Colors.white,
                  backgroundColor: buttonColor1,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  child:


                  (paymentTransactions.length == 0) ?
                  SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child:
                      ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child:

                          Center(child: ListView(
                            shrinkWrap: true,
                            children: [

                              Align(child: Text(translate("labels.noTransactions"), style: TextStyle(color: Colors.white),),alignment: AlignmentDirectional.center,)

                            ],

                          )))) :
                  ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    itemBuilder: (context, index)
                    {
                        return Padding(child: NewTransactionWidget(transaction: paymentTransactions[index]), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10));
                    },
                    itemCount: paymentTransactions.length,
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
          widget.bloc.add(GetPaymentTransactionsEvent(currentPage));
        });
      }
    }
  }
}