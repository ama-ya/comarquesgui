import 'package:comarquesgui/services/weather_service.dart';

class RepositoryWeather {
  static Future<dynamic> obteClima({required double longitud, required double latitud}) async {
    return WeatherService.obteClima(longitud: longitud, latitud: latitud);
  }
}