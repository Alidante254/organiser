import 'package:Organiser/firebase_options.dart';
import 'package:Organiser/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'widgets/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Enable Firestore offline persistence
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );

 runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: OrganiserApp(),
    ),
  );
}

class OrganiserApp extends StatefulWidget {
  const OrganiserApp({Key? key}) : super(key: key);

  @override
  State<OrganiserApp> createState() => _OrganiserAppState();
}

class _OrganiserAppState extends State<OrganiserApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    var colorPrimary = Colors.blueGrey;

    var myColor = ThemeData(
      primarySwatch: colorPrimary,
    ).secondaryHeaderColor;
    var textColor = ThemeData(
      primarySwatch: colorPrimary,
    ).primaryColor;

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: colorPrimary,
          appBarTheme: AppBarTheme(
            backgroundColor: myColor,
            foregroundColor: textColor,
            elevation: 1,
          ),
          expansionTileTheme: ExpansionTileThemeData(
            shape: Border.all(color: Colors.transparent, width: 0),
            collapsedShape: Border.all(color: Colors.transparent, width: 0),
            childrenPadding: EdgeInsets.all(20)
            )
          ),
          
      home: SplashScreen(
        onSelectThemeColor: () {},
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
