import 'dart:convert';

import 'package:flutter/cupertino.dart';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.numCode,
    this.alpha2Code,
    this.alpha3Code,
    this.enShortName,
    this.nationality,
    this.dialCode,
    this.nameTranslations,
  });

  String numCode;
  String alpha2Code;
  String alpha3Code;
  String enShortName;
  String nationality;
  String dialCode;
  String nameTranslations;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    numCode: json["num_code"],
    alpha2Code: json["alpha_2_code"],
    alpha3Code: json["alpha_3_code"],
    enShortName: json["en_short_name"],
    nationality: json["nationality"],
    dialCode: json["dial_code"],
    nameTranslations: json["nameTranslations"],
  );

  Map<String, dynamic> toJson() => {
    "num_code": numCode,
    "alpha_2_code": alpha2Code,
    "alpha_3_code": alpha3Code,
    "en_short_name": enShortName,
    "nationality": nationality,
    "dial_code": dialCode,
    "nameTranslations": nameTranslations,
  };

  String getName(Locale locale){
    if(locale == null){
      return enShortName;
    }else{
      return 'pendiente';
    }
  }

}

