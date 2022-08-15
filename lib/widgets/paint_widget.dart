import 'package:flutter/material.dart';
import 'package:challenge/dio/response_classes.dart';

typedef Callback = void Function(Paint value, int index);

class PaintWidget extends StatelessWidget {
  const PaintWidget({
    Key? key,
    required this.index,
    required this.paint,
    required this.callback,
  }) : super(key: key);

  final int index;
  final Paint paint;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(paint, index);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0x40404026)),
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Image.network(
                '${paint.coverImage!}?random=$index', //This was added to select multiple random images to give the impression of multiple itens
                width: 51,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paint.name!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'R\$ ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: paint.price!
                                      .replaceFirst(RegExp('\\.'), ','),
                                  style: const TextStyle(
                                    fontSize: 22,
                                  )),
                              // can add more TextSpans here...
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          child: paint.deliveryFree! == false
                              ? null
                              : Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xFF5B4DA7)),
                                  ),
                                  child: const Text(
                                    'Entrega grátis',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF707070),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class Frog extends StatelessWidget {
//   const Frog({
//     Key? key,
//     this.color = const Color(0xFF2DBD3A),
//     this.child,
//   }) : super(key: key);

//   final Color color;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(color: color, child: child);
//   }
// }