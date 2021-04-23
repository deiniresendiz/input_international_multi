import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plerk_mobile/src/localizations/app_localizations.dart';

class SearchFormMiniWidget extends StatefulWidget {
  final Function(String) onChange;
  final Function(bool) onSearch;
  SearchFormMiniWidget({this.onChange, this.onSearch});
  @override
  _SearchFormMiniWidgetState createState() => _SearchFormMiniWidgetState();
}

class _SearchFormMiniWidgetState extends State<SearchFormMiniWidget> {
  TextEditingController _editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
          border: Border.all(
              color: Color(0xffBCC4DA),
              width: 1
          ),
          borderRadius: BorderRadius.circular(4),
          color: Colors.white
      ),
      padding: EdgeInsets.only(right: 8),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 6,horizontal: 4),
              child: SvgPicture.asset('assets/icons/search.svg', fit: BoxFit.contain)
          ),
          Flexible(
            child: AutoSizeTextField(
              onChanged: (value){
                if(this.widget.onChange != null){
                  if(_editingController.text.length <= 50){
                    this.widget.onChange(value);
                  }else{
                    String temp = _editingController.text.substring(0,_editingController.text.length-1);
                    this.widget.onChange(temp);
                    _editingController.text = temp;
                    _editingController.selection = TextSelection.fromPosition(TextPosition(offset: _editingController.text.length));
                  }
                }
              },
              controller: _editingController,
              textInputAction: TextInputAction.done,
              fullwidth: true,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Color(0xff182135),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 14
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                isCollapsed: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: AppLocalizations.of(context).translate('btn_search'),
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0xff7B88A8),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 14
                ),
              ),
            ),
          ),
          (_editingController.text.length != 0)?
          InkWell(
            child: Icon(Icons.close, color: Color(0xff7B88A8),size: 20,),
            onTap: (){
              setState(() {
                FocusScope.of(context).unfocus();
                _editingController.clear();
                if(widget.onSearch != null)
                  widget.onSearch(false);
              });
            },
          ):Container(width: 1,height: 1,)
        ],
      ),
    );
  }
}

//SvgPicture.asset('assets/icons/search.svg', fit: BoxFit.contain)