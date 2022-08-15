import 'package:challenge/widgets/paint_list_widget.dart';
import 'package:flutter/material.dart';

class PaintsPage extends StatefulWidget {
  const PaintsPage({super.key});

  @override
  State<PaintsPage> createState() => _PaintsPageState();
}

class _PaintsPageState extends State<PaintsPage> {
  String searchInput = '';
  int paintsCount = 0;
  bool loading = true;
  bool deliveryFreeSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 44, 0, 24),
            child: const Text(
              'Opções de tintas',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextFormField(
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(102, 255, 255, 255),
                hintText: 'Buscar...',
                contentPadding: EdgeInsets.all(16.0),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide:
                      BorderSide(color: Color.fromARGB(1, 164, 164, 164)),
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() => searchInput = value);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 0, 24, 0),
            child: Row(
              children: [
                Switch(
                  activeColor: const Color(0xFF5B4DA7),
                  value: deliveryFreeSwitch,
                  onChanged: (newValue) {
                    setState(() => deliveryFreeSwitch = newValue);
                  },
                ),
                const Text.rich(
                  TextSpan(
                    text: 'Apenas ',
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'entrega grátis',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '$paintsCount resultados',
                  style: const TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          PaintsList(
            searchInput: searchInput,
            deliveryFreeSwitchInput: deliveryFreeSwitch,
            callback: ((value, index) {
              debugPrint('Selected paint ${value.name} of index $index');
            }),
            callbackCount: ((count) {
              setState(() {
                paintsCount = count;
              });
            }),
          ),
          Container(
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
                  },
                  child: Column(
                    children: const [
                      Icon(
                        color: Color(0xFF5B4DA7),
                        size: 35,
                        Icons.storefront_outlined,
                      ),
                      Text(
                        'Loja',
                        style: TextStyle(
                          color: Color(0xFF5B4DA7),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('tap cart');
                  },
                  child: Column(
                    children: const [
                      Icon(
                        color: Colors.grey,
                        size: 35,
                        Icons.shopping_cart_outlined,
                      ),
                      Text(
                        'Carrinho',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('tap profile');
                  },
                  child: Column(
                    children: const [
                      Icon(
                        color: Colors.grey,
                        size: 35,
                        Icons.person_outline_rounded,
                      ),
                      Text(
                        'Perfil',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
