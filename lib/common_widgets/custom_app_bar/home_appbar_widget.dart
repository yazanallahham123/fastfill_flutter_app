import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fastfill/api/apis.dart';
import 'package:fastfill/bloc/user/event.dart';
import 'package:fastfill/bloc/user/state.dart';
import 'package:fastfill/common_widgets/app_widgets/back_button_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/bank_card_widget.dart';
import 'package:fastfill/common_widgets/app_widgets/custom_loading.dart';
import 'package:fastfill/helper/app_colors.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:fastfill/helper/toast.dart';
import 'package:fastfill/model/user/add_bank_card_body.dart';
import 'package:fastfill/model/user/bank_card.dart';
import 'package:fastfill/model/user/user.dart';
import 'package:fastfill/ui/auth/login_page.dart';
import 'package:fastfill/ui/auth/signup_page.dart';
import 'package:fastfill/ui/contact_us/contact_us_page.dart';
import 'package:fastfill/ui/profile/profile_page.dart';
import 'package:fastfill/ui/settings/settings_page.dart';
import 'package:fastfill/ui/terms/terms_page.dart';
import 'package:fastfill/utils/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../bloc/station/state.dart';
import '../../bloc/user/bloc.dart';
import '../../helper/const_styles.dart';
import '../../helper/methods.dart';
import '../../model/user/edit_bank_card_body.dart';
import '../../streams/update_profile_stream.dart';
import '../../utils/misc.dart';
import '../buttons/custom_button.dart';
import '../custom_text_field_widgets/custom_textfield_widget.dart';

class HomeAppBarWidget extends StatefulWidget implements PreferredSizeWidget{
  const HomeAppBarWidget({Key? key}) : super(key: key);

