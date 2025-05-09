import 'package:demo15/AdminScreens/Fetch_Data_Screen.dart';
import 'package:demo15/AdminScreens/createData.dart';
import 'package:demo15/Home.dart';
import 'package:demo15/Screens/Signup.dart';
import 'package:demo15/Screens/Splash.dart';
import 'package:demo15/Screens/chatScreen.dart';
import 'package:demo15/Screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyDisMRDdTt5sQfhv2BzUKtTF3zVLVsRm_k",
      authDomain: "citiguid-8c345.firebaseapp.com",
      projectId: "citiguid-8c345",
      storageBucket: "citiguid-8c345.appspot.com",
      messagingSenderId: "706675914030",
      appId: "1:706675914030:web:6363f83f355fc348dd76bf",
      measurementId: "G-JDLWPEV0YQ"
      )
    );
  }else{
     await Firebase.initializeApp();
  }
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home(),
    );
  }
}
