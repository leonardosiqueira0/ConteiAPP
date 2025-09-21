import 'package:contei_app/ui/.core/widgets/custom_alert.dart';
import 'package:contei_app/ui/contagem/controller/contagem_controller.dart';
import 'package:contei_app/ui/contagem/widgets/contagem_cadastro.dart';
import 'package:contei_app/ui/contagem/widgets/contagem_historico_screen.dart';
import 'package:contei_app/ui/contagem_etiqueta/widgets/contagem_etiqueta_screen.dart';
import 'package:contei_app/ui/login/controller/login_controller.dart';
import 'package:contei_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContagemScreen extends StatefulWidget {
  const ContagemScreen({super.key});

  @override
  State<ContagemScreen> createState() => _ContagemScreenState();
}

class _ContagemScreenState extends State<ContagemScreen> {
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
          'Contagens Pendentes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(configUserModel!.name),
              accountEmail: Text(configUserModel!.usuario),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  configUserModel!.name.isNotEmpty
                      ? configUserModel!.name[0].toUpperCase()
                      : '',
                  style: const TextStyle(fontSize: 40.0),
                ),
              ),
              decoration: BoxDecoration(
                color: primary,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Histórico de Contagens'),
              onTap: () async {
                await Get.to(() => const ContagemHistoricoScreen());
                controller.buscarContagens(exibirLoading: true);
              },
            ),
            Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair do sistema'),
              onTap: () async {
                 CustomAlert().confirm(content: 'Tem certeza que deseja sair do sistema?', onConfirm: () {
                    Get.find<LoginController>().logout();
                  });
              },
            ),
          ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => const ContagemCadastro());
          debugPrint('Retornou da tela de cadastro');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
