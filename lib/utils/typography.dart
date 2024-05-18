import 'package:flutter/material.dart';

import 'colors.dart' as AppColor;

const String _fontLato = 'Lato';

// textSizeSmall = 12.0;
// textSizeSMedium = 14.0;
// textSizeMedium = 16.0;
// textSizeLargeMedium = 18.0;
// textSizeNormal = 20.0;
// textSizeLarge = 24.0;
// textSizeXLarge = 30.0;
// textSizeTitle = 34.0;

//Font Lato
const TextStyle LatoBold = TextStyle(
  fontFamily: _fontLato,
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  color: AppColor.textPrimary,
);

const TextStyle body1Lato = TextStyle(
  fontFamily: _fontLato,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: AppColor.textPrimary,
);

const TextStyle body2Lato = TextStyle(
  fontFamily: _fontLato,
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  color: AppColor.textPrimary,
);

TextStyle body2LatoAccent = body2Lato.copyWith(color: AppColor.textSecondary);
