import 'package:contei_app/data/models/contagem_model.dart';
import 'package:contei_app/ui/.core/widgets/custom_alert.dart';
import 'package:contei_app/ui/contagem/controller/contagem_controller.dart';
import 'package:contei_app/ui/contagem_etiqueta/controller/contagem__etiqueta_controller.dart';
import 'package:contei_app/ui/contagem_etiqueta/widgets/contagem_etiqueta_cadastro.dart';
import 'package:contei_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContagemEtiquetaScreen extends StatefulWidget {
  const ContagemEtiquetaScreen({super.key, required this.contagem});
  final ContagemModel contagem;

  @override
  State<ContagemEtiquetaScreen> createState() => _ContagemEtiquetaScreenState();
}

class _ContagemEtiquetaScreenState extends State<ContagemEtiquetaScreen> {
  final controller = Get.find<ContagemEtiquetaController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.buscarContagemEtiquetas(exibirLoading: true, contagem: widget.contagem);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contagem.deposito,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          if (widget.contagem.status != 'Finalizado')
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                onTap: () {
                  CustomAlert().confirm(content: 'Tem certeza que deseja finalizar a contagem?', onConfirm: () {
                    Get.find<ContagemController>().finalizarContagem(widget.contagem);
                  });
                },
                child: const Text('Finalizar contagem'),
              ),
            ];
          }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.buscarContagemEtiquetas(exibirLoading: false, contagem: widget.contagem );
        },
        child: Obx(() {
          if (controller.contagemEtiquetas.isEmpty) {
            return Stack(
              children: [
                ListView(),
                const Center(
                  child: Text(
                    'Nenhum produto foi contado.\nClique no botão para começar a contar.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: controller.etiquetasAgrupadas.length,
            itemBuilder: (context, index) {
              final etiquetasAgrupadas = controller.etiquetasAgrupadas[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: primary,
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
                      title: Text(etiquetasAgrupadas['produto'].descricao ?? '', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
                      subtitle: Text(etiquetasAgrupadas['produto'].codigo ?? '', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 10),),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${etiquetasAgrupadas['quantidade'] ?? 0}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                          const Text(
                            'Pacotes contados',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: (widget.contagem.status != 'Finalizado') ? FloatingActionButton(
        onPressed: () async {
          await Get.to(() => ContagemEtiquetaCadastro(contagem: widget.contagem));
          controller.buscarContagemEtiquetas(exibirLoading: true, contagem: widget.contagem);
        },
        child: const Icon(Icons.barcode_reader),
      ) : null,
    );
  }
}
