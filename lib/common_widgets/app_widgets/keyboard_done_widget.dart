import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputDoneView extends StatelessWidget {

  final String title;
  final VoidCallback? onPressed;

  const InputDoneView({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              if (onPressed != null)
                onPressed!();
            },
            child: Text(
                title,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)
            ),
          ),
        ),
      ),
    );
  }
}