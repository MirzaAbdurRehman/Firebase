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
         apiKey: "AIzaSyDmHx7gsqi9ajMaO21CQRi-_EWKnbi1-kk",
         authDomain: "practice202306b.firebaseapp.com",
         projectId: "practice202306b",
         storageBucket: "practice202306b.firebasestorage.app",
         messagingSenderId: "83902894187",
         appId: "1:83902894187:web:1dcce42e72a36bb95c612e",
         measurementId: "G-DDW195W8L8"
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
      home: creaDataAdmin(),
    );
  }
}
