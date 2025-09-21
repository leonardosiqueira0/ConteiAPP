import 'package:contei_app/ui/.core/widgets/custom_button.dart';
import 'package:contei_app/ui/login/controller/login_controller.dart';
import 'package:contei_app/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final controller = Get.find<LoginController>();


    buildHeader() {
      return Column(
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          Image.asset('images/logo.png', height: size.width * 0.4),
          Column(
            children: [
              SizedBox(height: size.height * 0.01),
              Text(
                'Contei App',
                textScaler: TextScaler.linear(1.7),
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Entre com seu usuário e senha',
                textScaler: TextScaler.linear(1.2),
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      );
    }

    buildInputs() {
      return Column(
        children: [
          TextField(
            controller: controller.usuarioController,
            decoration: InputDecoration(labelText: 'Usuário'),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
              Formatters.toLower(),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Obx(() => TextField(
            controller: controller.senhaController,
            obscureText: controller.isObscured.value,
            decoration: InputDecoration(labelText: 'Senha', suffixIcon: IconButton(
              icon: Icon(controller.isObscured.value ? Icons.visibility_off : Icons.visibility),
              onPressed: controller.toggleObscured,
            )),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
          ),)
        ],
      );
    }

    buildButton() {
      return Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return CustomButton(content: 'Entrar', onTap: controller.login);
        }
      });
    }

    buildFooter() {
      return Column(
        children: [
          SizedBox(height: size.height * 0.02),
          Text(
            'Esse aplicativo foi desenvolvido por Leonardo Siqueira.',
            textScaler: TextScaler.linear(1),
            style: TextStyle(fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeader(),
                      SizedBox(height: 12),
                      buildInputs(),
                      SizedBox(height: 12),
                      buildButton(),
                      SizedBox(height: 12),
                      buildFooter(),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.paddingOf(context).bottom),
                SizedBox(height: 8)
              ],
            ),
          ),
        )
    );
  }
}