import 'package:flutter/material.dart';
import 'package:flutter_application_1/utlis/global.color.dart';
import 'package:flutter_application_1/view/widgets/custom.clipper.dart';
import 'package:flutter_application_1/view/widgets/text.form.global.dart';
import 'dart:math';

import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                    SizedBox(height: height * .2),
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
                      'Créez un nouveau compte',
                      style: TextStyle(
                        color: GlobalColor.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormGlobal(
                      controller: firstNameController,
                      text: 'Prénom',
                      obscure: false,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormGlobal(
                      controller: lastNameController,
                      text: 'Nom',
                      obscure: false,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormGlobal(
                      controller: emailController,
                      text: 'Email',
                      obscure: false,
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextFormGlobal(
                      controller: passwordController,
                      text: 'Mot de passe',
                      obscure: true,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 20),
                    TextFormGlobal(
                      controller: confirmPasswordController,
                      text: 'Confirmez le mot de passe',
                      obscure: true,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        // Logique d'inscription
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: 370,
                        decoration: BoxDecoration(
                          color: GlobalColor.mainColor,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Inscrire',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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
            Text('Vous avez déjà un compte ?'),
            InkWell(
              child: Text(
                ' Connectez-vous',
                style: TextStyle(
                  color: GlobalColor.mainColor,
                ),
              ),
              onTap: () {
                // Naviguer vers la page de connexion
                Get.toNamed('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
