import 'package:desafio_viacep/data/model/distrito_model.dart';
import 'package:desafio_viacep/data/repository/api1/exception/distrito_api_exception.dart';
import 'package:dio/dio.dart';

class DistritoApiRepository {
  Dio? _dio;
  DistritoApiRepository() {
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

  Future<List<DistritoModel>> getAll(int estadoId) async {
    try {
      final response = await _dio!.get(
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$estadoId/distritos');
      if (response.statusCode != 200) {
        throw CidadeApiException();
      }
      List<dynamic> responseData = response.data;
      return responseData
          .map<DistritoModel>((e) => DistritoModel.fromMap(e))
          .toList();
    } on CidadeApiException catch (e) {
      print('Erro: CidadeApiException');
      print(e);
      return <DistritoModel>[];
    } catch (e) {
      print('Erro: CidadeApiRepository.getAll');
      print(e);
      rethrow;
    }
  }
}
