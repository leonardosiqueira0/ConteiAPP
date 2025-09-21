import 'dart:convert';
import 'package:contei_app/data/models/usuario_model.dart';
import 'package:contei_app/data/services/prefs.dart';
import 'package:contei_app/ui/contagem/widgets/contagem_screen.dart';
import 'package:contei_app/ui/login/widgets/login_screen.dart';
import 'package:contei_app/utils/config.dart';
import 'package:get/get.dart';

class SplashController {
  verificarLogin () async {
    final accessToken = await Prefs.getString('accessToken');
    final refreshToken = await Prefs.getString('refreshToken');
    final usuario = await Prefs.getString('usuario');

    if (accessToken != null && refreshToken != null && usuario != null) {
      configUserModel = UsuarioModel.fromJson(jsonDecode(usuario));
      Get.offAll(() => ContagemScreen());
    } else {
      Prefs.deleteAll();
      Get.offAll(() => LoginScreen());

    }
  }
}