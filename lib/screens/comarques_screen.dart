import 'package:comarquesgui/repository/repository_comarques.dart';
import 'package:comarquesgui/screens/infocomarca_screen.dart';
import 'package:comarquesgui/screens/widgets/my_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class ComarquesScreen extends StatelessWidget {
  const ComarquesScreen({super.key, required this.provincia});

  final String provincia;

  @override
  Widget build(BuildContext context) {
    String titulo = "Comarques de ";
    if (provincia == "Alacant") {
      titulo = "Comarques d'";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$titulo$provincia",
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 20),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: RepositoryComarques.obtenirComarques(provincia),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<dynamic> comarques = snapshot.data as List<dynamic>;
              return ComarcaCard(comarques: comarques);
            }
            return const MyCircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class ComarcaCard extends StatelessWidget {
  const ComarcaCard({super.key, required this.comarques});

  final dynamic comarques;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.builder(
        itemCount: comarques.length,
        itemBuilder: (BuildContext context, int index) {
          final comarca = comarques[index];

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            InfocomarcaScreen(comarca: comarca['nom']),
                      ));
                },
                child: Stack(
                  children: [
                    FadeInImage(
                      placeholder:
                          const AssetImage('assets/icons/gif/loading_icon.gif'),
                      image: NetworkImage(comarca['img']),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 15,
                      bottom: 15,
                      child: Text(
                        comarca['nom'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'LeckerliOne',
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
