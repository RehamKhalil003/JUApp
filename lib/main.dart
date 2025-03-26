import 'package:flutter/material.dart';
import 'sign_in.dart'; // Ensure this matches the actual file name
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
   OneSignal.initialize("d0bccd92-112f-4aa7-812c-140c3717cdba");
  await OneSignal.Notifications.requestPermission(true);

  // Now run the app
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
      home: const SignInPage(), // Set SignInPage as the initial screen
    );
  }
}


