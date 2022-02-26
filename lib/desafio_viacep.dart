import 'package:desafio_viacep/data/repository/estado_repository.dart';

void execute() async {
  // //+++ listando estado da api e do db

  EstadoRepository estadoRepository = EstadoRepositoryFactory().getSource();
  var estadoModelList = await estadoRepository.getAll();
  print(estadoModelList.first);

  EstadoRepository estadoRepository2 =
      EstadoRepositoryFactory().getSource(source: Source.db1);

  var estadoModelList2 = await estadoRepository2.getAll();
  print(estadoModelList2.first);

  // //+++ Api -> EstadoModel
  // EstadoApiRepository estadoApiRepository = EstadoApiRepository();
  // var estadoModelList = await estadoApiRepository.getAll();
  // print(estadoModelList.length);

  // EstadoDbRepository estadoDbRepository = EstadoDbRepository();
  // //+++ EstadoModel -> table
  // var insert = await estadoDbRepository.postAll(estadoModelList);
  // print(insert);

  // // +++ list estado
  // var select = await estadoDbRepository.getAll();
  // for (var element in select) {
  //   print(element.toString());
  // }

  // //+++ estado getBy
  // var estado = 11;
  // var estadeSelect = await estadoDbRepository.getById(estado);
  // print(estadeSelect);
  // if (estadeSelect != null) {
  //   // +++ Api -> DistritoModel
  //   DistritoApiRepository distritoApiRepository = DistritoApiRepository();
  //   var distritoModelList = await distritoApiRepository.getAll(estadeSelect.id);
  //   for (var item in distritoModelList) {
  //     print(item);
  //   }

  //   DistritoDbRepository distritoDbRepository = DistritoDbRepository();
  //   //+++ DistritoModel -> table
  //   var insert = await distritoDbRepository.postAll(
  //       distritoList: distritoModelList, uuidEstado: estadeSelect.uuid);
  //   print(insert);
  // }
}
