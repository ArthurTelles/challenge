import 'package:flutter/material.dart';

class PaintInfo extends StatefulWidget {
  const PaintInfo({super.key});

  @override
  State<PaintInfo> createState() => _PaintInfoState();
}

class _PaintInfoState extends State<PaintInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Informações da tinta'),
        ],
      ),
    );
  }
}
