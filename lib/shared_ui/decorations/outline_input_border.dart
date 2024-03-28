import 'package:flutter/material.dart';
import 'package:movie_app/shared_ui/colors/color.dart';

OutlineInputBorder get outlineInputBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: lightGreyColor.withOpacity(0.5),
      ),
    );
