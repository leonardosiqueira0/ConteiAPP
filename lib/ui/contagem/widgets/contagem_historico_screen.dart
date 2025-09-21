import 'package:contei_app/ui/contagem/controller/contagem_controller.dart';
import 'package:contei_app/ui/contagem_etiqueta/widgets/contagem_etiqueta_screen.dart';
import 'package:contei_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContagemHistoricoScreen extends StatefulWidget {
  const ContagemHistoricoScreen({super.key});

  @override
  State<ContagemHistoricoScreen> createState() => _ContagemHistoricoScreenState();
}

class _ContagemHistoricoScreenState extends State<ContagemHistoricoScreen> {
  final controller = Get.find<ContagemController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscarContagens(exibirLoading: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histórico de Contagens',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.buscarContagens(exibirLoading: true);
        },
        child: Obx(() {
          if (controller.contagens.isEmpty) {
            return Stack(
              children: [
                ListView(),
                const Center(
                  child: Text(
                    'Não há contagens disponíveis.\nClique no botão "+" para adicionar uma nova contagem.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: controller.contagens.length,
            itemBuilder: (context, index) {
              final contagem = controller.contagens[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: contagem.status == 'Finalizado' ? Colors.green : primary,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                      color: Colors.white
                    ),
                    child: ListTile(
                      title: Text(contagem.deposito),
                      subtitle: Text(contagem.descricao),
                      onTap: () async {
                        await Get.to(() => ContagemEtiquetaScreen(contagem: contagem));
                        controller.buscarContagens(exibirLoading: true);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
