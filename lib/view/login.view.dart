import 'package:flutter/material.dart';
import 'package:flutter_application_1/utlis/global.color.dart';
import 'package:flutter_application_1/view/widgets/button.global.dart';
import 'package:flutter_application_1/view/widgets/custom.clipper.dart';
import 'package:flutter_application_1/view/widgets/text.form.global.dart';
import 'package:get/get.dart';
import 'dart:math';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(
                child: Transform.rotate(
                  angle: -pi / 3.5,
                  child: ClipPath(
                    clipper: ClipPainter(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffE6E6E6),
                            Color.fromARGB(197, 194, 5, 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .3),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Quer',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(197, 194, 5, 5),
                          ),
                          children: [
                            TextSpan(
                              text: 'mes',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Connectez-vous à votre compte',
                      style: TextStyle(
                        color: GlobalColor.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormGlobal(
                      controller: emailController,
                      text: 'Email',
                      obscure: false,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextFormGlobal(
                      controller: passwordController,
                      text: 'Password',
                      obscure: true,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    ButtonGlobal(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tu n\'as pas de compte ?'),
            InkWell(
              child: Text(
                ' Inscrivez-vous',
                style: TextStyle(
                  color: GlobalColor.mainColor,
                ),
              ),
              onTap: () {
                // Naviguer vers la page d'inscription
                Get.toNamed('/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
