import 'package:flutter/material.dart';
import 'package:input_international_multi/src/model/country_list_model.dart';
import 'package:input_international_multi/src/widget/search_form_mini_widget.dart';

class MultiSelectCountryWidget extends StatefulWidget {
  final Locale locale;
  final TextStyle textStyle;
  final List<CountryModel> listCountry;
  final Function(List<CountryModel>) onChange;
  final String buttonOk;
  final String buttonCancel;
  final TextStyle textStyleTextButton;
  final ButtonStyle textStyleButton;
  MultiSelectCountryWidget({this.locale, this.textStyle, this.listCountry, this.onChange, this.buttonCancel = 'Cancel', this.buttonOk = 'Ok', this.textStyleButton, this.textStyleTextButton});
  @override
  _MultiSelectCountryWidgetState createState() => _MultiSelectCountryWidgetState();
}

class _MultiSelectCountryWidgetState extends State<MultiSelectCountryWidget> {
  List<CountryModel> _listItems = [];
  List<CountryModel> _listData = listCountryModel;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.listCountry != null && widget.listCountry.isNotEmpty)
      _listItems.addAll(widget.listCountry);
    super.initState();
  }

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
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        width: MediaQuery.of(context).size.width*0.8,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                child: SearchFormMiniWidget(
                  onChange: (value){
                    _searchData(value: value);
                  },
                  onSearch: (ban){
                    if(!ban){
                      setState(() {
                        _listData = listCountryModel;
                      });
                    }
                  },
                )
            ),
            Expanded(
              child: ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _listData.length,
                  itemBuilder: _itemList
              ),
            ),
            _btnActions(context)
          ],
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
            _checkItem(
              active: (_listItems.isNotEmpty)?(_listItems.where((element) => (element.alpha3Code == item.alpha3Code)?true:false).isNotEmpty)?true:false:false
            ),
            SizedBox(width: 8,),
            Image.asset(
              item.getFlag(),
              width: 24,
              height: 20,
              fit: BoxFit.contain,
              //package: 'input_international_multi',
            ),
            SizedBox(width: 8,),
            Flexible(
              child: Text(
                item.getName(widget.locale),
                style: widget.textStyle,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      onTap: (){
        bool ban = (_listItems.isNotEmpty)?(_listItems.where((element) => (element.alpha3Code == item.alpha3Code)?true:false).isNotEmpty)?true:false:false;
        if(!ban){
          setState(() {
            _listItems.add(item);
          });
        }else{
          setState(() {
            _listItems.removeWhere((element) => (element.alpha3Code == item.alpha3Code)?true:false);
          });
        }
      },
    );
  }

  Widget _checkItem({bool active = false}){
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: active?Color(0xff6A35FF):Color(0xffD0BFFF)),
        color: active?Color(0xff6A35FF):Colors.white
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/check.png',
        width: 40,
        height: 40,
        fit: BoxFit.contain,
        //package: 'input_international_multi',
      ),
    );
  }

  void _searchData({String value}){

    setState(() {
      if(value != null){
        if(value.length != 0){
          _listData = listCountryModel.where((country) => (
              country.enShortName.toLowerCase().contains(value.toLowerCase())
                  ||
                  country.getName(widget.locale).toLowerCase().contains(value.toLowerCase())
          )
          ).toList();
        }else{
          _listData = listCountryModel;
        }
      }
    });
    setState(() {});
  }


  Widget _btnActions(BuildContext context){
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
            TextButton(
              style: widget.textStyleButton,
                child: Text(
                  widget.buttonCancel,
                  style: widget.textStyleTextButton,
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
            ),
          TextButton(
            style: widget.textStyleButton,
            child: Text(
              widget.buttonOk,
              style: widget.textStyleTextButton,
            ),
            onPressed: (){
              if(widget.onChange != null)
                widget.onChange(_listItems);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
