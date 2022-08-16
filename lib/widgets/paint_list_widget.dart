import 'package:challenge/dio/dio_client.dart';
import 'package:challenge/widgets/paint_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:challenge/dio/response_classes.dart';

typedef CallbackSelected = void Function(List<Paint> paints, int index);
typedef CallbackCont = void Function(int count);

class PaintsList extends StatefulWidget {
  const PaintsList({
    Key? key,
    required this.searchInput,
    required this.deliveryFreeSwitchInput,
    required this.callbackCount,
    required this.callbackSelected,
  }) : super(key: key);

  final String searchInput;
  final bool deliveryFreeSwitchInput;
  final CallbackSelected callbackSelected;
  final CallbackCont callbackCount;

  @override
  State<PaintsList> createState() => _PaintsListState();
}

class _PaintsListState extends State<PaintsList> {
  int paintsPage = 1;
  bool loading = true;
  String search = '';
  Paints paintsResponse = Paints();
  List<Paint> paints = [];
  List<Paint> paintsDeliveryFree = [];
  DioClient dio = DioClient();

  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(PaintsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchInput != oldWidget.searchInput) {
      search = widget.searchInput;
      getPaints();
    }
  }

  @override
  void initState() {
    search = widget.searchInput;
    getPaints();
    _scrollController.addListener(() {
      if (!loading &&
          search.isEmpty &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent) {
        setState(() {
          paintsPage += 1;
          loading = true;
        });
        getPaints();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  List<Paint> getPaintsArray() {
    return widget.deliveryFreeSwitchInput ? paintsDeliveryFree : paints;
  }

  Future getPaints() async {
    Response response;
    try {
      String endpoint = 'paint?page=$paintsPage&limit=20';
      if (search != '') {
        paintsPage = 1;
        endpoint = 'paint?page=1&limit=100&search=$search';
      }
      response = await dio.getRequest(endpoint);
      if (response.statusCode == 200) {
        setState(() {
          final res = {'items': response.data};
          paintsResponse = Paints.fromJson(res);

          if (search != '') {
            paints = paintsResponse.paints!;
          } else {
            paints.addAll(paintsResponse.paints!);
            List<Paint> uniquePaints = [];
            for (var paint in paints.reversed) {
              final paintRepeated = uniquePaints
                  .indexWhere((uniquePaint) => uniquePaint.id == paint.id);
              if (paintRepeated == -1) {
                uniquePaints.add(paint);
              }
            }
            paints = uniquePaints;
            paintsDeliveryFree =
                paints.where((paint) => paint.deliveryFree == true).toList();
          }
        });
        widget.callbackCount(getPaintsArray().length);
      } else {
        debugPrint('Response error ${response.statusCode}');
      }
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
          : paints.isEmpty
              ? Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: const Text(
                    'Nenhum item foi encontrado.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: getPaintsArray().length,
                  itemBuilder: ((context, index) {
                    final paint = getPaintsArray()[index];
                    return PaintWidget(
                      paint: paint,
                      index: index,
                      callback: (value, index) {
                        debugPrint('paint selected ${value.name}, $index');
                        widget.callbackSelected(getPaintsArray(), index);
                      },
                    );
                  }),
                ),
    );
  }
}
