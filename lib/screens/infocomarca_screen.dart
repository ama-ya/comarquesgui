import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/repository/repository_comarques.dart';
import 'package:comarquesgui/screens/infocomarca_detall.dart';
import 'package:comarquesgui/screens/infocomarca_general.dart';
import 'package:comarquesgui/screens/widgets/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class InfocomarcaScreen extends StatefulWidget {
  const InfocomarcaScreen({super.key, required this.comarca});

  final String comarca;

  @override
  State<InfocomarcaScreen> createState() => _InfocomarcaScreenState();
}

class _InfocomarcaScreenState extends State<InfocomarcaScreen> {
  int indexActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: [
          Text(
            "Informació General",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 20),
          ),
          Text(
            "Població i Oratge",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: 20),
          ),
        ][indexActual],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            indexActual = index;
          });
        },
        selectedIndex: indexActual,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.info_outlined),
              selectedIcon: Icon(Icons.info),
              label: "Informació general"),
          NavigationDestination(
              icon: Icon(Icons.wb_sunny_outlined),
              selectedIcon: Icon(Icons.sunny),
              label: "Informació detallada"),
        ],
      ),
      body: FutureBuilder(
        future: RepositoryComarques.obtenirInfoComarca(widget.comarca),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Comarca comarca = snapshot.data as Comarca;
            String? imatge = comarca.img;
            String nom = comarca.comarca;
            String? capital = comarca.capital;
            String? descripcio = comarca.desc;
            String poblacio = comarca.poblacio.toString();
            String latitud = comarca.latitud.toString();
            String longitud = comarca.longitud.toString();

            return <Widget>[
              InfocomarcaGeneral(
                  imatge: imatge,
                  nom: nom,
                  capital: capital,
                  descripcio: descripcio),
              InfocomarcaDetall(
                poblacio: poblacio,
                latitud: latitud,
                longitud: longitud,
              )
            ][indexActual];
          }
          return const MyCircularProgressIndicator();
        },
      ),
    );
  }
}
