import 'package:contei_app/data/models/resposta_model.dart';
import 'package:contei_app/data/services/login_service.dart';
import 'package:contei_app/data/services/prefs.dart';
import 'package:contei_app/ui/.core/widgets/custom_alert.dart';
import 'package:contei_app/ui/contagem/widgets/contagem_screen.dart';
import 'package:contei_app/ui/splash/widgets/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController {
  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  var isObscured = true.obs;
  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    String usuario = usuarioController.text;
    String senha = senhaController.text;

    RespostaModel resposta = await LoginService().login(usuario, senha);

    if (resposta.status) {
      isLoading.value = false;
      Get.offAll(() => ContagemScreen());
    } else {
      isLoading.value = false;
      CustomAlert().error(content: resposta.mensagem);
    }
  }

  Future<void> logout() async {
    await Prefs.deleteAll();
    Get.offAll(() => SplashScreen());
  }

  void toggleObscured() {
    isObscured.value = !isObscured.value;
  }
}