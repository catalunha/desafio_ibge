import 'package:desafio_viacep/data/model/distrito_model.dart';
import 'package:desafio_viacep/data/repository/database/database_connection.dart';
import 'package:desafio_viacep/data/repository/database/exception/distrito_db_exception.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

class DistritoDbRepository {
  MySqlConnection? _conn;
  DatabaseConnection? _databaseConnection;
  DistritoDbRepository() {
    onInit();
  }

  void onInit() async {
    try {
      _databaseConnection = DatabaseConnection();
      // _conn = await _databaseConnection!.openConnection();
    } on Exception catch (e) {
      print('Erro em EstadoDbRepository2. Ao conectar com banco...');
      rethrow;
    }
  }

  Future<bool> startConn() async {
    try {
      _conn = await _databaseConnection!.openConnection();
    } on Exception catch (e) {
      return Future.value(false);
    }

    return Future.value(true);
  }

  Future<bool> closeConn() async {
    try {
      await _conn!.close();
    } on Exception catch (e) {
      return Future.value(false);
    }

    return Future.value(true);
  }

  Future<bool> postAll(
      {required List<DistritoModel> distritoList,
      required String uuidEstado}) async {
    try {
      await startConn();

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
      var result = await _conn!.queryMulti(
          'insert into distrito(uuid,uuidEstado,id,nome) values(?,?,?,?)',
          listFields);
      if (distritoList.length != result.length) {
        throw CidadeDbException();
      }
      return Future.value(true);
    } on MySqlException catch (e) {
      print('Erro MySqlException: CidadeDbRepository.postAll');
      print(e);
      return Future.value(false);
    } on CidadeDbException catch (e) {
      print('Erro CidadeDbException: CidadeDbRepository.postAll');
      print(e);
      return Future.value(false);
    } finally {
      await closeConn();
    }
  }

  Future<List<DistritoModel>> getAll() async {
    try {
      await startConn();
      var result = await _conn!.query('select * from distrito');
      var estado = result.map((e) => DistritoModel.fromMap(e.fields)).toList();
      return estado;
    } on MySqlException catch (e) {
      print('Erro MySqlException: CidadeDbRepository.postAll');
      print(e);
      return <DistritoModel>[];
    } finally {
      await closeConn();
    }
  }
}
