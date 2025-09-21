import 'package:contei_app/data/models/contagem_etiqueta_model.dart';
import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/data/models/produto_model.dart';
import 'package:contei_app/data/services/contagem_service.dart';
import 'package:contei_app/ui/.core/widgets/custom_alert.dart';
import 'package:contei_app/ui/.core/widgets/custom_loading.dart';
import 'package:get/get.dart';

class ContagemEtiquetaController {
  RxList<ContagemEtiquetaModel> contagemEtiquetas = <ContagemEtiquetaModel>[].obs;
  RxList<Map<String, dynamic>> etiquetasAgrupadas = <Map<String, dynamic>>[].obs;

  Future<void> buscarContagemEtiquetas({bool exibirLoading = true, required ContagemModel contagem}) async {
    if (exibirLoading) {
      CustomLoading.minimal();
    }
    final resposta = await ContagemService().buscarContagensEtiquetas(contagem);
    if (resposta.status) {
      contagemEtiquetas.assignAll(resposta.data?.cast<ContagemEtiquetaModel>() ?? []);
      await agruparEtiquetas();
      if (exibirLoading) {
        Get.back();
      }
    } else {
      if (exibirLoading) {
        Get.back();
      }
      CustomAlert().error(content: resposta.mensagem);
    }
  }

  Future<void> agruparEtiquetas() async {
    final Map<String, Map<String, dynamic>> agrupamento = {};

    for (var contagemEtiqueta in contagemEtiquetas) {
      ProdutoModel? produto = contagemEtiqueta.etiqueta?.produto;
      final codigo = produto?.codigo ?? '';

      if (agrupamento.containsKey(codigo)) {
        agrupamento[codigo]!['quantidade'] += contagemEtiqueta.quantidade;
      } else {
        agrupamento[codigo] = {
          'produto': produto,
          'quantidade': contagemEtiqueta.quantidade,
        };
      }
    }

    etiquetasAgrupadas.assignAll(agrupamento.values.toList());
  }
}