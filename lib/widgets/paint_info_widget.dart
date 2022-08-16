import 'package:challenge/dio/dio_client.dart';
import 'package:challenge/dio/response_classes.dart';
import 'package:challenge/widgets/paint_action_buttons_widget.dart';
import 'package:challenge/widgets/paint_differentials_widget.dart';
import 'package:challenge/widgets/paint_image_carousel_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PaintInfo extends StatefulWidget {
  const PaintInfo({
    Key? key,
    required this.paintId,
    required this.paintName,
  }) : super(key: key);

  final String paintId;
  final String paintName;

  @override
  State<PaintInfo> createState() => _PaintInfoState();
}

class _PaintInfoState extends State<PaintInfo> {
  bool loading = true;
  PaintDifferentials paintDifferentialsResponse = PaintDifferentials();
  List<PaintDifferential> paintDifferentials = [];
  PaintImages paintImagesResponse = PaintImages();
  List<PaintImage> paintImages = [];
  int paintImageIndex = 0;
  DioClient dio = DioClient();

  @override
  void initState() {
    getPaintDifferential();
    super.initState();
  }

  Future getPaintDifferential() async {
    List<Response> responses;
    try {
      String endpointImages =
          'https://62968cc557b625860610144c.mockapi.io/paint/${widget.paintId}/image';
      String endpointDifferentials =
          'https://62968cc557b625860610144c.mockapi.io/paint/${widget.paintId}/differential';
      responses = await Future.wait([
        dio.getRequest(endpointImages),
        dio.getRequest(endpointDifferentials),
      ]);
      setState(() {
        final responseImages = {'items': responses[0].data};
        paintImagesResponse = PaintImages.fromJson(responseImages);
        paintImages = paintImagesResponse.images!;

        final responseDifferentials = {'items': responses[1].data};
        paintDifferentialsResponse =
            PaintDifferentials.fromJson(responseDifferentials);
        paintDifferentials = paintDifferentialsResponse.differentials!;
      });
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                child: Column(
                  children: [
                    Text(
                      widget.paintName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 14, 0, 18),
                      child: PaintImageCarousel(
                        paintImage:
                            '${paintImages[paintImageIndex].image}?random=$paintImageIndex', //This was added to select multiple random images to give the impression of multiple items
                        indexUpdate: ((newIndex) {
                          int indexUpdated = paintImageIndex + newIndex;
                          if (indexUpdated >= 0 &&
                              indexUpdated < paintImages.length) {
                            setState(() => paintImageIndex += newIndex);
                          }
                        }),
                      ),
                    ),
                    const PaintActionButtons(),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                      child: PaintDifferentialsWidget(
                        differentials: paintDifferentials,
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        debugPrint('Add to cart');
                      }),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 26, 0, 26),
                        padding: const EdgeInsets.fromLTRB(53, 17, 53, 17),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Color(0xFF5B4DA7),
                        ),
                        child: const Text(
                          'Adicionar ao carrinho',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
