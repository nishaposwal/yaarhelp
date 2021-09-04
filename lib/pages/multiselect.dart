import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultuSelect extends StatefulWidget {
  // const MultuSelect({ Key? key }) : super(key: key);
  String heading;
  List<Map<String, dynamic>> list;
  List<Map<String, dynamic>> selectedValuse;
  MultuSelect({this.heading, this.list, this.selectedValuse, this.fn});
  Function(List<Map<String, dynamic>>) fn;
  @override
  _MultuSelectState createState() => _MultuSelectState();
}

class _MultuSelectState extends State<MultuSelect> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> test = widget.selectedValuse;
    print(test);
    print('lol12');
    print(widget.selectedValuse);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            widget.heading,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        MultiSelectDialogField(
          selectedColor: Colors.blue,
          itemsTextStyle: TextStyle(color: Colors.black),
          title: Text('select categotirs'),
          items: widget.list.map((e) => MultiSelectItem(e, e['name'])).toList(),
          listType: MultiSelectListType.LIST,
          onConfirm: (value) {
            widget.fn(value);
          },
        ),
      ],
    );
  }
}
