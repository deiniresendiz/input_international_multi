import 'package:flutter/material.dart';
import 'package:input_international_multi/src/model/country_list_model.dart';

class MultiSelectCountryWidget extends StatefulWidget {
  final Locale locale;
  final TextStyle textStyle;
  final List<CountryModel> listCountry;
  MultiSelectCountryWidget({this.locale, this.textStyle, this.listCountry});
  @override
  _MultiSelectCountryWidgetState createState() => _MultiSelectCountryWidgetState();
}

class _MultiSelectCountryWidgetState extends State<MultiSelectCountryWidget> {
  List<CountryModel> _listItems = [];

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
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          width: MediaQuery.of(context).size.width*0.8,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listCountryModel.length,
              itemBuilder: _itemList
          ),
        ),
      ),
    );
  }
  
  Widget _itemList(BuildContext context, int index){
    CountryModel item = listCountryModel[index];
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
        height: 32,
        child: Row(
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
      padding: EdgeInsets.only(bottom: 20),
      child: Icon(Icons.check, color: Colors.white,),
    );
  }
}
