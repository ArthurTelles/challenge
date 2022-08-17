import 'package:flutter/material.dart';

typedef Callback = void Function(int selection);

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    Key? key,
    required this.onTap,
    required this.currentPage,
  }) : super(key: key);

  final Callback onTap;
  final int currentPage;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentSelection = 0;

  void emitUpdate() {
    widget.onTap(currentSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 13, 13, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              debugPrint('tap store');
              setState(() {
                currentSelection = 0;
                emitUpdate();
              });
            },
            child: Column(
              children: [
                Icon(
                  Icons.storefront_outlined,
                  size: 35,
                  color: currentSelection == 0
                      ? const Color(0xFF5B4DA7)
                      : Colors.grey,
                ),
                Text(
                  'Loja',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: currentSelection == 0
                        ? const Color(0xFF5B4DA7)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('tap cart');
              setState(() {
                currentSelection = 1;
                emitUpdate();
              });
            },
            child: Column(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 35,
                  color: currentSelection == 1
                      ? const Color(0xFF5B4DA7)
                      : Colors.grey,
                ),
                Text(
                  'Carrinho',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: currentSelection == 1
                        ? const Color(0xFF5B4DA7)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              debugPrint('tap profile');
              setState(() {
                currentSelection = 2;
                emitUpdate();
              });
            },
            child: Column(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 35,
                  color: currentSelection == 2
                      ? const Color(0xFF5B4DA7)
                      : Colors.grey,
                ),
                Text(
                  'Perfil',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: currentSelection == 2
                        ? const Color(0xFF5B4DA7)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
