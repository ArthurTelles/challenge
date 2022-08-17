import 'package:flutter/material.dart';

typedef Callback = void Function(String searchValue, bool switchValue);

class PaintSearchBar extends StatefulWidget {
  const PaintSearchBar({
    Key? key,
    required this.paintsCount,
    required this.hasPaintSelected,
    required this.inputUpdated,
  }) : super(key: key);

  final int paintsCount;
  final bool hasPaintSelected;
  final Callback inputUpdated;

  @override
  State<PaintSearchBar> createState() => _PaintSearchBarState();
}

class _PaintSearchBarState extends State<PaintSearchBar> {
  String searchInput = '';
  bool deliveryFreeSwitch = false;

  //Function emits a callback with the latest info of the search input
  void emitUpdate() {
    widget.inputUpdated(searchInput, deliveryFreeSwitch);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                borderSide: BorderSide(color: Color.fromARGB(1, 164, 164, 164)),
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
            onChanged: (value) {
              setState(() {
                searchInput = value;
                emitUpdate();
              });
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
                  setState(() {
                    deliveryFreeSwitch = newValue;
                    emitUpdate();
                  });
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
                '${widget.paintsCount} resultados',
                style: const TextStyle(
                  color: Color(0xFF707070),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
