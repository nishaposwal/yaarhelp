import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  String value;
  String hint;
  List<String> itemsList;
  final void Function(String) onChanged;
  // DropDown({Key key, this.value, this.hint}) : super(key: key);
  DropDown({this.value, this.hint, this.itemsList, this.onChanged});
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey,
        )),
      ),
      child: DropdownButton<String>(
        elevation: 20,
        iconEnabledColor: Color(0xffB5EAEA),
        value: widget.value,
        isExpanded: true,
        underline: Container(
          height: 0,
          color: Colors.white,
        ),
        onChanged: (value) {
          widget.onChanged(value);
        },
        // (String newValue) {
        //   setState(() {
        //     widget.value = newValue;
        //   });
        // },
        hint: Text(
          widget.hint,
          style: TextStyle(color: Colors.grey[400]),
        ),
        items: widget.itemsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
    ;
  }
}
