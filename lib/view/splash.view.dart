import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utlis/global.color.dart';
import 'package:flutter_application_1/view/login.view.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColor.mainColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffE6E6E6),
                Color.fromARGB(197, 194, 5, 5),
              ],
            ),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(78, 248, 179, 179).withOpacity(0.1),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Image.asset(
                'images/tel.png', // Remplacez par le chemin de votre image
                width: 250, // Vous pouvez ajuster la taille selon vos besoins
                height: 250,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
