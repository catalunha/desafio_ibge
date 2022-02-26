import 'package:desafio_viacep/data/repository/api1/exception/estado_api_exception.dart';
import 'package:desafio_viacep/data/repository/database1/database_connection.dart';
import 'package:desafio_viacep/data/repository/database1/exception/estado_db_exception.dart';
import 'package:desafio_viacep/data/repository/estado_repository.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

import 'package:desafio_viacep/data/model/estado_model.dart';

class EstadoRepositoryDb1 extends EstadoRepository {
  MySqlConnection? _conn;
  DatabaseConnection? _databaseConnection;
  // EstadoDbRepository2()
  EstadoRepositoryDb1() {
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

  @override
  Future<List<EstadoModel>> getAll() async {
    try {
      await startConn();
      var result = await _conn!.query('select * from estado');
      var estado = result.map((e) => EstadoModel.fromMap(e.fields)).toList();
      return estado;
    } on MySqlException catch (e) {
      print('Erro MySqlException: EstadoDbRepository2.postAll');
      print(e);
      return <EstadoModel>[];
    } finally {
      await closeConn();
    }
  }

  Future<EstadoModel?> getById(int id) async {
    try {
      await startConn();
      var result = await _conn!.query('select * from estado where id=?', [id]);
      print(result.length);
      if (result.length > 1) {
        throw EstadoEmptyResultApiException();
      }
      var estado = EstadoModel.fromMap(result.first.fields);
      return estado;
    } on EstadoEmptyResultApiException catch (e) {
      print('Erro EstadoEmptyResultApiException: EstadoDbRepository2.getById');
      print(e);
      return null;
    } on MySqlException catch (e) {
      print('Erro MySqlException: EstadoDbRepository2.getById');
      print(e);
      return null;
    } finally {
      await closeConn();
    }
  }

  Future<bool> postAll(List<EstadoModel> estadoList) async {
    try {
      await startConn();
      var listFields =
          estadoList.map((e) => [Uuid().v4(), e.id, e.sigla, e.nome]).toList();
      var result = await _conn!.queryMulti(
          'insert into estado(uuid,id,sigla,nome) values(?,?,?,?)', listFields);
      if (estadoList.length != result.length) {
        throw EstadoDbException();
      }
      return Future.value(true);
    } on MySqlException catch (e) {
      print('Erro MySqlException: EstadoDbRepository2.postAll');
      print(e);
      return Future.value(false);
      ;
    } on EstadoDbException catch (e) {
      print('Erro EstadoDbException: EstadoDbRepository2.postAll');
      print(e);
      return Future.value(false);
    } finally {
      await closeConn();
    }
  }
}
