import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:login/loginmodular.dart';
import 'package:untitled1/service/notification_service.dart';
import 'dashboard/dashboard.dart';
import 'dashboard/message_screen.dart';
import 'firebase_options.dart';
import 'login/forget_password_screen.dart';
import 'login/signup2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);

  runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackground(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("prem----- "+message.notification!.title.toString());
  print("prem----- "+message.notification!.body.toString());
  print("prem----- "+message.data!.toString());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationService notificationService=NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.getDeviceToken().then((value){
      print("Token: $value");
    });
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    //notificationService.initLocalNotification(context);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => LoginApp2(),
        '/signup': (context) => SignUpScreen(),
        '/forgot': (context) => ForgetPasswordScreen(),
        '/dashboard': (context) => Dashboard(),
        '/notification': (context) => MessageScreen(id: ModalRoute.of(context)!.settings.arguments as String), // Pass the ID
      },
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Image.asset("assets/boy.png")),
    );
  }
}
*/
