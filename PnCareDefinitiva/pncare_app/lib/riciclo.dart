import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class RiciclabolarioPage extends StatefulWidget {
  @override
  _RiciclabolarioPageState createState() => _RiciclabolarioPageState();
}

class _RiciclabolarioPageState extends State<RiciclabolarioPage> {
  /*
  var rifiuto = ['contenitore tetrapack', 'accendino', 'televisore', 'cassetta di legno', 'trucchi', 'cartuccia toner'];
  var dove = ['raccolta carta', 'secco residuo', 'RAEE, ecocentro', 'verde', 'secco residuo', 'ecocentro, contenitore in negozio'];
  */

  List listaRifiuti = [];

  TextEditingController _searchController = TextEditingController();

  // Listener per la ricerca --> capta ogni cambiamento nella casella di testo
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  // Quando viene chiusa la pagina rimuove la ricerca e il suo listener
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Titolo della pagina
          Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 10, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'PnRiciclo',
                  style: GoogleFonts.poppins(
                      fontSize: 35,
                      color: Color(0xffE3131E),
                      fontWeight: FontWeight.bold
                  )
              )
            )
          ),
          // Barra di ricerca
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Cerca un rifiuto",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                    )
                ),
              )
          ),
          // Linea divisoria tra barra di ricerca e lista di rifiuti
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              thickness: 2,
              indent: 5,
              endIndent: 5,
              color: Color(0xffE3131E),
            ),
          ),
          // Lista di tutti i rifiuti
          Expanded(
              child: FutureBuilder<List<ParseObject>>(
                  future: richiestaRifiuti(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Errore..."),
                          );
                        } else {
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 20),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                // Richiesta valori per ogni rifiuto
                                final rifiuto = snapshot.data[index];
                                final nomeRifiuto = rifiuto.get<String>('Nome');
                                final doveButtare =
                                    rifiuto.get<String>('DoveButtare');
                                final tipoRifiuto =
                                    rifiuto.get<String>('TipologiaRifiuto');

                                return ListTile(
                                  title: Text(nomeRifiuto),
                                  leading: Icon(Icons.delete),
                                  subtitle: Text('Tipo: ' +
                                      tipoRifiuto +
                                      '\nDove lo butto: ' +
                                      doveButtare),
                                );
                              });
                        }
                    }
                  }))
        ],
      ),
    );
  }

  Future<List<ParseObject>> richiestaRifiuti() async {
    QueryBuilder<ParseObject> queryRifiuti =
        QueryBuilder<ParseObject>(ParseObject('Rifiuti'));
    final ParseResponse apiResponse = await queryRifiuti.query();

    if (apiResponse.success && apiResponse.results != null) {
      listaRifiuti = apiResponse.results;
      return apiResponse.results;
    } else {
      return [];
    }
  }

  void puliziaLista() {
    for (int i = 0; i < listaRifiuti.length; i++) {
      listaRifiuti[i].remove("className");
      listaRifiuti[i].remove("objectId");
      listaRifiuti[i].remove("createdAt");
      listaRifiuti[i].remove("updatedAt");
      listaRifiuti[i].remove("DoveButtare");
      listaRifiuti[i].remove("TipologiaRifiuto");
    }
  }
}
