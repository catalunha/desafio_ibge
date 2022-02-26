import 'package:desafio_viacep/data/repository/api1/estado_repository_api1.dart';
import 'package:desafio_viacep/data/repository/database/estado_repository_db1.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

import 'package:desafio_viacep/data/model/estado_model.dart';

abstract class EstadoRepository {
  Future<List<EstadoModel>> getAll();
}

enum Source { api1, db1 }

class EstadoRepositoryFactory {
  EstadoRepository getSource({Source source = Source.api1}) {
    if (source == Source.db1) {
      return EstadoRepositoryDb1();
    } else {
      return EstadoRepositoryApi1();
    }
  }
}
