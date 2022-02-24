import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/api/exception/estado_api_exception.dart';
import 'package:desafio_viacep/data/repository/database/exception/estado_db_exception.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

class EstadoDbRepository {
  final MySqlConnection _conn;
  EstadoDbRepository({required MySqlConnection conn}) : _conn = conn;

  Future<List<EstadoModel>> getAll() async {
    try {
      var result = await _conn.query('select * from estado');
      var estado = result.map((e) => EstadoModel.fromMap(e.fields)).toList();
      return estado;
    } on MySqlException catch (e) {
      print('Erro MySqlException: EstadoDbRepository.postAll');
      print(e);
      return <EstadoModel>[];
    } finally {
      _conn.close();
    }
  }

  Future<EstadoModel?> getById(int id) async {
    try {
      var result = await _conn.query('select * from estado where id=?', [id]);
      print(result.length);
      if (result.length > 1) {
        throw EstadoEmptyResultApiException();
      }
      var estado = EstadoModel.fromMap(result.first.fields);
      return estado;
    } on EstadoEmptyResultApiException catch (e) {
      print('Erro EstadoEmptyResultApiException: EstadoDbRepository.getById');
      print(e);
      return null;
    } on MySqlException catch (e) {
      print('Erro MySqlException: EstadoDbRepository.getById');
      print(e);
      return null;
    } finally {
      _conn.close();
    }
  }

  Future<bool> postAll(List<EstadoModel> estadoList) async {
    try {
      var listFields =
          estadoList.map((e) => [Uuid().v4(), e.id, e.sigla, e.nome]).toList();
      var result = await _conn.queryMulti(
          'insert into estado(uuid,id,sigla,nome) values(?,?,?,?)', listFields);
      if (estadoList.length != result.length) {
        throw EstadoDbException();
      }
      return true;
    } on MySqlException catch (e) {
      print('Erro MySqlException: EstadoDbRepository.postAll');
      print(e);
      return false;
    } on EstadoDbException catch (e) {
      print('Erro EstadoDbException: EstadoDbRepository.postAll');
      print(e);
      return false;
    } finally {
      _conn.close();
    }
  }
}
