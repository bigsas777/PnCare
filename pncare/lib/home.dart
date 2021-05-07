import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'file non usati/main_drawer.dart';
import 'homepage.dart';
import 'pnp_page.dart';

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
      /* appBar: AppBar(
        backgroundColor: Color(0xffE3131E),
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Builder(
                  builder: (context) => IconButton(
                      icon: Icon(Icons.menu_rounded),
                      iconSize: 32,
                      // color: Color(0xffF5E9BE),
                      onPressed: () => Scaffold.of(context).openDrawer())),
            ),
            Text(
              'PnCare',
              style: TextStyle(
                fontFamily: 'Cocogoose Pro', /*color: Color(0xffF5E9BE)*/
              ),
            )
          ],
        ),
        titleSpacing: 0,
      ), */
      // drawer: MenuLaterale(),
      // Colore schermate
      body: <Widget>[
        HomePage(),
        PnPPage(),
        Container(
            // color: Color(0xffF5E9BE),
            ),
        Container(
            // color: Color(0xffF5E9BE),
            )
      ][currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        //backgroundColor: Color(0xffEF3A44),
        opacity: .2,
        currentIndex: currentIndex,
        onTap: ChangePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasNotch: true, //new

        // ATTRIBUTI NON RICHIESTI
        // fabLocation: BubbleBottomBarFabLocation.end, //new
        // hasInk: true //new, gives a cute ink effect
        // inkColor: Colors.black12 //optional, uses theme color if not specified

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
              title: Text("Riciclabolario",
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
              title: Text("Pn Accessibile",
                  style: TextStyle(
                      fontFamily: 'Cocogoose Pro', color: Color(0xffE3131E))))
        ],
      ),
    );
  }
}
