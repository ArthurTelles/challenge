import 'package:challenge/datasources/sign_classes.dart';
import 'package:challenge/repositories/dio_repository.dart';
import 'package:challenge/datasources/responses_datasources.dart';
import 'package:challenge/pages/paints_page.dart';
import 'package:challenge/pages/register_page.dart';
import 'package:challenge/widgets/custom_form_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  String accessToken = '';
  LoginData loginData = LoginData('', '');

  DioRepository dio = DioRepository();
  UserLogin userLogin = UserLogin();

  //Function makes a GET request to login the user and save the access token provided
  Future loginUser() async {
    Response response;
    try {
      response = await dio.getRequest('login');
      if (response.statusCode == 200) {
        await LoginData.init();
        setState(() {
          userLogin = UserLogin.fromJson(response.data);
          accessToken = userLogin.accessToken!;
          LoginData.setAccessToken(accessToken);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const PaintsPage();
              },
            ),
          );
        });
      } else {
        debugPrint('Response error ${response.statusCode}');
      }
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    loading = false;
  }

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
                isPassWord: false,
                callback: ((value) => loginData.email = value.input),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 21, 0, 0),
              child: CustomFormWidget(
                label: 'Password',
                isPassWord: true,
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
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF5B4DA7),
                          fontSize: 16,
                        ),
                      ),
                onPressed: () {
                  if (loginData.email.isEmpty || loginData.password.isEmpty) {
                    const snackBar = SnackBar(
                      content:
                          Text('Email ou Password inválido, tente novamente.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    debugPrint("login");
                    setState(() => loading = true);
                    loginUser();
                  }
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const RegisterPage();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
