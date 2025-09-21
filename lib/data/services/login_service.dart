import 'dart:convert';

import 'package:contei_app/data/models/resposta_model.dart';
import 'package:contei_app/data/models/usuario_model.dart';
import 'package:contei_app/data/services/api_service.dart';
import 'package:contei_app/data/services/prefs.dart';
import 'package:contei_app/utils/config.dart';
import 'package:dio/dio.dart';

class LoginService {
  Future<RespostaModel> login(String username, String password) async {
    try {
      final response = await ApiService.dio.post(
        '/login',
        data: {'user': username, 'password': password},
      );

      await Prefs.saveString('accessToken', response.data['accessToken']);
      await Prefs.saveString('refreshToken', response.data['refreshToken']);
      await Prefs.saveString('usuario', jsonEncode(response.data['user']));
      var userJson = await Prefs.getString('usuario');
      configUserModel = UsuarioModel.fromJson(jsonDecode(userJson));

      return RespostaModel(
        status: true,
        mensagem: 'Login realizado com sucesso',
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
