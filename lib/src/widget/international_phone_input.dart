import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_international_multi/src/model/country_list.dart';
import 'package:input_international_multi/src/model/country_list_model.dart';

class InternationalPhoneInput extends StatefulWidget {
  final void Function(String phoneNumber, String internationalizedPhoneNumber,
      String isoCode, String dialCode) onPhoneNumberChange;
  final String initialPhoneNumber;
  final String initialSelection;
  final String errorText;
  final String hintText;
  final String labelText;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final int errorMaxLines;
  final List<String> enabledCountries;
  final InputDecoration decoration;
  final bool showCountryCodes;
  final bool showCountryFlags;
  final Widget dropdownIcon;
  final InputBorder border;

  InternationalPhoneInput(
      {this.onPhoneNumberChange,
        this.initialPhoneNumber,
        this.initialSelection,
        this.errorText,
        this.hintText,
        this.labelText,
        this.errorStyle,
        this.hintStyle,
        this.labelStyle,
        this.enabledCountries = const [],
        this.errorMaxLines,
        this.decoration,
        this.showCountryCodes = true,
        this.showCountryFlags = true,
        this.dropdownIcon,
        this.border});


  @override
  _InternationalPhoneInputState createState() =>
      _InternationalPhoneInputState();
}

class _InternationalPhoneInputState extends State<InternationalPhoneInput> {
  CountryModel selectedItem;


  String errorText;
  String hintText;
  String labelText;

  TextStyle errorStyle;
  TextStyle hintStyle;
  TextStyle labelStyle;

  int errorMaxLines;

  bool hasError = false;
  bool showCountryCodes;
  bool showCountryFlags;

  InputDecoration decoration;
  Widget dropdownIcon;
  InputBorder border;

  _InternationalPhoneInputState();

  final phoneTextController = TextEditingController();

  @override
  void initState() {
    errorText = widget.errorText ?? 'Please enter a valid phone number';
    hintText = widget.hintText ?? 'eg. 244056345';
    labelText = widget.labelText;
    errorStyle = widget.errorStyle;
    hintStyle = widget.hintStyle;
    labelStyle = widget.labelStyle;
    errorMaxLines = widget.errorMaxLines;
    decoration = widget.decoration;
    showCountryCodes = widget.showCountryCodes;
    showCountryFlags = widget.showCountryFlags;
    dropdownIcon = widget.dropdownIcon;

    phoneTextController.text = widget.initialPhoneNumber;


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            DropdownButtonHideUnderline(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: DropdownButton<CountryModel>(
                  value: selectedItem,
                  icon: Padding(
                    padding:
                    EdgeInsets.only(bottom: (decoration != null) ? 6 : 0),
                    child: dropdownIcon ?? Icon(Icons.arrow_drop_down),
                  ),
                  onChanged: (CountryModel newValue) {
                    setState(() {
                      selectedItem = newValue;
                    });
                  },
                  items: listCountryModel.map<DropdownMenuItem<CountryModel>>((CountryModel value) {
                    return DropdownMenuItem<CountryModel>(
                      value: value,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            if (showCountryFlags) ...[
                              Image.asset(
                                'assets/flags/${value.alpha2Code.toLowerCase()}.png',
                                width: 32.0,
                                height: 20,
                                //package: 'input_international_multi',
                              )
                            ],
                            if (showCountryCodes) ...[
                              SizedBox(width: 4),
                              Text(value.dialCode)
                            ]
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Flexible(
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneTextController,
                  decoration: decoration ??
                      InputDecoration(
                        hintText: hintText,
                        labelText: labelText,
                        errorText: hasError ? errorText : null,
                        hintStyle: hintStyle ?? null,
                        errorStyle: errorStyle ?? null,
                        labelStyle: labelStyle,
                        errorMaxLines: errorMaxLines ?? 3,
                        border: border ?? null,
                      ),
                ))
          ],
        ),
      ),
    );
  }
}
