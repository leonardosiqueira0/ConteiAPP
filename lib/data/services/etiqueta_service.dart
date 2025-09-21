import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/data/models/etiqueta_model.dart';
import 'package:contei_app/data/models/resposta_model.dart';
import 'package:contei_app/data/services/api_service.dart';
import 'package:dio/dio.dart';

class EtiquetaService {
  Future<RespostaModel> buscarEtiquetaPorQrCode(String qrCode, ContagemModel contagem) async {
    try {
      final response = await ApiService.dio.get(
        '/Etiqueta/byQRCode/$qrCode',
        queryParameters: {
          'contagemID': contagem.id,
        },
      );
      return RespostaModel(
        status: true,
        mensagem: 'Busca realizada com sucesso',
        data: [{'etiqueta': EtiquetaModel.fromJson(response.data)}],
      );
    } on DioException catch (e) {
      return RespostaModel(
        status: false,
        mensagem: '${e.response?.data?? e.message}',
      );
    } catch (e) {
      return RespostaModel(status: false, mensagem: e.toString());
    }
  }

  Future<RespostaModel> buscarEtiquetaPorID(String id) async {
    try {
      final response = await ApiService.dio.get(
        '/Etiqueta/$id',
      );
      return RespostaModel(
        status: true,
        mensagem: 'Busca realizada com sucesso',
        data: [{'etiqueta': EtiquetaModel.fromJson(response.data)}],
      );
    } on DioException catch (e) {
      return RespostaModel(
        status: false,
        mensagem: e.response?.data['message'] ?? e.message,
      );
    } catch (e) {
      return RespostaModel(status: false, mensagem: e.toString());
    }
  }
}
