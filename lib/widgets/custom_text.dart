import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/style.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  
  // name constructor that has a positional parameters with the text required
  // and the other parameters optional
  CustomText({@required this.text, this.size,this.color,this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: GoogleFonts.fredokaOne(fontSize: size ?? 16, color: color ?? black, fontWeight: weight ?? FontWeight.normal),
      textAlign: TextAlign.center,
    );
  }
}