import 'package:flutter/material.dart';
import 'package:flutter_application_1/utlis/global.color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ButtonGlobal extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const ButtonGlobal({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  Future<Map<String, dynamic>> loginPost(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('L\'email ou le mot de passe ne peuvent pas être vides.');
    }

    final response = await http.post(
      Uri.parse('https://app.quermes.net/api/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 403) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Vérifiez votre email ou mot de passe!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        String email = emailController.text;
        String password = passwordController.text;
        try {
          Map<String, dynamic> userInfo = await loginPost(email, password);
          print('Connexion réussie : $userInfo'); // Log de succès
          Get.offAllNamed('/dashboard');
        } catch (e) {
          print('message : $e'); // Log d'erreur
          Get.snackbar(
            'Erreur',
            'Vérifiez votre email ou mot de passe!',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
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
            )
          ],
        ),
        child: const Text('Connecter',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