  @override
  State<HomeAppBarWidget> createState() => HomeAppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

TextEditingController bankNameController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController monthController = TextEditingController();
TextEditingController dayController = TextEditingController();

FocusNode bankNameFocusNode = FocusNode();
FocusNode cardNumberFocusNode = FocusNode();
FocusNode monthFocusNode = FocusNode();
FocusNode dayFocusNode = FocusNode();

StreamController<FormType> showAddEditStreamController = StreamController<FormType>.broadcast();
StreamController<List<BankCard>> refreshBankCardListStreamController = StreamController<List<BankCard>>.broadcast();
StreamController<UserState> stateStreamController = StreamController<UserState>.broadcast();
BankCard bankCardToEdit = BankCard();

enum FormType {Add, Edit, Close}

class HomeAppBarWidgetState extends State<HomeAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) =>
        UserBloc()..add(UserInitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          stateStreamController.add(state);
          if (state is InitUserState) {
            bloc.add(GetBankCardsEvent());
          } else if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is GotBankCardsState) {
            if (state.bankCardsWithPagination.bankCards != null)
              refreshBankCardListStreamController.add(state.bankCardsWithPagination.bankCards!);
          } else if (state is AddedBankCardState)
            {
              showAddEditStreamController.add(FormType.Close);
              bloc.add(GetBankCardsEvent());
              bankNameController.text = "";
              cardNumberController.text = "";
              monthController.text = "";
              dayController.text = "";
            }
          else if (state is EditedBankCardState)
          {
            showAddEditStreamController.add(FormType.Close);
            bloc.add(GetBankCardsEvent());
            bankNameController.text = "";
            cardNumberController.text = "";
            monthController.text = "";
            dayController.text = "";
            bankCardToEdit = BankCard();
          }
          else if (state is DeletedBankCardState)
          {
            showAddEditStreamController.add(FormType.Close);
            bloc.add(GetBankCardsEvent());
            bankNameController.text = "";
            cardNumberController.text = "";
            monthController.text = "";
            dayController.text = "";
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
  void initState() {
    super.initState();
  }
  
  void onEdit(BankCard bankCard)
  {
    bankCardToEdit = bankCard;
    bankNameController.text = bankCard.bankName!;
    cardNumberController.text = bankCard.cardNumber!;
    monthController.text = bankCard.expiryDate!.substring(0, bankCard.expiryDate!.indexOf("/"));
    dayController.text = bankCard.expiryDate!.substring(bankCard.expiryDate!.indexOf("/")+1, 5);
    showAddEditStreamController.add(FormType.Edit);
  }
  
  void onDelete(BankCard bankCard)
  {
    Widget cancelButton = TextButton(
      child: Text(translate("buttons.cancel"), style: TextStyle(color: Colors.black),),
      onPressed:  () {
        hideKeyboard(context);
        Navigator.pop(context);
      },
    );

    Widget okButton = TextButton(
      child: Text(translate("buttons.ok"), style: TextStyle(color: Colors.black),),
      onPressed:  () async {
        Navigator.pop(context);
        hideKeyboard(context);
        widget.bloc.add(DeleteBankCardEvent(bankCard.id!));
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(translate("labels.delete")),
      content: Text(translate("messages.deleteBankCard")),
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

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        elevation: 0,
        backgroundColor: backgroundColor1,
        title:
   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //InkWell(
            //onTap: () {
            //},

            PopupMenuButton(
              onSelected: (s) async {
                hideKeyboard(context);
                if (s == LoginPage.route)
                  {
                    showLogoutAlertDialog(context);
                  }
                else if (s == TermsPage.route)
                  {
                    Navigator.pushNamed(context, TermsPage.route);
                  } else if (s == ContactUsPage.route)
                    {
                      Navigator.pushNamed(context, ContactUsPage.route);
                    }else if (s == SettingsPage.route)
                {
                  Navigator.pushNamed(context, SettingsPage.route);
                }
              },
              color: backgroundColor1,
                itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: TermsPage.route,
                      child: Text(translate("labels.terms"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: ContactUsPage.route,
                      child: Text(translate("labels.contactUs"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: SettingsPage.route,
                      child: Text(translate("labels.settings"), style: TextStyle(color: Colors.white),),
                    ),
                    PopupMenuItem(
                      value: LoginPage.route,
                      child: Text(translate("labels.logout"), style: TextStyle(color: Colors.white),),
                    )
                  ],
            child: Container(
                alignment: Alignment.topLeft,
                height: SizeConfig().h(45),
                width: SizeConfig().h(45),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig().w(12),
                    vertical: SizeConfig().h(55)),
                child: SvgPicture.asset(
                  'assets/svg/menu.svg',
                  width: SizeConfig().w(50),
                ))),
          //),

          Padding(child: InkWell(
            onTap: () async {


              AlertDialog alert = AlertDialog(
                alignment: AlignmentDirectional.topStart,
                insetPadding: EdgeInsets.fromLTRB(50, 25, 50, 50),
                backgroundColor: backgroundColor4,
                title: StreamBuilder(stream: showAddEditStreamController.stream, builder: (BuildContext context, AsyncSnapshot<FormType> snapshot) {

                  return Row(

                    children: [
                      InkWell(child:
                      (isArabic()) ? Icon(Icons.arrow_forward, color: buttonColor1,) : Icon(Icons.arrow_back,  color: buttonColor1),
                        onTap: () {
                          if ((snapshot.data??FormType.Close) == FormType.Close)
                            {
                            Navigator.pop(context);
                          }
                          else
                            {
                              if ((snapshot.data??FormType.Close) == FormType.Add) {
                                showAddEditStreamController.add(FormType.Close);
                              }
                            }
                        },
                      ),

                      Container(
                          decoration: BoxDecoration(
                              color: backgroundColor4, borderRadius: radiusAll10),
                          padding: EdgeInsets.all(8),
                          child:
                          Row(children: [
                            Padding(child:
                            SvgPicture.asset(
                              'assets/svg/cards_icon.svg',
                              width: SizeConfig().w(25),
                            ), padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),),

                            Text(
                              translate("labels.cards"),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: buttonColor1),
                            ),
                          ],)),

                      Padding(
                          padding: EdgeInsetsDirectional.only(top: SizeConfig().h(10)),
                          child: Container(
                              height: 30,
                              child: CustomButton(
                                  backColor: buttonColor1,
                                  titleColor: Colors.black,
                                  borderColor: buttonColor1,
                                  title: translate((((snapshot.data??FormType.Close) == FormType.Close)) ? "buttons.add" : "buttons.save"),
                                  onTap: () {
                                    if ((snapshot.data??FormType.Close) == FormType.Add)
                                    {
                                      addCard();
                                    }
                                    else
                                      {
                                      if ((snapshot.data??FormType.Close) == FormType.Edit) {
                                        editCard();
                                      }
                                      else
                                        showAddEditStreamController.add(
                                            FormType.Add);
                                      }
                                  })))

                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  );
                }),
                titlePadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                contentPadding: EdgeInsets.all(0),
                content: StreamBuilder(stream: showAddEditStreamController.stream, builder: (BuildContext context, AsyncSnapshot<FormType> showAddEditSnapshot) {
                return

                StreamBuilder(stream: refreshBankCardListStreamController.stream, builder: (BuildContext context, AsyncSnapshot<List<BankCard>> bankCardsSnapshot) {

                  return StreamBuilder(stream: stateStreamController.stream, builder: (BuildContext context, AsyncSnapshot<UserState> stateSnapshot) {
                    return
                      ((stateSnapshot.data??LoadingUserState()) == LoadingUserState()) ?
                      CustomLoading() :
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                        child:

                        ((showAddEditSnapshot.data??FormType.Close) == FormType.Close)
                            ?
                        SingleChildScrollView(
                            child: (bankCardsSnapshot.data != null) ?
                            Column(children: bankCardsSnapshot.data!.map((bc) => BankCardWidget(bankCard: bc, onDelete: onDelete, onEdit: onEdit,)).toList(),) : Container())
                            :
                        Padding(child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(child: Text(translate("labels.bankName"), style: TextStyle(color: buttonColor1),),  alignment: AlignmentDirectional.topStart,),
                            CustomTextFieldWidget(
                              focusNode: bankNameFocusNode,
                              controller: bankNameController,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(cardNumberFocusNode);
                              },
                            ),
                            Align(child: Text(translate("labels.cardNumber"), style: TextStyle(color: buttonColor1),), alignment: AlignmentDirectional.topStart,),
                            CustomTextFieldWidget(
                              focusNode: cardNumberFocusNode,
                              controller: cardNumberController,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(monthFocusNode);


                              },
                            ),
                            Row(
                                  children: [
                                    Padding(child: Align(child: Text(translate("labels.expiryDate"), style: TextStyle(color: buttonColor1),), alignment: AlignmentDirectional.topStart,),
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),),
                                    Flexible(child: CustomTextFieldWidget(
                                    focusNode: monthFocusNode,
                                    hintText: translate("labels.month"),
                                    hintStyle: TextStyle(fontSize: 12),
                                    controller: monthController,
                                    textInputType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      FocusScope.of(context).requestFocus(dayFocusNode);
                                    },
                                  )),
                                  Text("-"),
                                  Flexible(child: CustomTextFieldWidget(
                                    focusNode: dayFocusNode,
                                    hintText: translate("labels.year"),
                                    hintStyle: TextStyle(fontSize: 12),
                                    controller: dayController,
                                    textInputType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    onFieldSubmitted: (_) {
                                      hideKeyboard(context);
                                      addCard();
                                    },
                                  )),
                            ],)
                          ],),padding: EdgeInsets.all(10),)

                      );

                });


    });
                }),
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  widget.bloc.add(GetBankCardsEvent());
                  return alert;
                },
              );
            },
            child:
            Container(
                decoration: BoxDecoration(
                color: backgroundColor4, borderRadius: radiusAll10),
                padding: EdgeInsets.all(8),
                child:
            Row(children: [
              Padding(child:
              SvgPicture.asset(
              'assets/svg/cards_icon.svg',
              width: SizeConfig().w(25),
            ), padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),),

              Text(
                translate("labels.cards"),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: buttonColor1),
              ),
            ],))
          ), padding: EdgeInsetsDirectional.fromSTEB(0, 37, 0, 30),),
          Padding(child: InkWell(
            onTap: () async {
              hideKeyboard(context);
              Navigator.pushNamed(context, ProfilePage.route);
            },
            child: Container(
                alignment: Alignment.topRight,
                height: SizeConfig().h(45),
                width: SizeConfig().h(45),
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig().w(12),
                    vertical: SizeConfig().h(55)),
                child: SvgPicture.asset(
                  'assets/svg/profile.svg',
                  width: SizeConfig().w(50),
                )),
          ), padding: EdgeInsetsDirectional.fromSTEB(0, 37, 0, 30),)
      ],),

    );
  }

  editCard()
  {
    if ((!bankNameController.text.trim().isEmpty) && (!cardNumberController.text.trim().isEmpty)
        && (!monthController.text.trim().isEmpty) && (!dayController.text.trim().isEmpty)
    ) {
      String month;
      if (monthController.text.length == 1)
        month = "0"+convertArabicToEnglishNumbers(monthController.text);
      else
        month = convertArabicToEnglishNumbers(monthController.text);

      String day;
      if (dayController.text.length == 1)
        day = "0"+convertArabicToEnglishNumbers(dayController.text);
      else
        day = convertArabicToEnglishNumbers(dayController.text);

      String expiryDate = month + "/" + day;
      EditBankCardBody editBankCardBody = EditBankCardBody(
          id: bankCardToEdit.id,
          bankName: bankNameController.text, cardNumber: convertArabicToEnglishNumbers(cardNumberController.text),
          expiryDate: expiryDate
      );
      widget.bloc.add(EditBankCardEvent(editBankCardBody));
    }
    else
    {
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
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


  addCard()
  {
    if ((!bankNameController.text.trim().isEmpty) && (!cardNumberController.text.trim().isEmpty)
    && (!monthController.text.trim().isEmpty) && (!dayController.text.trim().isEmpty)
    ) {
      String month;
      if (monthController.text.length == 1)
        month = "0"+convertArabicToEnglishNumbers(monthController.text);
      else
        month = convertArabicToEnglishNumbers(monthController.text);

      String day;
      if (dayController.text.length == 1)
        day = "0"+convertArabicToEnglishNumbers(dayController.text);
      else
        day = convertArabicToEnglishNumbers(dayController.text);

      String expiryDate = month + "/" + day;
      AddBankCardBody addBankCardBody = AddBankCardBody(bankName: bankNameController.text, cardNumber: convertArabicToEnglishNumbers(cardNumberController.text),
      expiryDate: expiryDate
      );
      widget.bloc.add(AddBankCardEvent(addBankCardBody));
    }
    else
    {
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
    }
  }

}
