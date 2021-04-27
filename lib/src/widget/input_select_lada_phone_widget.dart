import 'package:flutter/material.dart';
import 'package:input_international_multi/src/model/country_list_model.dart';

class InputSelectLadaPhoneWidget extends StatefulWidget {
  final String lada;
  final Function(String) onChange;
  final Function(CountryModel) onChangeCountry;
  final TextStyle textStyle;
  final TextStyle textStyleLabel;
  final TextStyle textStyleText;
  final bool enable;
  final String label;
  InputSelectLadaPhoneWidget({this.lada,this.onChange, this.textStyle, this.enable = true, this.label, this.textStyleText, this.textStyleLabel, this.onChangeCountry});
  @override
  _InputSelectLadaPhoneWidgetState createState() => _InputSelectLadaPhoneWidgetState();
}

class _InputSelectLadaPhoneWidgetState extends State<InputSelectLadaPhoneWidget> {
  String _lada = '52';
  CountryModel _countryModel = new CountryModel();
  TextEditingController _controller = new TextEditingController();
  final OutlineInputBorder _noneInputBorderEnabled = OutlineInputBorder(
    borderSide: BorderSide(
        color: Color(0xff7B88A8)
    ),
  );

  @override
  void initState() {
    _countryModel = listCountryModel.firstWhere((country) => (country.dialCode == '+$_lada'));
    if(widget.lada != null)
      _countryModel = listCountryModel.firstWhere((country) => (country.dialCode == '+${widget.lada}'));
    _controller.text = _countryModel.dialCode.substring(1);
    if(widget.onChange != null)
      widget.onChange(_lada);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 40,
      child: TextField(
        onTap: (){
          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  SelectLadaPhoneWidget(
                    textStyleText: widget.textStyleText,
                    onChange: (country){
                      _countryModel = country;
                      _lada = _countryModel.dialCode.substring(1);
                      _controller.text  = _lada;
                      if(widget.onChange != null)
                        widget.onChange(_lada);
                      if(widget.onChangeCountry != null)
                        widget.onChangeCountry(_countryModel);
                    },
                  )));
        },
        controller: _controller,
        readOnly: true,
        enabled: widget.enable,
        style: widget.textStyle,
        decoration: InputDecoration(
          labelStyle: widget.textStyleLabel,
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffBCC4DA)
            ),
          ),
          enabledBorder: _noneInputBorderEnabled,
          errorBorder: _noneInputBorderEnabled,
          focusedBorder: _noneInputBorderEnabled,
          focusedErrorBorder: _noneInputBorderEnabled,
          border: _noneInputBorderEnabled,
          suffix: Image.asset(
            'assets/chevron-down.png',
            width: 20,
            height: 20,
            fit: BoxFit.contain,
            //package: 'input_international_multi',
          ),
          labelText: widget.label,
        ),
      ),
    );
  }
}

class SelectLadaPhoneWidget extends StatelessWidget {
  final TextStyle textStyleText;
  final Function(CountryModel) onChange;
  SelectLadaPhoneWidget({this.textStyleText, this.onChange});
  final List<CountryModel> _listData = listCountryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: _list(context),
          onTap: (){
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _list(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        width: 110,
        height: MediaQuery.of(context).size.height*0.9,
        child: ListView.builder(
          //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _listData.length,
            itemBuilder: _itemList
        ),
      ),
    );
  }

  Widget _itemList(BuildContext context, int index){
    CountryModel item = _listData[index];
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              item.getFlag(),
              width: 24,
              height: 20,
              fit: BoxFit.contain,
              //package: 'input_international_multi',
            ),
            SizedBox(width: 8,),
            Text(
              item.dialCode,
              style: textStyleText,
            )
          ],
        ),
      ),
      onTap: (){
        if(this.onChange != null)
          this.onChange(item);
        Navigator.pop(context);
      },
    );
  }
}

