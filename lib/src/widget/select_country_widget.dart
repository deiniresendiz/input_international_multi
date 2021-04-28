import 'package:flutter/material.dart';
import 'package:input_international_multi/src/model/country_list_model.dart';
import 'package:input_international_multi/src/model/country_model.dart';
import 'package:input_international_multi/src/widget/search_form_mini_widget.dart';

class SelectCountryWidget extends StatefulWidget {
  final Locale locale;
  final TextStyle textStyle;
  final Function(CountryModelInput) onChange;
  final String buttonOk;
  final String buttonCancel;
  final TextStyle textStyleTextButton;
  final ButtonStyle textStyleButton;
  final String textSearch;
  SelectCountryWidget(
      {this.locale,
        this.textStyle,
        this.onChange,
        this.buttonCancel = 'Cancel',
        this.buttonOk = 'Ok',
        this.textStyleButton,
        this.textStyleTextButton,
        this.textSearch
      });

  @override
  _SelectCountryWidgetState createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  List<CountryModelInput> _listData = listCountryModel;


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
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
                child: SearchFormMiniWidget(
                  hintText: widget.textSearch,
                  onChange: (value) {
                    _searchData(value: value);
                  },
                  onSearch: (ban) {
                    if (!ban) {
                      setState(() {
                        _listData = listCountryModel;
                      });
                    }
                  },
                )),
            Expanded(
              child: ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _listData.length,
                  itemBuilder: _itemList),
            ),
            _btnActions(context)
          ],
        ),
      ),
    );
  }

  Widget _itemList(BuildContext context, int index) {
    CountryModelInput item = _listData[index];
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        height: 32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              item.getFlag(),
              width: 24,
              height: 20,
              fit: BoxFit.contain,
              //package: 'input_international',
            ),
            SizedBox(
              width: 8,
            ),
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
      onTap: () {
        if(widget.onChange != null)
          widget.onChange(item);
          Navigator.of(context).pop();
      },
    );
  }


  void _searchData({String value}) {
    setState(() {
      if (value != null) {
        if (value.length != 0) {
          _listData = listCountryModel
              .where((country) => (country.enShortName
              .toLowerCase()
              .contains(value.toLowerCase()) ||
              country
                  .getName(widget.locale)
                  .toLowerCase()
                  .contains(value.toLowerCase())))
              .toList();
        } else {
          _listData = listCountryModel;
        }
      }
    });
    setState(() {});
  }

  Widget _btnActions(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      alignment: Alignment.centerRight,
      height: 40,
      child: TextButton(
        style: widget.textStyleButton,
        child: Text(
          widget.buttonCancel??'Cancel',
          style: widget.textStyleTextButton,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
