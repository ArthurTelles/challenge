import 'package:challenge/classes/classes.dart';
import 'package:challenge/widgets/custom_form_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginData = LoginData("", "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B4DA7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 57.26,
                  margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: Image.asset('assets/icons/bucket.png'),
                ),
                const Text(
                  'SóTintas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: const Text(
                'Entrar na plataforma',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: CustomFormWidget(
                label: 'Email',
                callback: ((value) => loginData.email = value.input),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 21, 0, 0),
              child: CustomFormWidget(
                label: 'Password',
                callback: ((value) => loginData.password = value.input),
              ),
            ),
            Container(
              width: 240,
              height: 48,
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF5B4DA7),
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  debugPrint("login");
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text(
                  'Criar conta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  debugPrint("register");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
