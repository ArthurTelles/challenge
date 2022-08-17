import 'package:flutter/material.dart';

typedef Callback = void Function();

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.text,
    required this.loading,
    required this.onTap,
  }) : super(key: key);

  final bool loading;
  final String text;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        debugPrint('Clear cart');
        onTap();
      }),
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 26, 0, 26),
        padding: const EdgeInsets.fromLTRB(53, 17, 53, 17),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Color(0xFF5B4DA7),
        ),
        child: loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
