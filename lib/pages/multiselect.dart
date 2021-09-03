import 'package:flutter/material.dart';

class MultuSelect extends StatefulWidget {
  // const MultuSelect({ Key? key }) : super(key: key);
  String heading;
  List<Map<String, dynamic>> list;
  MultuSelect({this.heading, this.list});
  @override
  _MultuSelectState createState() => _MultuSelectState();
}

class _MultuSelectState extends State<MultuSelect> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            widget.heading,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          height: 300,
          child: SingleChildScrollView(
            child: Material(
              elevation: 10,
              child: SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('All'),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    widget.list.length,
                    (int index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        // All rows will have the same selected color.
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08);
                        }
                        // Even rows will have a grey color.
                        if (index.isEven) {
                          return Colors.grey.withOpacity(0.3);
                        }
                        return null; // Use default value for other states and odd rows.
                      }),
                      cells: <DataCell>[
                        DataCell(Text(widget.list[index]['name']))
                      ],
                      selected: widget.list[index]['selected'],
                      onSelectChanged: (bool value) {
                        setState(() {
                          widget.list[index]['selected'] = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
