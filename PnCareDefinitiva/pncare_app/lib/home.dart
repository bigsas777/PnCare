import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pncare_app/pn_accessibile.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person, color: Color(0xffE3131E),),
        backgroundColor: Colors.white,
        onPressed: () {},
      ),
      body: <Widget>[
        HomePage(),
        PnPPage(),
        RiciclabolarioPage(),
        PnAccessibile()
      ][currentIndex],
      bottomNavigationBar: AnimatedNavigationBar(
        items: [
          AnimatedBarItems(
            icon: SvgPicture.asset(
              'assets/icons/iconaPnBarraApp.svg',
              width: 28,
              color: Color(0xff174c4f),
              height: 28,
            ),
            title: Text(
                "Home",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffE3131E),
                ),
            ),
          ),
          AnimatedBarItems(
            selectedColor: Color(0xffE3131E),
            unSelectedColor: Color(0xff174c4f),
            icon: Icon(
              Icons.outlined_flag_rounded,
              color: Color(0xff174c4f),
              size: 28,
            ),
            title: Text(
              "PnP",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffE3131E),
              ),
            ),
          ),
          AnimatedBarItems(
            icon: Icon(
              Icons.delete_outlined,
              color: Color(0xff174c4f),
              size: 28,
            ),
            title: Text(
              "PnRiciclo",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffE3131E),
              ),
            ),
          ),
          AnimatedBarItems(
            icon: Icon(
              Icons.accessible_forward,
              color: Color(0xff174c4f),
              size: 28,
            ),
            title: Text(
              "Pn x Tutti",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffE3131E),
              ),
            ),
            selectedColor: Color(0xffE3131E)
          ),
        ],
        currentIndex: currentIndex ?? 0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        iconSize: 38,
        inkEffect: true,
        inkColor: Color(0x7ee3131e),
        opacity: 0.2,
        hasNotch: true,
        fabLocation: StylishBarFabLocation.end,
      ),
    );
  }
}
