import 'package:flutter/material.dart';
import 'package:contei_app/utils/config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.content,
    required this.onTap,
    this.color,
  });

  final String content;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          decoration: BoxDecoration(
            color: color ?? primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              content,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textScaler: TextScaler.linear(1.2),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    required this.onTap,
    this.color,
    required this.icon,
  });

  final Icon icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          decoration: BoxDecoration(
            color: color ?? primary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: 
              icon,
              
          ),
        ),
      ),
    );
  }
}

