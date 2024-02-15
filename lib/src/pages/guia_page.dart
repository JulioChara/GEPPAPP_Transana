import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/pages/detalle_page.dart';
import 'package:transana_app/src/pages/general_page.dart';

class GuiaPage extends StatefulWidget {
  @override
  _GuiaPageState createState() => _GuiaPageState();
}

class _GuiaPageState extends State<GuiaPage> {

  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guia de Remisión"),
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(

        child: SvgPicture.asset('assets/icons/send.svg',width: 27, color: Colors.white),
        onPressed: () {
          //_scanQr();
        },
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }

  Widget _crearBottonNavigationBar() {
    return BottomNavigationBar(

      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          print(currentIndex);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/edit.svg',width: 30, color: currentIndex == 0 ? Colors.lightBlueAccent : Colors.black54
          ),
            label: "General",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icons/document.svg',width: 30, color: currentIndex == 1 ? Colors.lightBlueAccent : Colors.black54),
          label: "Detalle",
        ),
      ],
    );
  }

  Widget? _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return GeneralPage();
      case 1:
        return DetallePage();
      default:
        GeneralPage();
    }
  }

}
