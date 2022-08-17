import 'dart:convert';

import 'package:challenge/repositories/dio_repository.dart';
import 'package:challenge/datasources/responses_datasources.dart';
import 'package:challenge/widgets/action_button_widget.dart';
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
  bool loadingCart = false;
  PaintDifferentials paintDifferentialsResponse = PaintDifferentials();
  List<PaintDifferential> paintDifferentials = [];
  PaintImages paintImagesResponse = PaintImages();
  List<PaintImage> paintImages = [];
  int paintImageIndex = 0;
  Paint paintInfo = Paint();
  CartInfoRequest cartInfoRequest = CartInfoRequest();
  List<CartInfo> cartInfos = [];
  DioRepository dio = DioRepository();

  //Initializes the page with the request of information
  @override
  void initState() {
    getPaintDifferential();
    super.initState();
  }

  //Function makes the request for the paint images and differentials
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

  //Function makes a POST or a PUT request in the user cart
  Future updateCart() async {
    Response paintResponse, cartResponse;
    try {
      //Get cart to check if paint is already added
      cartResponse = await dio.getRequest('cart');
      final res = {'items': cartResponse.data};
      cartInfoRequest = CartInfoRequest.fromJson(res);
      final hasPaint = cartInfoRequest.items!
          .where((cartInfo) => cartInfo.paint?.id == widget.paintId);

      //If the paint is not in the cart request it's full info and add it
      if (hasPaint.isEmpty) {
        paintResponse = await dio.getRequest('paint/${widget.paintId}');
        paintInfo = Paint.fromJson(paintResponse.data);
        if (paintResponse.statusCode == 200) {
          final body = {"quantity": 1, "paint": paintInfo};
          await dio.postRequest('cart', jsonEncode(body));
        } else {
          debugPrint('Response error ${paintResponse.statusCode}');
        }
      } else {
        //If the paint is already in the cart just update the quantity
        final body = {"quantity": (hasPaint.first.quantity! + 1)};
        await dio.putRequest('cart/${hasPaint.first.id}', jsonEncode(body));
      }
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    setState(() => loadingCart = false);
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
                    ActionButton(
                      loading: loadingCart,
                      text: 'Adicionar ao carrinho',
                      onTap: () {
                        setState(() {
                          debugPrint('Add to cart');
                          setState(() => loadingCart = true);
                          updateCart();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
