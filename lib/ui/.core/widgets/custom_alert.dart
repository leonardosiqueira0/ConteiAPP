import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/utils/config.dart';
import '/ui/.core/widgets/custom_button.dart';

class CustomAlert {
  Future<void> error({required String content, String title = 'Erro'}) {
    return Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      radius: 10,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(20),
      content: Text(content, textAlign: TextAlign.center),
      barrierDismissible: false,
      confirm: CustomButton(content: 'OK', onTap: () => Get.back()),
    );
  }

  confirm({
    required String content,
    String title = 'Atenção',
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Sim',
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      radius: 10,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(20),
      content: Text(content, textAlign: TextAlign.center),
      barrierDismissible: false,
      confirm: Container(
        width: MediaQuery.of(Get.context!).size.width - 40,
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                content: 'Cancelar',
                onTap: (onCancel != null) ? onCancel : () => Get.back(),
                color: Colors.red.shade400,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomButton(content: confirmText, onTap: onConfirm),
            ),
          ],
        ),
      ),
    );
  }

  confirmQuantidade({
    required String content,
    String title = 'Atenção',
    required int quantidade,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Sim',
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      radius: 10,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(20),
      content: Text(content, textAlign: TextAlign.center),
      barrierDismissible: false,
      confirm: Container(
        width: MediaQuery.of(Get.context!).size.width - 40,
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                content: 'Cancelar',
                onTap: (onCancel != null) ? onCancel : () => Get.back(),
                color: Colors.red.shade400,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: CustomButton(content: confirmText, onTap: onConfirm),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> dismissibleQuestion(
    context, {
    required String title,
    required String content,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Center(child: Text(title)),
        content: Text(content, textAlign: TextAlign.center),
        actions: [
          Container(
            width: MediaQuery.of(Get.context!).size.width - 40,
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    content: 'Cancelar',
                    onTap: () => Navigator.of(context).pop(false),
                    color: Colors.red.shade400,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    content: 'Confirmar',
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  errorSnack(String content) {
    return Get.snackbar(
      'Erro',
      content,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.red.shade400,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
    );
  }

  successSnack(String content) {
    Get.snackbar(
      'Sucesso',
      content,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.green.shade400,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
    );
  }
}
