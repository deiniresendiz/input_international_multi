import 'dart:convert';

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
    this.flag,
    this.nameTranslations,
  });

  String numCode;
  String alpha2Code;
  String alpha3Code;
  String enShortName;
  String nationality;
  String dialCode;
  String flag;
  NameTranslations nameTranslations;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    numCode: json["num_code"],
    alpha2Code: json["alpha_2_code"],
    alpha3Code: json["alpha_3_code"],
    enShortName: json["en_short_name"],
    nationality: json["nationality"],
    dialCode: json["dial_code"],
    flag: json["flag"],
    nameTranslations: NameTranslations.fromJson(json["nameTranslations"]),
  );

  Map<String, dynamic> toJson() => {
    "num_code": numCode,
    "alpha_2_code": alpha2Code,
    "alpha_3_code": alpha3Code,
    "en_short_name": enShortName,
    "nationality": nationality,
    "dial_code": dialCode,
    "flag": flag,
    "nameTranslations": nameTranslations.toJson(),
  };
}

class NameTranslations {
  NameTranslations();

  factory NameTranslations.fromJson(Map<String, dynamic> json) => NameTranslations(
  );

  Map<String, dynamic> toJson() => {
  };
}