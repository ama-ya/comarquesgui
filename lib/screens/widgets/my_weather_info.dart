import 'package:comarquesgui/repository/repository_weather.dart';
import 'package:comarquesgui/screens/widgets/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class MyWeatherInfo extends StatefulWidget {
  const MyWeatherInfo({
    required this.latitud,
    required this.longitud,
    super.key,
  }); 

  final double? latitud;
  final double? longitud;

  @override
  State<MyWeatherInfo> createState() => _MyWeatherInfoState();
}

class _MyWeatherInfoState extends State<MyWeatherInfo> {
  late Future<dynamic> info;

  @override
  void initState() {
    super.initState();
    info = RepositoryWeather.obteClima(
        longitud: widget.longitud ?? 0.0, latitud: widget.latitud ?? 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: info,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {

          String temperatura =
              snapshot.data["current_weather"]["temperature"].toString();
          String velVent =
              snapshot.data["current_weather"]["windspeed"].toString();
          String direccioVent =
              snapshot.data["current_weather"]["winddirection"].toString();
          String codi =
              snapshot.data["current_weather"]["weathercode"].toString();

          return Column(
            children: [
              _obtenirIconaOratge(codi),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.thermostat,
                    size: 35,
                  ),
                  Text(
                    "$temperaturaº",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wind_power, size: 25),
                  const SizedBox(width: 10),
                  Text(
                    "${velVent}km/h",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 30),
                  _obteGinyDireccioVent(direccioVent),
                ],
              ),
            ],
          );
        }
        return const MyCircularProgressIndicator();
      },
    );
  }

  Widget _obteGinyDireccioVent(String direccioVent) {

    double dir = double.parse(direccioVent);
    late Icon icona;
    late String nomVent;

    if (dir > 22.5 && dir < 65.5) {
      icona = const Icon(Icons.north_east);
      nomVent = "Gregal";
    } else if (dir > 67.5 && dir < 112.5) {
      icona = const Icon(Icons.east);
      nomVent = "Llevant";
    } else if (dir > 112.5 && dir < 157.5) {
      icona = const Icon(Icons.south_east);
      nomVent = "Xaloc";
    } else if (dir > 157.5 && dir < 202.5) {
      icona = const Icon(Icons.south);
      nomVent = "Migjorn";
    } else if (dir > 202.5 && dir < 247.5) {
      icona = const Icon(Icons.south_west);
      nomVent = "Llebeig/Garbí";
    } else if (dir > 247.5 && dir < 292.5) {
      icona = const Icon(Icons.west);
      nomVent = "Ponent";
    } else if (dir > 292.5 && dir < 337.5) {
      icona = const Icon(Icons.north_west);
      nomVent = "Mestral";
    } else {
      icona = const Icon(Icons.north);
      nomVent = "Tramuntana";
    }

    return Row(children: [
      Text(
        nomVent,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      icona,
    ]);
  }

  Widget _obtenirIconaOratge(String value) {
    
    Set<String> sol = <String>{"0"};
    Set<String> pocsNuvols = <String>{"1", "2", "3"};
    Set<String> nuvols = <String>{"45", "48"};
    Set<String> plujasuau = <String>{"51", "53", "55"};
    Set<String> pluja = <String>{
      "61", "63", "65", "66", "67", "80", "81", "82", "95", "96", "99"};
    Set<String> neu = <String>{"71", "73", "75", "77", "85", "86"};

    if (sol.contains(value)) {
      return Image.asset("assets/icons/png/soleado.png", scale: 2,);
    }
    if (pocsNuvols.contains(value)) {
      return Image.asset("assets/icons/png/poco_nublado.png", scale: 2);
    }
    if (nuvols.contains(value)) {
      return Image.asset("assets/icons/png/nublado.png", scale: 2);
    }
    if (plujasuau.contains(value)) {
      return Image.asset("assets/icons/png/lluvia_debil.png", scale: 2);
    }
    if (pluja.contains(value)) {
      return Image.asset("assets/icons/png/lluvia.png", scale: 2);
    }
    if (neu.contains(value)) {
      return Image.asset("assets/icons/png/nieve.png", scale: 2);
    }

    return Image.asset("assets/icons/png/poco_nublado.png", scale: 2);
  }
}
