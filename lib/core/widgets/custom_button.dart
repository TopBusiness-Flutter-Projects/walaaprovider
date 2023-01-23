import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onClick,
    this.paddingHorizontal = 0,
    this.borderRadius = 8, required this.textcolor,
  }) : super(key: key);
  final String text;
  final Color color;
  final Color textcolor;
  final double paddingHorizontal;
  final VoidCallback onClick;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            maximumSize: Size.infinite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            minimumSize: const Size(double.infinity, 60),

            backgroundColor: color),
        child: Text(text,style: TextStyle(color: textcolor),),

      ),
    );
  }
}
