import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../helper/const_styles.dart';
import '../../model/notification/notification_body.dart';

class NormalNotificationWidget extends StatelessWidget
{
  final NotificationBody notification;
  const NormalNotificationWidget({Key? key, required this.notification
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: radiusAll16),

        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
        child:
        Column(children: [
          Padding(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text((notification.title != null ) ? notification.title! : ""),
              Text((notification.time != null) ? notification.time! : "")
            ],),padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),
          Divider(color: (notification.typeId == "3") ? Colors.black45 : Colors.red, thickness: 0.3,),

          Row(children: [

            Image(image: AssetImage("assets/notification.png"),
                width: 50, height: 50
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child:
                  Padding(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((notification.content != null) ? notification.content! : "", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],), padding: EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0)),),
              ],)
          ],)],));
  }

}