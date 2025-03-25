import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/repository/repository_comarques.dart';
import 'package:comarquesgui/screens/comarques_screen.dart';
import 'package:comarquesgui/screens/widgets/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class ProvinciesScreen extends StatelessWidget {
  const ProvinciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: RepositoryComarques.obtenirProvincies(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<Provincia> provincias = snapshot.data as List<Provincia>;
                  List<Widget> llista = [];

                  for (Provincia provincia in provincias) {
                    llista.add(ProvinciaRoundButton(
                        nom: provincia.nom, img: provincia.imatge ?? ""));
                    llista.add(const SizedBox(height: 20));
                  }

                  return Center(
                    child: Column(
                      children: llista,
                    ),
                  );
                }
                return const MyCircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProvinciaRoundButton extends StatelessWidget {
  const ProvinciaRoundButton({required this.img, required this.nom, super.key});

  final String img;
  final String nom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ComarquesScreen(
                      provincia: nom,
                    )));
      },
      child: CircleAvatar(
        radius: 110,
        backgroundColor: Colors.blue,
        child: CircleAvatar(
          radius: 105,
          backgroundImage: NetworkImage(img),
          child: Text(
            nom,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
