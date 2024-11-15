import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project_push/main.dart';

class FirebaseApi {
  //create an instance of Firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifications
  Future<void> initNotifications() async {
    //request permission from user(will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token (normally you would send this to your server)
    print('Token: $fCMToken');

    //initialize further settings for push notifications
    initPushNotifications();
  }

  //function to handle received messages
  void handleMessage(RemoteMessage? message) {
    //if message is null, do nothing
    if (message == null) {
      return;
    }
    //navigate to new screeen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  //function to initialize foreground and background settings
  Future initPushNotifications() async {
    //handle notifications if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach eventlisteners for when a notification open the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
