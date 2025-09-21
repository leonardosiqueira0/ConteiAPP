import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/data/services/contagem_service.dart';
import 'package:contei_app/ui/.core/widgets/custom_alert.dart';
import 'package:contei_app/ui/.core/widgets/custom_loading.dart';
import 'package:get/get.dart';

class ContagemController {
  RxList<ContagemModel> contagens = <ContagemModel>[].obs;

  Future<void> buscarContagens({bool exibirLoading = true, String? status}) async {
    if (exibirLoading) {
      CustomLoading.minimal();
    }
    final resposta = ContagemService().buscarContagens(status);
    resposta.then((value) {
      if (value.status) {
        contagens.assignAll(value.data?.cast<ContagemModel>() ?? []);
        if (exibirLoading) {
          Get.back();
        }
      } else {
        if (exibirLoading) {
          Get.back();
        }
        CustomAlert().error(content: value.mensagem);
      }
    });
  }
  
  Future<void> finalizarContagem(ContagemModel contagem) async {
    CustomLoading.minimal();
    final resposta = ContagemService().finalizarContagem(contagem);
    resposta.then((value) {
      if (value.status) {
        Get.back();
        Get.back();
      } else {
        Get.back();
        CustomAlert().error(content: value.mensagem);
      }
    });
  }
}