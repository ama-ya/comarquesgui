import 'package:flutter/material.dart';

class InfocomarcaGeneral extends StatelessWidget {
  const InfocomarcaGeneral({
    super.key,
    required this.imatge,
    required this.nom,
    required this.capital,
    required this.descripcio,
  });

  final String? imatge;
  final String nom;
  final String? capital;
  final String? descripcio;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 48.0),
        child: Column(children: <Widget>[
          Image.network(imatge!),
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nom, style: const TextStyle(fontSize: 24)),
                  Text("Capital: $capital"),
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    descripcio!,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
