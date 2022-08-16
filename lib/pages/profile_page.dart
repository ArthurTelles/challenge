import 'package:challenge/widgets/paint_info_widget.dart';
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
  int selectedPaintIndex = -1;
  List<dynamic> currentPaints = [];

  bool hasPaintSelected() => selectedPaintIndex != -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Opções de tintas',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: hasPaintSelected()
            ? IconButton(
                onPressed: () {
                  setState(() => selectedPaintIndex = -1);
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
              )
            : null,
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          hasPaintSelected()
              ? const SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
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
          hasPaintSelected()
              ? const SizedBox.shrink()
              : Container(
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
          hasPaintSelected()
              ? PaintInfo(
                  paintId: currentPaints[selectedPaintIndex].id,
                  paintName: currentPaints[selectedPaintIndex].name,
                )
              : PaintsList(
                  searchInput: searchInput,
                  deliveryFreeSwitchInput: deliveryFreeSwitch,
                  callbackSelected: ((paints, index) {
                    debugPrint('Selected paint index: $index');
                    setState(() {
                      currentPaints = paints;
                      selectedPaintIndex = index;
                    });
                  }),
                  callbackCount: ((count) {
                    setState(() => paintsCount = count);
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
                    setState(() => selectedPaintIndex = -1);
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
