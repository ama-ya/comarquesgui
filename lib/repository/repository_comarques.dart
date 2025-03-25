import 'package:comarquesgui/models/comarca.dart';
import 'package:comarquesgui/models/provincia.dart';
import 'package:comarquesgui/services/comarques_service.dart';

class RepositoryComarques {
  static Future<List<Provincia>> obtenirProvincies() {
    return ComarquesService.obtenirProvincies();
  }

  static Future<List<dynamic>> obtenirComarques(String provincia) {
    return ComarquesService.obtenirComarques(provincia);
  }

  static Future<Comarca?> obtenirInfoComarca(String comarca) {
    return ComarquesService.infoComarca(comarca);
  }
}