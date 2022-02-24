import 'package:desafio_viacep/data/model/distrito_model.dart';
import 'package:desafio_viacep/data/repository/api/exception/distrito_api_exception.dart';
import 'package:dio/dio.dart';

class DistritoApiRepository {
  final Dio _dio;
  DistritoApiRepository({required Dio dio}) : _dio = dio;
  Future<List<DistritoModel>> getAll(int estadoId) async {
    try {
      final response = await _dio.get(
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
