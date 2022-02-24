import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/api/distrito_api_repository.dart';
import 'package:desafio_viacep/data/repository/api/estado_api_repository.dart';
import 'package:desafio_viacep/data/repository/database/database_connection.dart';
import 'package:desafio_viacep/data/repository/database/distrito_db_repository.dart';
import 'package:desafio_viacep/data/repository/database/estado_db_repository.dart';
import 'package:dio/dio.dart';
import 'package:mysql1/mysql1.dart';

void execute() async {
  var dio = Dio();
  // //+++ Api -> EstadoModel
  // EstadoApiRepository estadoApiRepository = EstadoApiRepository(dio: dio);
  // var estadoModelList = await estadoApiRepository.getAll();
  // print(estadoModelList.length);

  // //+++ EstadoModel -> table
  // DatabaseConnection databaseConnection = DatabaseConnection();
  // var conn = await databaseConnection.openConnection();
  // EstadoDbRepository estadoDbRepository = EstadoDbRepository(conn: conn);
  // var insert = await estadoDbRepository.postAll(estadoModelList);
  // print(insert);

  //+++ list estado
  // DatabaseConnection databaseConnection = DatabaseConnection();
  // var conn = await databaseConnection.openConnection();
  // EstadoDbRepository estadoDbRepository = EstadoDbRepository(conn: conn);
  // var select = await estadoDbRepository.getAll();
  // for (var element in select) {
  //   print(element.toString());
  // }

  //+++ estado getBy
  var estado = 11;
  DatabaseConnection databaseConnection = DatabaseConnection();
  var conn = await databaseConnection.openConnection();
  EstadoDbRepository estadoDbRepository = EstadoDbRepository(conn: conn);
  var estadeSelect = await estadoDbRepository.getById(estado);
  print(estadeSelect);
  if (estadeSelect != null) {
    // +++ Api -> DistritoModel
    DistritoApiRepository distritoApiRepository =
        DistritoApiRepository(dio: dio);
    var distritoModelList = await distritoApiRepository.getAll(estadeSelect.id);
    for (var item in distritoModelList) {
      print(item);
    }

    //+++ DistritoModel -> table
    DatabaseConnection databaseConnection2 = DatabaseConnection();
    var conn2 = await databaseConnection2.openConnection();
    DistritoDbRepository distritoDbRepository =
        DistritoDbRepository(conn: conn2);
    var insert = await distritoDbRepository.postAll(
        distritoList: distritoModelList, uuidEstado: estadeSelect.uuid);
    print(insert);
  }
}
