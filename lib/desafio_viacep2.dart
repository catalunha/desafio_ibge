import 'package:desafio_viacep/data/repository/estado_repository.dart';

Future<void> main() async {
  EstadoRepository estadoRepository = EstadoRepositoryFactory().getSource();
  var estadoModelList = await estadoRepository.getAll();
  print(estadoModelList.first);

  EstadoRepository estadoRepository2 =
      EstadoRepositoryFactory().getSource(source: Source.db1);

  var estadoModelList2 = await estadoRepository2.getAll();
  print(estadoModelList2.first);
}
