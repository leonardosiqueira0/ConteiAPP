import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/ui/contagem_etiqueta/controller/contagem_etiqueta_cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContagemEtiquetaCadastro extends StatefulWidget {
  const ContagemEtiquetaCadastro({super.key, required this.contagem});

  final ContagemModel contagem;

  @override
  State<ContagemEtiquetaCadastro> createState() => _ContagemEtiquetaCadastroState();
}

class _ContagemEtiquetaCadastroState extends State<ContagemEtiquetaCadastro> {
  final controller = Get.find<ContagemEtiquetaCadastroController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.codigoFocusNode.requestFocus();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Escanear QR Code',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Para contar uma etiqueta, escaneie o QR Code e confirme a quantidade de pacotes.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: controller.qrCodeController,
                      focusNode: controller.codigoFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Código escaneado',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.qrCodeController.clear();
                          },
                        ),
                      ),
                      maxLength: 43,
                      onFieldSubmitted: (value) async {
                        await controller.buscarEtiqueta(contagem: widget.contagem);
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(Get.context!).bottom),
          ],
        ),
      ),
    );
  }
}