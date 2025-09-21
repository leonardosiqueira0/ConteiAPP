import 'package:contei_app/data/models/contagem_etiqueta_model.dart';
import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/data/models/resposta_model.dart';
import 'package:contei_app/data/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ContagemService {
  Future<RespostaModel> criarContagem(ContagemModel contagem) async {
    try {
      await ApiService.dio.post(
        '/Contagem/criar',
        data: contagem.toJson(),
      );
      return RespostaModel(
        status: true,
        mensagem: 'Contagem criada com sucesso',
      );
    } on DioException catch (e) {
      debugPrint('Erro ao criar contagem: ${e.error}');
      return RespostaModel(
        status: false,
        mensagem: e.response?.data ?? e.message,
      );
    } catch (e) {
      return RespostaModel(status: false, mensagem: e.toString());
    }
  }

  Future<RespostaModel> criarContagemEtiqueta(ContagemEtiquetaModel contagemEtiqueta) async {
    try {
      await ApiService.dio.post(
        '/Contagem/criar-etiqueta',
        data: contagemEtiqueta.toJson(),
      );
      return RespostaModel(
        status: true,
        mensagem: 'Contagem Etiqueta criada com sucesso',
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

  Future<RespostaModel> buscarContagens(String? status) async {
    try {
      final response = await ApiService.dio.get(
        '/Contagem',
        queryParameters: (status == null) ? null : {
          'status': status,
        },
      );
      return RespostaModel(
        status: true,
        mensagem: 'Busca realizada com sucesso',
        data: response.data.map((e) => ContagemModel.fromJson(e)).toList(),
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

  Future<RespostaModel> buscarContagensEtiquetas(ContagemModel contagem) async {
    try {
      final response = await ApiService.dio.get(
        '/Contagem/${contagem.id}/etiquetas',
      );
      return RespostaModel(
        status: true,
        mensagem: 'Busca realizada com sucesso',
        data: response.data.map((e) {
          return ContagemEtiquetaModel.fromJson(e);
        }).toList(),
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

  Future<RespostaModel> finalizarContagem(ContagemModel contagem) async {
    try {
      await ApiService.dio.get(
        '/Contagem/${contagem.id}/finalizar',
      );
      return RespostaModel(
        status: true,
        mensagem: 'Contagem finalizada com sucesso',
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
