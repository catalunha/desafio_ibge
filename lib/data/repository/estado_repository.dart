import 'package:desafio_viacep/data/repository/api1/estado_source_api1.dart';

import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/database1/estado_source_db1.dart';

abstract class EstadoRepository {
  Future<List<EstadoModel>> getAll();
  Future<EstadoModel?> getById(int id);
}

enum Source { api1, db1 }

class EstadoRepositoryFactory {
  EstadoRepository getSource({Source source = Source.api1}) {
    if (source == Source.db1) {
      return EstadoSourceDb1();
    } else {
      return EstadoSourceApi1();
    }
  }
}
