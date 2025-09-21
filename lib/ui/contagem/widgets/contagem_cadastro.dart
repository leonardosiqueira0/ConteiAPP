import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/ui/.core/widgets/custom_button.dart';
import 'package:contei_app/ui/contagem/controller/contagem_cadastro_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContagemCadastro extends StatefulWidget {
  const ContagemCadastro({super.key, this.contagemModel});
  final ContagemModel? contagemModel;
  @override
  State<ContagemCadastro> createState() => _ContagemCadastroState();
}

class _ContagemCadastroState extends State<ContagemCadastro> {
  final controller = Get.find<ContagemCadastroController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Contagem', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Preencha os campos abaixo para cadastrar uma nova contagem.', style: TextStyle(fontSize: 12, color: Colors.grey.shade600), textAlign: TextAlign.center,),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.dataController,
                    readOnly: true,
                    onTap: () => controller.selecionarData(context),
                    decoration: const InputDecoration(
                      labelText: 'Data',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.date_range),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.depositoController,
                    decoration: const InputDecoration(
                      labelText: 'Depósito',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.store),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.descricaoController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 2,
                    
                  ),
                  const SizedBox(height: 8),
                  if (widget.contagemModel != null)
                  TextField(
                    controller: controller.statusController,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.info),
                    ),
                  ),
                ],
              ),
            )),
            CustomButton(content: 'Salvar', onTap: () async {
              await controller.criarContagem();
            }),
            SizedBox(height: MediaQuery.paddingOf(context).bottom),
          ],
        ),
      ),
    );
  }
}