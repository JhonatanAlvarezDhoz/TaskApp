import 'package:flutter/material.dart';

class NoneOutlineInputBorder extends OutlineInputBorder {
  NoneOutlineInputBorder()
      : super(
          borderSide: const NoneBorderSide(),
          borderRadius: BorderRadius.circular(10.0),
        );
}

class NoneBorderSide extends BorderSide {
  const NoneBorderSide()
      : super(
          color: Colors.white,
          width: 0,
          style: BorderStyle.none,
        );
}
