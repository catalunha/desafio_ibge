import 'package:desafio_viacep/data/repository/api/estado_api_repository.dart';
import 'package:desafio_viacep/data/repository/database/estado_db_repository.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/api/exception/estado_api_exception.dart';
import 'package:desafio_viacep/data/repository/database/database_connection.dart';
import 'package:desafio_viacep/data/repository/database/exception/estado_db_exception.dart';

enum Source { api1, db1 }

class EstadoRepository {
  final EstadoApiRepository _estadoApiRepository = EstadoApiRepository();
  Source _source;
  set source(value) => _source = value;
  Source get source => _source;
  EstadoRepository({Source source = Source.api1}) : _source = source;
  Future<List<EstadoModel>> getAll() async {
    if (source == Source.db1) {
      final EstadoDbRepository _estadoDbRepository = EstadoDbRepository();
      return await _estadoDbRepository.getAll();
    } else {
      // Source.api1
      return await _estadoApiRepository.getAll();
    }
  }
}
