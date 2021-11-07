import 'package:http/http.dart' as http;
import 'dart:convert';

Future richiestaNotizie(url) async {
  http.Response response = await http.get(url);

  var result = jsonDecode(response.body);

  print(result);
}
