import 'package:challenge/pages/paints_page.dart';
import 'package:challenge/pages/login_page.dart';
import 'package:challenge/classes/sign_classes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoginData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF5B4DA7),
          background: const Color(0xFF5B4DA7),
        ),
      ),
      home: const RootPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [LoginPage(), PaintsPage()];
  @override
  Widget build(BuildContext context) {
    String? accessToken = LoginData.getAccessToken();
    debugPrint('accessToken $accessToken');
    if (accessToken != null) {
      debugPrint('Has login');
      setState(() => currentPage = 1);
    }
    return Scaffold(
      body: pages[currentPage],
    );
  }
}
