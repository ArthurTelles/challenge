import 'dart:convert';

import 'package:challenge/dio/dio_client.dart';
import 'package:challenge/dio/response_classes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PaintCart extends StatefulWidget {
  const PaintCart({super.key});

  @override
  State<PaintCart> createState() => _PaintCartState();
}

class _PaintCartState extends State<PaintCart> {
  bool loading = true;
  CartInfoRequest cartInfoRequest = CartInfoRequest();
  CartInfo cartItemUpdated = CartInfo();
  List<CartInfo> cartInfos = [];
  DioClient dio = DioClient();

  @override
  void initState() {
    getCartInfo();
    super.initState();
  }

  Future getCartInfo() async {
    Response response;
    try {
      response = await dio.getRequest('cart');
      final res = {'items': response.data};
      cartInfoRequest = CartInfoRequest.fromJson(res);
      cartInfos = cartInfoRequest.items!;
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    setState(() => loading = false);
  }

  Future updateCartItem(String paintId, String quantity) async {
    Response response;
    try {
      var newQuantity = int.parse(quantity);
      final body = {'quantity': newQuantity};
      response = await dio.putRequest('cart/$paintId', jsonEncode(body));
      cartItemUpdated = CartInfo.fromJson(response.data);
      var index =
          cartInfos.indexWhere((cartInfo) => cartInfo.id == cartItemUpdated.id);
      setState(() => cartInfos[index] = cartItemUpdated);
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    setState(() => loading = false);
  }

  Future clearCart() async {
    try {
      for (var cartInfo in cartInfos) {
        await dio.deleteRequest('cart/${cartInfo.id}');
      }
      setState(() => cartInfos = []);
    } on Exception catch (error) {
      debugPrint('error $error');
    }
    setState(() => loading = false);
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (var index = 1; index <= 10; index++) {
      items.add(DropdownMenuItem<String>(
        value: '$index',
        child: Text('$index un.'),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : cartInfos.isEmpty
              ? const Text(
                  'Seu carrinho está vazio',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : ListView.builder(
                  itemCount: cartInfos.length,
                  itemBuilder: ((context, index) {
                    final paintInfo = cartInfos[index];
                    var paintQuantity = '${paintInfo.quantity}';
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.fromLTRB(30, 6, 30, 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0x40404026)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                                child: Image.network(
                                  '${paintInfo.paint?.coverImage}?random=${paintInfo.id}', //This was added to select multiple random images to give the impression of multiple items
                                  width: 51,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${paintInfo.paint?.name}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    // This value comes from the margins, paddings, borders and the coverImage
                                    width:
                                        MediaQuery.of(context).size.width - 169,
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                    height: 1.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 169,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        DropdownButton(
                                          items: getDropDownItems(),
                                          value: paintQuantity,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          onChanged: (String? value) {
                                            debugPrint(
                                                'Change paint value $value of paint ${paintInfo.id}');
                                            setState(() => loading = true);
                                            updateCartItem(
                                                paintInfo.id!, value!);
                                          },
                                        ),
                                        Text(
                                          'R\$ ${paintInfo.paint?.price}'
                                              .replaceFirst(RegExp('\\.'), ','),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (index == cartInfos.length - 1)
                          GestureDetector(
                            onTap: (() {
                              debugPrint('Clear cart');
                              setState(() => loading = true);
                              clearCart();
                            }),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 26, 0, 26),
                              padding:
                                  const EdgeInsets.fromLTRB(53, 17, 53, 17),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Color(0xFF5B4DA7),
                              ),
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Confirmar compra',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          )
                      ],
                    );
                  }),
                ),
    );
  }
}
