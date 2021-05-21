import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pncare_app/pn_accessibile.dart';
import 'homepage.dart';
import 'pnp_page.dart';
import 'riciclo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void ChangePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        HomePage(),
        PnPPage(),
        RiciclabolarioPage(),
        PnAccessibile()
      ][currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        onTap: ChangePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasNotch: true,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: SvgPicture.asset(
                'assets/icons/iconaPnBarraApp.svg',
                width: 21,
                color: Color(0xff174c4f),
                height: 21,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/iconaPnBarraApp.svg',
                width: 21,
                color: Color(0xffE3131E),
                height: 21,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                    fontFamily: 'Cocogoose Pro', color: Color(0xffE3131E)),
              )),
          BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.outlined_flag_rounded,
                color: Color(0xff174c4f),
              ),
              activeIcon: Icon(
                Icons.outlined_flag_rounded,
                color: Color(0xffE3131E),
              ),
              title: Text(
                "PnP",
                style: TextStyle(
                    fontFamily: 'Cocogoose Pro', color: Color(0xffE3131E)),
              )), // PnP sta per problemi e pensieri, pensato per la pagina delle segnalazioni e dei feedback sull'operato del comune
          BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.delete_outlined,
                color: Color(0xff174c4f),
              ),
              activeIcon: Icon(
                Icons.delete_outlined,
                color: Color(0xffE3131E),
              ),
              title: Text("PnRiciclo",
                  style: TextStyle(
                      fontFamily: 'Cocogoose Pro', color: Color(0xffE3131E)))),
          BubbleBottomBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.accessible_forward,
                color: Color(0xff174c4f),
              ),
              activeIcon: Icon(
                Icons.accessible_forward,
                color: Color(0xffE3131E),
              ),
              title: Text("Pn x Tutti",
                  style: TextStyle(
                      fontFamily: 'Cocogoose Pro', color: Color(0xffE3131E))))
        ],
      ),
    );
  }
}
