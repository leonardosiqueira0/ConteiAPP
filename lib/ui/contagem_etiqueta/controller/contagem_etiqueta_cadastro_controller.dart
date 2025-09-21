
import 'package:contei_app/data/models/contagem_etiqueta_model.dart';
import 'package:contei_app/data/models/etiqueta_model.dart';
import 'package:contei_app/data/services/contagem_service.dart';
import 'package:contei_app/data/services/etiqueta_service.dart';
import 'package:contei_app/ui/.core/widgets/custom_alert.dart';
import 'package:contei_app/ui/.core/widgets/custom_button.dart';
import 'package:contei_app/ui/.core/widgets/custom_loading.dart';
import 'package:contei_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/contagem_model.dart';

class ContagemEtiquetaCadastroController {
  TextEditingController qrCodeController = TextEditingController();
  final FocusNode codigoFocusNode = FocusNode();

  Future<void> buscarEtiqueta({required ContagemModel contagem}) async {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    CustomLoading.minimal(clicarFora: true);
    EtiquetaModel? etiquetaModel;
    TextEditingController quantidadeController = TextEditingController();

    final respostaEtiqueita = await EtiquetaService().buscarEtiquetaPorQrCode(
      qrCodeController.text,
      contagem,
    );
    if (respostaEtiqueita.status) {
      etiquetaModel = respostaEtiqueita.data?[0]['etiqueta'] as EtiquetaModel?;
    } else {
      qrCodeController.clear();
      Get.back();
      await CustomAlert().error(content: 'Etiqueta não encontrada ou já foi contada');
      codigoFocusNode.requestFocus();
      return;
    }

    quantidadeController.text = etiquetaModel!.quantidadePallet.toString();
    Get.back(); // Fecha o loading

    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${etiquetaModel?.produto.descricao}',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 10),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Código da ordem: ${etiquetaModel?.numeroDocumento}',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'Código da etiqueta: ${etiquetaModel?.sequencialEtiqueta}',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: quantidadeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantidade de pacotes',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        content: 'Cancelar',
                        onTap: () {
                          Navigator.of(context).pop();
                          qrCodeController.clear();
                          codigoFocusNode.requestFocus();
                        },
                        color: Colors.red.shade400,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        content: 'Confirmar',
                        onTap: () async {
                          await contar(
                            contagem: contagem,
                            quantidade: int.parse(quantidadeController.text),
                            etiquetaModel: etiquetaModel!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> contar({
    required ContagemModel contagem,
    required int quantidade,
    required EtiquetaModel etiquetaModel,
  }) async {
    ContagemEtiquetaModel contagemEtiquetaModel = ContagemEtiquetaModel(
      id: Uuid().v4(),
      contagemID: contagem.id,
      data: DateTime.now(),
      etiquetaID: etiquetaModel.etiquetaID,
      etiqueta: etiquetaModel,
      quantidade: quantidade,
      usuarioID: configUserModel!.sapID,
      status: true,
    );

    final resposta = await ContagemService().criarContagemEtiqueta(
      contagemEtiquetaModel,
    );
    if (resposta.status) {
      Get.back();
      CustomAlert().successSnack(resposta.mensagem);
      qrCodeController.clear();
      codigoFocusNode.requestFocus();
    } else {
      Get.back();
      await CustomAlert().error(content: resposta.mensagem);
      codigoFocusNode.requestFocus();
    }
  }
}
