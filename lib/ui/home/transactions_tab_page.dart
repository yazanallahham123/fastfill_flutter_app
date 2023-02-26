
import 'package:fastfill/bloc/otp/bloc.dart';
import 'package:fastfill/bloc/otp/state.dart';
import 'package:fastfill/bloc/station/bloc.dart';
import 'package:fastfill/bloc/station/event.dart';
import 'package:fastfill/bloc/station/state.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/common_widgets/app_widgets/transaction_widget.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/payment/payment_result_body.dart';
import 'package:fastfill/model/station/payment_transaction_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';

import '../../helper/methods.dart';
import '../../utils/misc.dart';
import '../station/payment_result_page.dart';
import '../station/purchase_page.dart';

class TransactionsTabPage extends StatefulWidget {
  const TransactionsTabPage({Key? key}) : super(key: key);

  @override
  State<TransactionsTabPage> createState() => _TransactionsTabPageState();
}

List<PaymentTransactionResult> allPaymentTransactions = [];

class _TransactionsTabPageState extends State<TransactionsTabPage> {
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
          if (state is ErrorStationState)
            pushToast(state.error);
          else if (state is GotPaymentTransactionsState) {
            if (mounted) {
              setState(() {
                allPaymentTransactions = state.paymentTransactionsWithPagination.paymentTransactions!;
              });
            }
          }
          else if (state is InitStationState){
            if (!bloc.isClosed)
            bloc.add(GetPaymentTransactionsEvent(1));
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

class _BuildUI extends StatelessWidget {
  final StationBloc bloc;
  final StationState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:

        RefreshIndicator(onRefresh: () async {
          if (!bloc.isClosed)
            bloc.add(GetPaymentTransactionsEvent(1));
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
                      child: Text(
                        translate("labels.transactions"),
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


                (state is LoadingStationState) ? CustomLoading() : (allPaymentTransactions.length > 0) ?
                Column(children: allPaymentTransactions.map((i) =>
                TransactionWidget(transaction: i)
                ).toList(),)
                  :

                Container(
                  //padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                  height: MediaQuery.of(context).size.height-SizeConfig().h(250),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translate("labels.noTransactions"),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ))));
  }
}