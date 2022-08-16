import 'package:flutter/material.dart';

class HowToPaint extends StatelessWidget {
  HowToPaint({super.key});

  final List<dynamic> howToPaintItems = [
    {
      'number': '1',
      'title': 'Prepare a tinta',
      'image': 'paint_bucket',
      'description': 'Abra a tinta e a coloque na caçamba',
    },
    {
      'number': '2',
      'title': 'Primeira demão',
      'image': 'brush',
      'description':
          'Aplique a tinta na parede em N como mostrado no vídeo para melhor aproveitamento',
      'icon': const Icon(
        Icons.arrow_downward_rounded,
        size: 60,
        color: Color(0xFFDADADA),
      ),
    },
    {
      'number': '3',
      'title': 'Repasse a tinta',
      'image': 'brush',
      'description':
          'Passe mais uma camada de tinta por cima da parede para reduzir imperfeições',
      'icon': Image.asset(
        'assets/icons/time.png',
        width: 40,
      ),
      'secondaryDescription': 'Aguarde 2 horas',
    },
    {
      'number': '5',
      'title': 'Segunda demão',
      'image': 'brush',
      'description':
          'Aplique a tinta na parede em N como mostrado no vídeo para melhor aproveitamento',
    },
    {
      'number': '6',
      'title': 'Repasse a tinta',
      'image': 'brush',
      'description':
          'Passe mais uma camada de tinta por cima da parede para reduzir imperfeições',
      'icon': Image.asset(
        'assets/icons/time.png',
        width: 40,
      ),
      'secondaryDescription': 'Aguarde 2 horas',
    },
    {
      'number': '7',
      'title': 'Acabou',
      'description': 'Sua parede está pronta',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Como pintar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
          child: Column(
            children: <Widget>[
              for (var item in howToPaintItems)
                Container(
                  width: 309,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: item['number'],
                              style: const TextStyle(
                                color: Color(0xFF5B4DA7),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '   ${item['title']}   ',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                          ),
                          item['image'] == null
                              ? const SizedBox.shrink()
                              : Image.asset(
                                  'assets/icons/${item['image']}.png',
                                  width: 24,
                                ),
                        ],
                      ),
                      Container(
                        width: 273,
                        margin: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                        child: Text(
                          item['description'],
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      item['icon'] == null
                          ? const SizedBox.shrink()
                          : Container(
                              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                              child: Column(
                                children: [
                                  item['icon'],
                                  item['secondaryDescription'] == null
                                      ? const SizedBox.shrink()
                                      : Text(
                                          item['secondaryDescription'],
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
