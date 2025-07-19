import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:login/loginmodular.dart';
import 'package:untitled1/service/notification_service.dart';
import 'apifunction/tabs/custom_tabs.dart';
import 'bottom_navigation_bar_pages/custom_bottomnavigation_bar.dart';
import 'dashboard/dashboard.dart';
import 'dashboard/documents_upload.dart';
import 'dashboard/file_download.dart';
import 'dashboard/home_page_screen.dart';
import 'dashboard/message_screen.dart';
import 'dashboard/user_screen.dart';
import 'dashboard/web_view_page.dart';
import 'firebase_options.dart';
import 'login/forget_password_screen.dart';
import 'login/signup2.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackground);
  await initHiveForFlutter(); // Required for caching
  await requestStoragePermissions(); // Ask permission before app starts
  runApp(MyApp());
}

Future<void> requestStoragePermissions() async {
  if (Platform.isAndroid) {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    if (await Permission.videos.isDenied) {
      await Permission.videos.request();
    }

    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings(); // Optional fallback
    }
  }
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
       // '/FileDownloader': (context) => FileDownloader(),
        '/tab': (context) => CustomTabExample(),
        '/web': (context) => WebViewPage(),
       '/bottomnavigationbar': (context) => CustomBottomnavigationBar(),
        '/UploadFileScreen': (context) => UploadFileScreen(),
        '/userscreen': (context) => UserScreen(),
        '/notification': (context) => TicketDashboardScreen(),
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
