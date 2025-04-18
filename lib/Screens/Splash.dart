import 'dart:async';

import 'package:demo15/Home.dart';
import 'package:demo15/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future getUser() async {
        //   Using Shared Prefrenes
        SharedPreferences userCredential = await SharedPreferences.getInstance();
        var userEmail = userCredential.getString('email');
        debugPrint('user Email: $userEmail');
        return userEmail;
  }

  @override
  void initState() {

    getUser().then((value) => {
      if(value != null){
         // Mean  3_Second
         Timer(const Duration(milliseconds: 3000), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home() ));
         })
      }else{
         // Mean  3_Second
         Timer(const Duration(milliseconds: 3000), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen() ));
         })
      }
    });
    super.initState();

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.purple,
                   height: MediaQuery.of(context).size.height * 0.99,
                    width: MediaQuery.of(context).size.width * 0.99,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Lottie.asset(
                          'assets/animation/shopping.json',
                          repeat: true,
                          reverse: true
                        ),
                        Text('E-Commerce',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}