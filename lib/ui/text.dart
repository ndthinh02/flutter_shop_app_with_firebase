import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextStyle {
  TextStyle get titleText {
    return GoogleFonts.robotoMono(
        color: Colors.black, fontWeight: FontWeight.w800, fontSize: 23);
  }

  TextStyle get subText {
    return GoogleFonts.robotoMono(
        color: Colors.black, fontWeight: FontWeight.w700);
  }

  TextStyle get textListTile {
    return GoogleFonts.robotoMono(
        color: Colors.black, fontWeight: FontWeight.w600);
  }

  TextStyle get textButton {
    return GoogleFonts.robotoMono(
        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18);
  }

  TextStyle get subTextCartScreen {
    return GoogleFonts.robotoMono(
        color: Colors.black, fontWeight: FontWeight.w400);
  }

  TextStyle get textAppbar {
    return GoogleFonts.robotoMono(
        color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14);
  }

  TextStyle get textSeemore {
    return GoogleFonts.robotoMono(
        color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14);
  }

  TextStyle get textSeacrh {
    return GoogleFonts.robotoMono(
        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14);
  }

  TextStyle get textForgotPass {
    return GoogleFonts.robotoMono(
        color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14);
  }

  TextStyle get textPrice {
    return GoogleFonts.robotoMono(
      color: Colors.red,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }

  TextStyle get textPriceTotal {
    return GoogleFonts.robotoMono(
      color: Colors.red,
      fontWeight: FontWeight.w800,
      fontSize: 14,
    );
  }

  TextStyle get textMainRegister {
    return GoogleFonts.robotoMono(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontSize: 24,
    );
  }

  TextStyle get textSubRegister {
    return GoogleFonts.robotoMono(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontSize: 16,
    );
  }

  TextStyle get textPriceDetail {
    return GoogleFonts.robotoMono(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontSize: 14,
    );
  }

  TextStyle get textPriceOld {
    return GoogleFonts.robotoMono(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        decoration: TextDecoration.lineThrough);
  }

  TextStyle get textAddcart {
    return GoogleFonts.robotoMono(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 16,
    );
  }

  TextStyle get textTitileLogin {
    return GoogleFonts.roboto(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontSize: 24,
    );
  }

  TextStyle get textSubLogin {
    return GoogleFonts.roboto(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );
  }

  TextStyle get textLogin {
    return GoogleFonts.roboto(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );
  }
}
