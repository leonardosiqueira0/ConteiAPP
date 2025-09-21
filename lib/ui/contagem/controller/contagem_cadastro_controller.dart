import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/data/models/resposta_model.dart';
import 'package:contei_app/data/services/contagem_service.dart';
import 'package:contei_app/ui/.core/widgets/custom_alert.dart';
import 'package:contei_app/ui/.core/widgets/custom_loading.dart';
import 'package:contei_app/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ContagemCadastroController {
  TextEditingController dataController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController depositoController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  DateTime? dataSelecionada;

  void selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataSelecionada ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dataSelecionada) {
      dataSelecionada = picked;
      dataController.text = "${Formatters.formatDateMinimal(picked)}";
    }
  }

  void limparCampos() {
    dataController.clear();
    descricaoController.clear();
    depositoController.clear();
    statusController.clear();
    dataSelecionada = null;
  }

  Future<void> criarContagem () async {
    CustomLoading.minimal();
    if (dataSelecionada == null || depositoController.text.isEmpty || descricaoController.text.isEmpty) {
      Get.back();
      CustomAlert().error(content: 'Por favor, preencha todos os campos.');
    }

    final modelo = ContagemModel(id: Uuid().v4(), data: dataSelecionada!, deposito: depositoController.text, descricao: descricaoController.text, status: 'Pendente');
    RespostaModel respostaModel = await ContagemService().criarContagem(modelo);
    if (respostaModel.status) {
      limparCampos();
      Get.back();
      Get.back();
      CustomAlert().successSnack('Contagem criada com sucesso!');
    } else {
      Get.back();
      CustomAlert().error(content: respostaModel.mensagem);
    }
  }

}