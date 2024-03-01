import 'package:flutter/material.dart';

class MyServicesList extends StatefulWidget {
  const MyServicesList({Key? key}) : super(key: key);

  @override
  State<MyServicesList> createState() => _MyServicesListState();
}

class _MyServicesListState extends State<MyServicesList> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Services'),
      trailing: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 221, 182),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Icon(
          size: 24,
          _customTileExpanded
              ? Icons.arrow_drop_up_outlined
              : Icons.arrow_drop_down_outlined,
        ),
      ),
      children: // change to ListView.Builder for real data
          const <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Service name'),
                  Text('123.00 USD'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('Service name'),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('123.00 USD',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('-12%'),
                        ],
                      ),
                    ],
                  ),
                  Text('123.00 USD'),
                ],
              ),
            ),
          ],
        ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }
}
