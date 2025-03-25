import 'dart:convert';
import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/models/provincia.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComarquesService {
  static Future<List<Provincia>> obtenirProvincies() async {
    // Obtiene la lista de provincias
    try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques/provincies";
      var data = await http.get(Uri.parse(url));

      // Preparamos la lista de provincias a retornar
      List<Provincia> listaProvincias = [];

      if (data.statusCode == 200) {
        // Si hay respuesta positiva, la procesamos para devolverla como lista de provincias
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body) as List;

        // Forma 1. Recorrem el JSON i creem la llista de provincies
        /*for (var provinciaJSON in bodyJSON) {
          // Amb el constructor per defecte
          llistaProvincies.add(Provincia(
            nom: provinciaJSON["provincia"],
            imatge: provinciaJSON["img"],
          ));

          // Alternativa: Amb el constructor amb nom
           //llistaProvincies.add(Provincia.fromJSON(provinciaJSON));
        }*/

        // Forma 2: Hacemos uso del mapa de estructuras
        listaProvincias = bodyJSON.map((provinciaJSON) {
          // Con el constructor por defecto
          return Provincia(
            nom: provinciaJSON["provincia"],
            imatge: provinciaJSON["img"],
          );
          // Alternativa: Con el constructor con nombre
          //return Provincia.fromJSON(provinciaJSON);
        }).toList();
      }
      // Devolvemos la lista
      return listaProvincias;
    } catch (except) {
      debugPrint(except.toString());
      return [];
    }
  }

  /*
    Future<List<dynamic>> obtenerComarcas(String provincia): Que devolverá un Future que
    se resolverá en una lista de objetos dinámicos a partir de lo que nos devuelve la petición
    web a la ruta api/comarcas/comarcasAmbImagen/$provincia. Ten en cuenta que, en este
    método, a diferencia del anterior, no es necesario hacer ninguna conversión del resultado
    de la petición web; directamente, devolveremos el JSON que nos devuelve.
  */

  static Future<List<dynamic>> obtenirComarques(String provincia) async {
    // Obtiene la lista de comarcas en formato JSON
    try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";
      var data = await http.get(Uri.parse(url));

      // Si hay respuesta positiva, la procesamos para devolverla
      if (data.statusCode == 200) {
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body);

        return bodyJSON;
      } else {
        return [];
      }
    } catch (except) {
      debugPrint(except.toString());
      return [];
    }
  }

  /*
    Future<Comarca?> infoComarca(String comarca): Que devolverá un Future con un objeto
    de tipo Comarca, generado a partir de la petición web a la ruta
    /api/comarcas/infoComarca/$comarca. En este caso, sí habrá que hacer una conversión
    del objeto JSON que recibimos a un objeto de tipo Comarca.
  */

  static Future<Comarca?> infoComarca(String comarca) async {
    // Obtiene un objeto de tipo comarca
    try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";
      var data = await http.get(Uri.parse(url));

      // Si hay respuesta positiva, la procesamos para devolverla
      if (data.statusCode == 200) {
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body);

        // Devolvemos un objeto Comarca a partir del JSON
        return Comarca.fromJSON(bodyJSON);
      } else {
        return null;
      }
    } catch (except) {
      debugPrint(except.toString());
      return null;
    }
  }
}
