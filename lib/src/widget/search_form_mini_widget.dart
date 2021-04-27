import 'package:flutter/material.dart';

class SearchFormMiniWidget extends StatefulWidget {
  final Function(String) onChange;
  final Function(bool) onSearch;
  final String hintText;
  SearchFormMiniWidget({this.onChange, this.onSearch, this.hintText = 'Search...'});
  @override
  _SearchFormMiniWidgetState createState() => _SearchFormMiniWidgetState();
}

class _SearchFormMiniWidgetState extends State<SearchFormMiniWidget> {
  TextEditingController _editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
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
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
              child: Image.asset('assets/search.png', fit: BoxFit.contain)
          ),
          Flexible(
            child: TextField(
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
                hintText: widget.hintText,
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