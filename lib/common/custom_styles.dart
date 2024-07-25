import 'package:another_xlider/enums/tooltip_direction_enum.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:another_xlider/models/tooltip/tooltip.dart';
import 'package:another_xlider/models/tooltip/tooltip_box.dart';
import 'package:another_xlider/models/tooltip/tooltip_position_offset.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pinput.dart';

import '../presentation/theme/app_colors.dart';

final baseTextStyle = GoogleFonts.poppins(
  fontSize: 12,
);
final baseTextStyle24600 = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
final baseTextStyle12400 = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);
final baseTextStyle12600 = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w600,
);
final baseTextStyle12700 = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w700,
);
final baseTextStyle16500 = GoogleFonts.poppins(
  fontSize: 16,
);
final baseTextStyle12500 = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);
final baseTextStyle1 = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w400,
);
final baseTextStyle10400 = GoogleFonts.poppins(
  fontSize: 10,
  fontWeight: FontWeight.w400,
);
final baseTextStyle10500 = GoogleFonts.poppins(
  fontSize: 10,
);

final baseTextStyle32500 = GoogleFonts.poppins(
  fontSize: 32,
  fontWeight: FontWeight.w500,
);
final baseTextStyle2 = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
final baseTextStyle20400 = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w400,
);
final baseTextStyle21500 = GoogleFonts.poppins(
  fontSize: 21,
);
final baseTextStyle18500 = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
final baseTextStyle3 = GoogleFonts.poppins(
  fontSize: 32,
  fontWeight: FontWeight.w500,
);
final baseTextStyle14600 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
final baseTextStyle24500 = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: FontWeight.w500,
);
final baseTextStyle14400 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
final baseTextStyle14500 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

final baseTextStyle10600 = GoogleFonts.poppins(
  fontSize: 10,
  fontWeight: FontWeight.w600,
);
final baseTextStyle16400 = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

BoxDecoration orderBoxDecoration(String type) {
  switch (type.toLowerCase()) {
    case ('completed' || 'sip'):
      return BoxDecoration(
        color: const Color(0xFFEDFBF6),
        borderRadius: BorderRadius.circular(200),
      );
    case ('in-progress'):
      return BoxDecoration(
        color: const Color(0xFFFEF7E8),
        borderRadius: BorderRadius.circular(200),
      );
    case ('lumpsum'):
      return BoxDecoration(
        color: const Color(0xFFEBF0FE),
        borderRadius: BorderRadius.circular(200),
      );
    default:
      return BoxDecoration(
        color: const Color(0xFFFAEBEB),
        borderRadius: BorderRadius.circular(200),
      );
  }
}

TextStyle orderTextStyle(String type) {
  switch (type.toLowerCase()) {
    case ('completed' || 'sip'):
      return const TextStyle(
        color: Color(0xFF43B649),
        fontSize: 12,
      );
    case ('in-Progress'):
      return const TextStyle(
        color: Color(0xFFF2AF1A),
        fontSize: 12,
      );
    case ('lumpsum'):
      return const TextStyle(
        color: Color(0xFF297DFD),
        fontSize: 12,
      );
    default:
      return const TextStyle(
        color: Color(0xFFCC3A3A),
        fontSize: 12,
      );
  }
}

class CustomStyles {
  static BoxDecoration get kycUploadDecoration => BoxDecoration(
        border: Border.all(color: const Color(0xFFB0B0B0), width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      );

  static PinTheme get defaultLoginPinTheme => PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static PinTheme get errorLoginPinTheme => defaultPinTheme.copyWith(
        height: 56,
        width: 56,
        textStyle: const TextStyle(
          fontSize: 20,
          color: AppColors.errorRed,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static PinTheme get focusedLoginPinTheme => PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.25),
              blurRadius: 12,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static PinTheme get followingLoginPinTheme => PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: AppColors.neutral[50],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static PinTheme get defaultPinTheme => PinTheme(
        width: 42,
        height: 42,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static PinTheme get errorPinTheme => defaultPinTheme.copyWith(
        textStyle: const TextStyle(
            color: AppColors.errorRed, fontWeight: FontWeight.bold),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.errorRed.withOpacity(0.25),
              blurRadius: 12,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static PinTheme get focusedPinTheme => PinTheme(
        width: 42,
        height: 42,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.25),
              blurRadius: 12,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static PinTheme get followingPinTheme => PinTheme(
        width: 42,
        height: 42,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: AppColors.neutral[50],
          borderRadius: BorderRadius.circular(10),
        ),
      );

  static Widget get pinPutCursor => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 21,
          height: 1,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(137, 146, 160, 1),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  static InputDecoration get dropDownDecoration => const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        suffixIcon: Icon(Icons.keyboard_arrow_down),
      );
  static InputDecoration get contactUsDropdownDecoration => InputDecoration(
        hintText: 'Tell us about your concern',
        hintStyle: TextStyle(fontSize: 12, color: AppColors.neutral[200]),
        fillColor: Colors.white,
        focusColor: AppColors.primary[500],
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: AppColors.primary[50] ?? Colors.white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: AppColors.primary[50] ?? Colors.white)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary[50] ?? Colors.white),
        ),
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
      );

  static FlutterSliderHandler get flutterSliderHandler => FlutterSliderHandler(
        child: const SizedBox.shrink(),
        decoration: const BoxDecoration(
          color: AppColors.yellowPrimary,
          shape: BoxShape.circle,
        ),
      );

  static FlutterSliderTrackBar get flutterSliderTrackbar =>
      const FlutterSliderTrackBar(
        activeTrackBar: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFF3C04F),
        ),
        inactiveTrackBar: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xFFFFE3A4),
        ),
        activeTrackBarHeight: 4,
        inactiveTrackBarHeight: 4,
      );

  static FlutterSliderTooltip get flutterSliderTooltip => FlutterSliderTooltip(
        alwaysShowTooltip: true,
        custom: (value) => Text(
          '\u20b9 ${NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 0).format(value)}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        boxStyle: const FlutterSliderTooltipBox(decoration: null),
        direction: FlutterSliderTooltipDirection.top,
        positionOffset: FlutterSliderTooltipPositionOffset(top: -10),
      );

  static List<BoxShadow> defaultCardShadow({double blurRad = 8}) => [
        BoxShadow(
            spreadRadius: 0,
            blurRadius: blurRad,
            color: const Color(0XFF000000).withOpacity(0.08))
      ];
}
