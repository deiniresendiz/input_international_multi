import 'dart:convert';

import 'package:flutter/cupertino.dart';

CountryModelInput countryModelFromJson(String str) => CountryModelInput.fromJson(json.decode(str));

String countryModelInputToJson(CountryModelInput data) => json.encode(data.toJson());

class CountryModelInput {
  CountryModelInput({
    this.numCode,
    this.isoCode,
    this.iso3Code,
    this.enShortName,
    this.nationality,
    this.phoneCode,
    this.nameTranslations,
    this.flag
  });

  String numCode;
  String isoCode;
  String iso3Code;
  String enShortName;
  String nationality;
  String phoneCode;
  String nameTranslations;
  String flag;

  factory CountryModelInput.fromJson(Map<String, dynamic> json) => CountryModelInput(
    numCode: json["num_code"],
    isoCode: json["iso_code"],
    iso3Code: json["iso_3_code"],
    enShortName: json["en_short_name"],
    nationality: json["nationality"],
    phoneCode: json["phone_code"],
    nameTranslations: json["nameTranslations"],
  );

  Map<String, dynamic> toJson() => {
    "num_code": numCode,
    "iso_code": isoCode,
    "iso_3_code": iso3Code,
    "en_short_name": enShortName,
    "nationality": nationality,
    "phone_code": phoneCode,
    "nameTranslations": nameTranslations,
  };

  String getFlag(){
    return 'assets/flags/${isoCode.toLowerCase()}.png';
  }

  String getName(Locale locale){
    if(locale == null){
      return enShortName;
    }else{
      return json.decode(nameTranslations)[locale.languageCode]??enShortName;
    }
  }

}

