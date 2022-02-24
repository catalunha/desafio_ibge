import 'package:desafio_viacep/data/model/distrito_model.dart';
import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/database/exception/distrito_db_exception.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

class DistritoDbRepository {
  final MySqlConnection _conn;
  DistritoDbRepository({required MySqlConnection conn}) : _conn = conn;

  Future<bool> postAll(
      {required List<DistritoModel> distritoList,
      required String uuidEstado}) async {
    try {
      assert(distritoList[0].estadoModel != null || uuidEstado.isNotEmpty);
      var listFields = distritoList
          .map((distrito) => [
                Uuid().v4(),
                uuidEstado,
                distrito.id,
                distrito.nome,
              ])
          .toList();
      for (var item in listFields) {
        print(item);
      }
      var result = await _conn.queryMulti(
          'insert into distrito(uuid,uuidEstado,id,nome) values(?,?,?,?)',
          listFields);
      if (distritoList.length != result.length) {
        throw CidadeDbException();
      }
      return true;
    } on MySqlException catch (e) {
      print('Erro MySqlException: CidadeDbRepository.postAll');
      print(e);
      return false;
    } on CidadeDbException catch (e) {
      print('Erro CidadeDbException: CidadeDbRepository.postAll');
      print(e);
      return false;
    } finally {
      _conn.close();
    }
  }

  Future<List<DistritoModel>> getAll() async {
    try {
      var result = await _conn.query('select * from distrito');
      var estado = result.map((e) => DistritoModel.fromMap(e.fields)).toList();
      return estado;
    } on MySqlException catch (e) {
      print('Erro MySqlException: CidadeDbRepository.postAll');
      print(e);
      return <DistritoModel>[];
    } finally {
      _conn.close();
    }
  }
}
