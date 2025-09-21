import 'package:contei_app/ui/contagem/controller/contagem_cadastro_controller.dart';
import 'package:contei_app/ui/contagem/controller/contagem_controller.dart';
import 'package:contei_app/ui/contagem_etiqueta/controller/contagem__etiqueta_controller.dart';
import 'package:contei_app/ui/contagem_etiqueta/controller/contagem_etiqueta_cadastro_controller.dart';
import 'package:contei_app/ui/login/controller/login_controller.dart';
import 'package:contei_app/ui/splash/controller/splash_controller.dart';
import 'package:contei_app/ui/splash/widgets/splash_screen.dart';
import 'package:contei_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    
    return GetMaterialApp(
      title: 'Contei App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'BR')],
      locale: const Locale('pt', 'BR'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          surfaceTintColor: primary,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(color: Colors.grey.shade600),
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        searchBarTheme: SearchBarThemeData(
          backgroundColor: WidgetStatePropertyAll(Colors.grey.shade100),
          elevation: WidgetStatePropertyAll(0),
          constraints: BoxConstraints(maxHeight: 40, minHeight: 40),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(),
          border: borderStyle(),
          focusedBorder: borderStyle(type: 'focused'),
          enabledBorder: borderStyle(),
          errorBorder: borderStyle(type: 'error'),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(),
            border: borderStyle(),
            focusedBorder: borderStyle(type: 'focused'),
            enabledBorder: borderStyle(),
            errorBorder: borderStyle(type: 'error'),
          ),
          menuStyle: MenuStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            backgroundColor: WidgetStateProperty.all(Colors.white),
            surfaceTintColor: WidgetStateProperty.all(Colors.grey.shade100),
            minimumSize: WidgetStateProperty.all(
              Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 6,
              ),
            ),
            maximumSize: WidgetStateProperty.all(
              Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 3,
              ),
            ),
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: primary,
          headerForegroundColor: Colors.white,
        ),
      ),
      home: const SplashScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(SplashController());
        Get.put(LoginController());
        Get.put(ContagemController());
        Get.put(ContagemCadastroController());
        Get.put(ContagemEtiquetaController());
        Get.put(ContagemEtiquetaCadastroController());
      }),
    );
  }
}

borderStyle({String type = 'default'}) {
  Color borderColor = Colors.grey.shade300;
  if (type == 'error') {
    borderColor = Colors.red;
  } else if (type == 'focused') {
    borderColor = primary;
  }
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(color: borderColor, width: 1.5),
  );
}
