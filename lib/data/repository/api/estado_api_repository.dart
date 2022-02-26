import 'package:desafio_viacep/data/model/estado_model.dart';
import 'package:desafio_viacep/data/repository/api/exception/estado_api_exception.dart';
import 'package:desafio_viacep/data/repository/estado_repository.dart';
import 'package:dio/dio.dart';

class EstadoApiRepository extends EstadoRepository {
  Dio? _dio;
  EstadoApiRepository() {
    onInit();
  }
  void onInit() async {
    try {
      _dio = Dio();
    } on Exception catch (e) {
      print('Erro em EstadoApiRepository. Ao conectar com api...');
      rethrow;
    }
  }

  @override
  Future<List<EstadoModel>> getAll() async {
    try {
      final response = await _dio!
          .get('https://servicodados.ibge.gov.br/api/v1/localidades/estados');
      if (response.statusCode != 200) {
        throw EstadoApiException();
      }
      List<dynamic> responseData = response.data;
      return responseData
          .map<EstadoModel>((e) => EstadoModel.fromMap(e))
          .toList();
    } on EstadoApiException catch (e) {
      print('Erro: EstadoException');
      print(e);
      return <EstadoModel>[];
    } catch (e) {
      print('Erro: EstadoRepository.getAll');
      print(e);
      rethrow;
    }
  }
}
