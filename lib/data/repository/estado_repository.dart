import 'package:desafio_viacep/data/repository/api/estado_api_repository.dart';
import 'package:desafio_viacep/data/repository/database/estado_db_repository.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/api/exception/estado_api_exception.dart';
import 'package:desafio_viacep/data/repository/database/database_connection.dart';
import 'package:desafio_viacep/data/repository/database/exception/estado_db_exception.dart';

abstract class EstadoRepository {
  Future<List<EstadoModel>> getAll();
}

enum Source { api1, db1 }

class EstadoRepositoryFactory {
  EstadoRepository getSource({Source source = Source.api1}) {
    if (source == Source.db1) {
      return EstadoDbRepository();
    } else {
      return EstadoApiRepository();
    }
  }
}
