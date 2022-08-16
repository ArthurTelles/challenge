import 'package:challenge/pages/how_to_paint_page.dart';
import 'package:flutter/material.dart';

class PaintActionButtons extends StatelessWidget {
  const PaintActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          child: GestureDetector(
            onTap: () {
              debugPrint('How to paint');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HowToPaint();
                  },
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: const Text(
                'Como pintar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          child: GestureDetector(
            onTap: () {
              debugPrint('Ask questions');
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(4, 0, 0, 0),
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: const Text(
                'Tirar dúvidas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
