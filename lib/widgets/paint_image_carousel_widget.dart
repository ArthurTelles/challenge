import 'package:flutter/material.dart';

typedef Callback = void Function(int newIndex);

class PaintImageCarousel extends StatefulWidget {
  const PaintImageCarousel({
    Key? key,
    required this.paintImage,
    required this.indexUpdate,
  }) : super(key: key);

  final String paintImage;
  final Callback indexUpdate;

  @override
  State<PaintImageCarousel> createState() => _PaintImageCarouselState();
}

class _PaintImageCarouselState extends State<PaintImageCarousel> {
  bool runningAnimation = false;
  void callNewImage(updateValue) {
    setState(() => runningAnimation = true);
    Future.delayed(const Duration(milliseconds: 250), () {
      widget.indexUpdate(updateValue);
      setState(() => runningAnimation = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 218,
          width: 19,
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(
                top: BorderSide(color: Color(0x40404026)),
                bottom: BorderSide(color: Color(0x40404026)),
                right: BorderSide(color: Color(0x40404026)),
                left: BorderSide(color: Colors.white)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const SizedBox.shrink(),
        ),
        Container(
          height: 218,
          width: 328,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  debugPrint('Previous image');
                  callNewImage(-1);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Color.fromARGB(51, 0, 0, 0),
                  size: 40,
                ),
              ),
              AnimatedOpacity(
                opacity: runningAnimation ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 250),
                child: Image.network(
                  widget.paintImage,
                  width: 166,
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('Next image');
                  callNewImage(1);
                },
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color.fromARGB(51, 0, 0, 0),
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 218,
          width: 19,
          decoration: BoxDecoration(
            color: Colors.white,
            border: const Border(
                top: BorderSide(color: Color(0x40404026)),
                bottom: BorderSide(color: Color(0x40404026)),
                left: BorderSide(color: Color(0x40404026)),
                right: BorderSide(color: Colors.white)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// class PaintImageCarousel extends StatelessWidget {
//   const PaintImageCarousel({
//     Key? key,
//     required this.paintImage,
//     required this.indexUpdate,
//   }) : super(key: key);

//   final String paintImage;
//   final Callback indexUpdate;

//   @override
//   Widget build(BuildContext context) {
//     bool runningAnimation = false;
//     void callNewImage() {
//       runningAnimation = true;
//       Future.delayed(const Duration(milliseconds: 500), () {
//         runningAnimation = false;
//       });
//     }

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           height: 218,
//           width: 19,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: const Border(
//                 top: BorderSide(color: Color(0x40404026)),
//                 bottom: BorderSide(color: Color(0x40404026)),
//                 right: BorderSide(color: Color(0x40404026)),
//                 left: BorderSide(color: Colors.white)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 1,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           child: const SizedBox.shrink(),
//         ),
//         Container(
//           height: 218,
//           width: 328,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: const Color(0x40404026)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 1,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   debugPrint('Previous image');
//                   callNewImage();
//                   indexUpdate(-1);
//                 },
//                 child: const Icon(
//                   Icons.arrow_back_rounded,
//                   color: Color.fromARGB(51, 0, 0, 0),
//                   size: 40,
//                 ),
//               ),
//               AnimatedOpacity(
//                 opacity: runningAnimation ? 0.0 : 1.0,
//                 duration: const Duration(milliseconds: 500),
//                 child: Image.network(
//                   paintImage,
//                   width: 166,
//                   loadingBuilder: (BuildContext context, Widget child,
//                       ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                                 loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               // Image.network(
//               //   paintImage,
//               //   width: 166,
//               //   loadingBuilder: (BuildContext context, Widget child,
//               //       ImageChunkEvent? loadingProgress) {
//               //     if (loadingProgress == null) return child;
//               //     return Center(
//               //       child: CircularProgressIndicator(
//               //         value: loadingProgress.expectedTotalBytes != null
//               //             ? loadingProgress.cumulativeBytesLoaded /
//               //                 loadingProgress.expectedTotalBytes!
//               //             : null,
//               //       ),
//               //     );
//               //   },
//               // ),
//               GestureDetector(
//                 onTap: () {
//                   debugPrint('Next image');
//                   callNewImage();
//                   indexUpdate(1);
//                 },
//                 child: const Icon(
//                   Icons.arrow_forward_rounded,
//                   color: Color.fromARGB(51, 0, 0, 0),
//                   size: 40,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 218,
//           width: 19,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: const Border(
//                 top: BorderSide(color: Color(0x40404026)),
//                 bottom: BorderSide(color: Color(0x40404026)),
//                 left: BorderSide(color: Color(0x40404026)),
//                 right: BorderSide(color: Colors.white)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 1,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           child: const SizedBox.shrink(),
//         ),
//       ],
//     );
//   }
// }
