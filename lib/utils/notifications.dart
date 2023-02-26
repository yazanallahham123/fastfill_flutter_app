import 'dart:async';
import 'package:fastfill/api/methods.dart';
import 'package:fastfill/api/retrofit.dart';
import 'package:fastfill/model/notification/notification_body.dart';
import 'package:fastfill/model/user/update_firebase_token_body.dart';
import 'package:fastfill/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../model/user/user.dart';
import 'local_data.dart';

final StreamController<NotificationBody> notificationsController = StreamController<NotificationBody>.broadcast();
final Stream notificationsStream = notificationsController.stream;
final Notifications notifications = Notifications();
final ApiClient mClient = ApiClient(certificateClient());

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");

  var user = await getCurrentUserValue();

  print("notification message: ${message.data}");
  NotificationBody notificationBody = NotificationBody(
      imageURL : message.data["imageURL"]?.toString() ?? "",
      title : message.data["title"]?.toString() ?? "",
      content : message.data["content"]?.toString() ?? "",
      notes : message.data["notes"]?.toString() ?? "",
      typeId : message.data["typeId"]?.toString() ?? "",
      date : message.data["date"]?.toString() ?? "",
      time : message.data["time"]?.toString() ?? "",
      price: message.data["price"]?.toString() ?? "",
      liters: message.data["liters"]?.toString() ?? "",
      address: message.data["address"]?.toString() ?? "",
      material: message.data["material"]?.toString() ?? "",
      userId: (user.id != null) ? user.id : 0
  );

  if ((message.data["typeId"].toString() != "3") && (message.data["typeId"].toString() != "4")) {
    if (user != null) {
      if (user.id != null) {
        if (user.id! > 0) {
          var token = await getBearerTokenValue();
          if (token != null)
            await mClient.addNotification(token, notificationBody);
        }
      }
    }
  }

  notificationsController.sink.add(notificationBody);
}

class Notifications {


  Notifications._();

  factory Notifications() => _instance;

  static final Notifications _instance = Notifications._();

  Future<void> init() async {


    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {

      navigatorKey.currentState!.pushNamed(HomePage.route, arguments: 2);

    });

    FirebaseMessaging.onMessage.listen((message) async {
      var user = await getCurrentUserValue();
      
      print("notification message: ${message.data}");
      NotificationBody notificationBody = NotificationBody(
          imageURL : message.data["imageURL"]?.toString() ?? "",
          title : message.data["title"]?.toString() ?? "",
          content : message.data["content"]?.toString() ?? "",
          notes : message.data["notes"]?.toString() ?? "",
          typeId : message.data["typeId"]?.toString() ?? "",
          date : message.data["date"]?.toString() ?? "",
          time : message.data["time"]?.toString() ?? "",
          price: message.data["price"]?.toString() ?? "",
          liters: message.data["liters"]?.toString() ?? "",
          address: message.data["address"]?.toString() ?? "",
          material: message.data["material"]?.toString() ?? "",
      userId: (user.id != null) ? user.id : 0
      );

      if ((message.data["typeId"].toString() != "3") && (message.data["typeId"].toString() != "4")) {
        if (user != null) {
          if (user.id != null) {
            if (user.id! > 0) {
              var token = await getBearerTokenValue();
              if (token != null)
                await mClient.addNotification(token, notificationBody);
            }
          }
        }
      }

      notificationsController.sink.add(notificationBody);
    });


    FirebaseMessaging.instance.getToken().then((firebaseToken) async {
      if (firebaseToken != null) {
        print("firebase token: "+firebaseToken);
        await setFTokenValue(firebaseToken);
        User user = await getCurrentUserValue();
        if (user != null) {
          if (user.id != null) {
            if (user.id! > 0) {
              var token = await getBearerTokenValue();
              await setFTokenValue(firebaseToken);
              if (token != null)
                print(await mClient.updateFirebaseToken(token, UpdateFirebaseTokenBody(firebaseToken: firebaseToken)));
            }
          }
        }
      }
    });

    await FirebaseMessaging.instance.getAPNSToken().then((x){
      print("apns token: ${x}");
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((firebaseToken) async {
      if (firebaseToken != null) {
        print("firebase token: "+firebaseToken);
        await setFTokenValue(firebaseToken);
        User user = await getCurrentUserValue();
        if (user != null) {
            if (user.id != null) {
              if (user.id! > 0) {
                  var token = await getBearerTokenValue();
                  await setFTokenValue(firebaseToken);
                  if (token != null)
                    print(await mClient.updateFirebaseToken(token, UpdateFirebaseTokenBody(firebaseToken: firebaseToken)));

              }
            }
          }
      }
    });

  }
}