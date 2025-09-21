import 'package:contei_app/ui/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300), () => Get.find<SplashController>().verificarLogin());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.3,
            ),
            SizedBox(height: 32,),
            CircularProgressIndicator(
              constraints: BoxConstraints(
                maxHeight: 32,
                maxWidth: 32,
                minHeight: 32,
                minWidth: 32
              ),
              strokeWidth: 3,
              strokeCap: StrokeCap.round,
            )
          ],
        ),
      ),
    );
  }
}