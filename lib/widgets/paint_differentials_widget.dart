import 'package:flutter/material.dart';

class PaintDifferentialsWidget extends StatelessWidget {
  const PaintDifferentialsWidget({
    Key? key,
    required this.differentials,
  }) : super(key: key);

  final List<dynamic> differentials;

  //Function returns the image name based on the differential
  String getDifferentialImage(differentialName) {
    switch (differentialName) {
      case 'Ergonomic':
        return 'brush';
      case 'Tasty':
        return 'smell';
      case 'Handcrafted':
        return 'paint_bucket';
      default:
        return 'stars';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 198,
      width: 328,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0x40404026)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Diferenciais',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (var differential in differentials)
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Image.asset(
                          'assets/icons/${getDifferentialImage(differential.name)}.png',
                          width: 20,
                        ),
                      ),
                      Text(
                        '${differential.name}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
