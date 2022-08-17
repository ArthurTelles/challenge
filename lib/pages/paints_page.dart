import 'package:challenge/widgets/navigation_bar_widget.dart';
import 'package:challenge/widgets/paint_info_widget.dart';
import 'package:challenge/widgets/paint_list_widget.dart';
import 'package:challenge/widgets/paint_search_bar_widget.dart';
import 'package:challenge/widgets/profile_info_widget.dart';
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
  int currentPage = 0;

  bool showBackButton() => selectedPaintIndex != -1 && currentPage == 0;
  bool hasPaintSelected() => selectedPaintIndex != -1;
  String getPageTitle() {
    switch (currentPage) {
      case 0:
        return 'Opções de tintas';

      case 1:
        return 'Carrinho';

      case 2:
        return 'Perfil';

      default:
        return 'Opções de tintas';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          getPageTitle(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: showBackButton()
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
          if (currentPage == 2) const ProfileInfo(),
          if (currentPage == 0 && !hasPaintSelected())
            PaintSearchBar(
              paintsCount: paintsCount,
              hasPaintSelected: hasPaintSelected(),
              inputUpdated: (searchValue, switchValue) {
                setState(() {
                  searchInput = searchValue;
                  deliveryFreeSwitch = switchValue;
                });
              },
            ),
          if (currentPage == 0)
            currentPage == 0 && hasPaintSelected()
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
          CustomNavigationBar(
            onTap: (selection) {
              setState(() {
                currentPage = selection;
                if (selection == 0) selectedPaintIndex = -1;
              });
            },
            currentPage: currentPage,
          ),
        ],
      ),
    );
  }
}
