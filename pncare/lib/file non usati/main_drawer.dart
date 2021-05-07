import 'package:flutter/material.dart';

class MenuLaterale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      Container(
        // width: double.infinity,
        // padding: EdgeInsets.all(20),
        color: Color(0xffF5E9BE),
        child: Center(
          child: Column(children: <Widget>[
            DrawerHeader(
                child: Container(
              color: Color(0xffF5E9BE),
              height: 140,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/immagini/logo_trasparente.png",
                fit: BoxFit.cover,
              ),
            )),
            /* Container(
              child: Image.asset(
                "assets/immagini/logo_trasparente.png",
                fit: BoxFit.cover,
              ),
            ), */
          ]),
        ),
      ),
    ])
        /* SizedBox(
          height: 30,
        ),
        DrawerHeader(
            child: Container(
          color: Color(0xffF5E9BE),
          height: 140,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/immagini/logo_trasparente.png",
            fit: BoxFit.cover,
          ),
        )),
        SizedBox(
          height: 20,
        ),
        Text(
          'Profilo',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Cocogoose Pro',
          ),
        ),
        SizedBox(
          height: 45,
        ),
        Text(
          'Le mie segnalazioni',
          style: TextStyle(fontSize: 20, fontFamily: 'Cocogoose Pro'),
        ),
        SizedBox(
          height: 45,
        ),
        Text(
          'Logout',
          style: TextStyle(fontSize: 20, fontFamily: 'Cocogoose Pro'),
        ),
        SizedBox(
          height: 45,
        ),
        Material(
          borderRadius: BorderRadius.circular(500),
          child: InkWell(
            borderRadius: BorderRadius.circular(500),
            splashColor: Color(0xffE3131E),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xffE3131E),
              child: Icon(Icons.close_sharp, color: Colors.white),
            ),
          ),
        ),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 65,
            width: MediaQuery.of(context).size.width,
            color: Color(0xffE3131E),
            child: Center(
              child: Text(
                'Il nostro team',
                style: TextStyle(
                    fontFamily: 'Cocogoose Pro',
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
          ),
        ))
      */
        );
  }
}
