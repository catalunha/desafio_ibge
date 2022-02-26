import 'package:desafio_viacep/data/repository/api1/estado_repository_api1.dart';

import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/database1/estado_repository_db1.dart';

abstract class EstadoRepository {
  Future<List<EstadoModel>> getAll();
  Future<EstadoModel?> getById(int id);
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
