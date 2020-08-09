import 'package:flutter/material.dart';

Animatable<Color> bgTween = TweenSequence<Color>([
  TweenSequenceItem(
      tween: ColorTween(begin: Color(0xffc4fb6d), end: Color(0xffe84a5f)),
      weight: 1.0)
]);
