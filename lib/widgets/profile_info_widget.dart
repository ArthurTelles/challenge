import 'package:challenge/repositories/dio_repository.dart';
import 'package:challenge/datasources/responses_datasources.dart';
import 'package:challenge/pages/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool loading = true;
  ProfileInfoRequest profileInfoRequest = ProfileInfoRequest();
  DioRepository dio = DioRepository();

  @override
  void initState() {
    getProfileInfo();
    super.initState();
  }

  Future getProfileInfo() async {
    Response response;
    try {
      String endpoint = 'profile';
      response = await dio.getRequest(endpoint);
      if (response.statusCode == 200) {
        setState(() {
          profileInfoRequest = ProfileInfoRequest.fromJson(response.data);
        });
      } else {
        debugPrint('Response error ${response.statusCode}');
      }
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    loading = false;
  }

  Future logoutUser() async {
    Response response;
    try {
      String endpoint = 'logout';
      response = await dio.getRequest(endpoint);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        sendUserToLogin();
      } else {
        debugPrint('Response error ${response.statusCode}');
      }
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    loading = false;
  }

  void sendUserToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) =>
            const LoginPage()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: const Color(0x40404026)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            NetworkImage('${profileInfoRequest.avatar}'),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                        child: Text(
                          '${profileInfoRequest.name}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    debugPrint('Logout');
                    setState(() => loading = true);
                    logoutUser();
                  }),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 23, 30, 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: const Color(0x40404026)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Fazer logout',
                          style: TextStyle(
                            color: Color(0xFF5B4DA7),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
