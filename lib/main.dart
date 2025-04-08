import 'package:flutter/material.dart';
import 'sign_in.dart'; // Make sure the file exists
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// os_v2_app_2c6m3eqrf5fkpajmcqgdof6nxliov3whl46uxzn3jcwxb43677qp4uq47exfo6qvyhskjrmy3iwzhml2qwd523luq2c4aa5uoviaf3i
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   // options: DefaultFirebaseOptions.currentPlatform,
  // );

  await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("f23e3c05-7911-4b35-a371-075f196c41fd");
  await OneSignal.Notifications.requestPermission(true);

  final deviceState = await OneSignal.User.pushSubscription.id;

  print("userId: ${deviceState}");
  print("userId: ${OneSignal.Notifications.permission}");
  // print("userId: ${OneSignal.Session.}");
  // print("isSubscribed: ${deviceState?.isSubscribed}");
  // print("hasNotificationPermission: ${deviceState?.hasNotificationPermission}");
  // print("pushToken: ${deviceState?.pushToken}");

  print(OneSignal.User.pushSubscription.id);

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My First Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(),
    );
  }
}
