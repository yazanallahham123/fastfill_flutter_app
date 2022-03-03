import 'package:fastfill/helper/const_sizes.dart';
import 'package:fastfill/helper/const_styles.dart';
import 'package:fastfill/helper/font_styles.dart';
import 'package:fastfill/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'methods.dart';


class TextFieldPasswordWidget extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final bool Function(String? value)? validator;

  TextFieldPasswordWidget(
      {Key? key,
      this.hintText,
      required this.controller,
      this.textInputAction,
      this.focusNode,
      this.onFieldSubmitted,
      this.validator,
      this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool?> showError = ValueNotifier<bool?>(null);
    ValueNotifier<bool> showPassword = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool?>(
            valueListenable: showError,
            builder: (BuildContext context, value, Widget? child) {
              return Container(
                  height: (value != null && value) ? SizeConfig().h(70) : SizeConfig().h(55),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig().h(47),
                      decoration: BoxDecoration(
                        borderRadius: radiusAll10,
                        color: Colors.white,
                      ),
                      child: ValueListenableBuilder<bool>(
                          valueListenable: showPassword,
                          builder: (_, hidePassword, ___) {
                            return TextFormField(
                                controller: controller,
                                cursorColor: Colors.black,
                                obscureText: hidePassword,
                                focusNode: focusNode,
                                textInputAction: textInputAction,
                                maxLines: 1,
                                onFieldSubmitted: onFieldSubmitted,
                                style: largeMediumPrimaryColor2(),
                                decoration: new InputDecoration(
                                    isDense: true,
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          showPassword.value =
                                              !showPassword.value;
                                          print(hidePassword.toString());
                                        },
                                        child: Container(
                                            width: SizeConfig().w(50),
                                            child: Icon(
                                                hidePassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Color(0xffA4B0BF)))),
                                    border: OutlineInputBorder(
                                      borderRadius: radiusAll10,
                                    ),
                                    errorStyle: TextStyle(color: Colors.red),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: showError.value == null
                                                ? Colors.amber
                                                : showError.value == true
                                                    ? Colors.red
                                                    : Colors.green,
                                            width: width1),
                                        borderRadius: radiusAll10),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: width1),
                                        borderRadius: radiusAll10),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: showError.value == null
                                                ? Color(0xffd8e0e5)
                                                : showError.value == true
                                                    ? Colors.red
                                                    : Colors.green,
                                            width: width1),
                                        borderRadius: radiusAll10),
                                    hintStyle: smallCustomGreyColor4(),
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(
                                        SizeConfig().w(20),
                                        0,
                                        SizeConfig().w(20),
                                        SizeConfig().h(16)),
                                    hintText: hintText),
                                onChanged: (stringValue) {
                                  showError.value =
                                      (!isStrongPassword(stringValue) ||
                                          !isValidator(stringValue));
                                });
                          }),
                    ),
                    if (value != null && value)
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig().w(10)),
                          child: Text(
                              (!isValidator(controller.text) &&
                                      errorText != null)
                                  ? errorText!
                                  : translate("messages.passContain7Char"),
                              style: errorStyle())),
                  ]));
            });
  }

  bool isValidator(String value) {
    if(validator == null) return true;
    return validator!(value);
  }
}
