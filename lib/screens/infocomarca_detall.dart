import 'package:comarquesgui/screens/widgets/my_weather_info.dart';
import 'package:flutter/material.dart';

class InfocomarcaDetall extends StatelessWidget {
  const InfocomarcaDetall({
    super.key,
    required this.poblacio,
    required this.latitud,
    required this.longitud,
  });

  final String poblacio;
  final String latitud;
  final String longitud;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyWeatherInfo(
              latitud: double.tryParse(latitud),
              longitud: double.tryParse(longitud),
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              width: 200,
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Población:"),
                        Text("Latitud:"),
                        Text("Longitud:"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$poblacio hab."),
                        Text(latitud),
                        Text(longitud),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
