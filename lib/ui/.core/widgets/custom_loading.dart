import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:contei_app/utils/config.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class CustomLoading {
  static Widget overlay() {
    return Container(
      width: MediaQuery.sizeOf(Get.context!).width,
      height: MediaQuery.sizeOf(Get.context!).height,
      color: Colors.white,
      child: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: primary,
          rightDotColor: secondary,
          size: 42,
        ),
      ),
    );
  }

  static minimal ({bool? clicarFora}) {
    Get.dialog(
      barrierDismissible: clicarFora ?? false,
        Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: BoxConstraints(
              maxWidth: 64,
              maxHeight: 64,
              minWidth: 64,
              minHeight: 64,
            ),
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(12),
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: primary,
                rightDotColor: secondary,
                size: 42,
              ),
            )
        ));
  }
}