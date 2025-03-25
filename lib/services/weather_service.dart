import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static Future<dynamic> obteClima(
      {required double longitud, required double latitud}) async {
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

    // Petición Get
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      // Descodifica la respuesta
      String body = utf8.decode(response.bodyBytes);
      final result = jsonDecode(body);

      return result;
    } else {
      throw Exception('No s\'ha pogut connectar');
    }
  }
}
