import 'dart:convert';
import 'package:challenge/classes/sign_classes.dart';
import 'package:challenge/dio/dio_client.dart';
import 'package:challenge/dio/response_classes.dart';
import 'package:challenge/pages/paints_page.dart';
import 'package:challenge/widgets/custom_form_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;
  var registerData = RegisterData('', '', '', '');

  bool validEntry() {
    return registerData.name != '' &&
        registerData.email != '' &&
        registerData.password != '' &&
        registerData.password == registerData.passwordConfirm;
  }

  DioClient dio = DioClient();
  UserRegister userRegister = UserRegister();

  Future registerUser() async {
    Response response;
    try {
      response = await dio.postRequest('user', jsonEncode(registerData));
      if (response.statusCode == 201) {
        await RegisterData.init();
        setState(() {
          userRegister = UserRegister.fromJson(response.data);
          RegisterData.setAccessToken();
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
      appBar: AppBar(
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xFF5B4DA7),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
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
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: const Text(
                  'Criar conta',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: CustomFormWidget(
                  label: 'Nome',
                  isPassWord: false,
                  callback: ((value) => registerData.name = value.input),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: CustomFormWidget(
                  label: 'Email',
                  isPassWord: false,
                  callback: ((value) => registerData.email = value.input),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: CustomFormWidget(
                  label: 'Senha',
                  isPassWord: true,
                  callback: ((value) => registerData.password = value.input),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: CustomFormWidget(
                  label: 'Confirmar Senha',
                  isPassWord: true,
                  callback: ((value) =>
                      registerData.passwordConfirm = value.input),
                ),
              ),
              Container(
                width: 240,
                height: 48,
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
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
                          'Criar conta',
                          style: TextStyle(
                            color: Color(0xFF5B4DA7),
                            fontSize: 16,
                          ),
                        ),
                  onPressed: () {
                    if (!validEntry()) {
                      const snackBar = SnackBar(
                        content: Text('Dados inválidos.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      debugPrint("login");
                      setState(() => loading = true);
                      registerUser();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
