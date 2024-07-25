import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(context) => ThemeData.light(
        useMaterial3: false,
      ).copyWith(
        primaryColor: AppColors.primaryColor,
        splashColor: AppColors.primaryColor.withOpacity(0.5),
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: Color(0xFFF3C04F),
          inactiveTrackColor: Color(0xFFFFE3A4),
          thumbColor: Color(0xFFF3C04F),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          errorMaxLines: 2,
          errorStyle: TextStyle(
            color: AppColors.errorRed,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.errorRed,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.errorRed,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          floatingLabelStyle: TextStyle(
            color: AppColors.mainBlack,
            fontWeight: FontWeight.w600,
          ),
          labelStyle: TextStyle(
            color: AppColors.mainBlack,
            fontWeight: FontWeight.w600,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          filled: true,
          fillColor: AppColors.lightGrey,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.mainBlack,
            fontSize: 16,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.mainBlack,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStateProperty.all(
              const BorderSide(
                color: AppColors.secondaryViolet,
                width: 1.5,
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              const Size(300, 50),
            ),
            foregroundColor: MaterialStateProperty.all(
              AppColors.secondaryViolet,
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(43),
                ),
              ),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(300, 50),
            ),
            maximumSize: MaterialStateProperty.all(
              const Size(400, 50),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return AppColors.secondaryViolet.withOpacity(0.5);
                } else {
                  return AppColors.secondaryViolet;
                }
              },
            ),
            foregroundColor: MaterialStateProperty.all(
              Colors.white,
            ),
            textStyle: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  );
                } else {
                  return TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  );
                }
              },
            ),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(43),
                ),
              ),
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.mainBlack,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      );

  static ThemeData darkTheme(context) => ThemeData.dark(
        useMaterial3: false,
      ).copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: Colors.grey.shade900,
        brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          labelStyle: TextStyle(),
        ),
        cardTheme: Theme.of(context).cardTheme.copyWith(
              color: Colors.grey.shade800,
            ),
        appBarTheme: AppBarTheme(
            color: Colors.transparent,
            titleTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white)),
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
        ),
      );
}
