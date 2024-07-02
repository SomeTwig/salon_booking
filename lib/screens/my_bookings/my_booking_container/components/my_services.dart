import 'package:flutter/material.dart';

import 'package:fl_booking_app/models/models.dart';

class MyServicesList extends StatefulWidget {
  final List<FLService> myBookingServices;

  const MyServicesList({super.key, required this.myBookingServices});

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
        decoration: const BoxDecoration(
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
          <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.myBookingServices.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(widget.myBookingServices[index].serviceName)),
                  if (widget.myBookingServices[index].discountedPercent != 0)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                                widget.myBookingServices[index].discountedPrice
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(widget
                                .myBookingServices[index].discountedPercent
                                .toString()),
                          ],
                        ),
                      ],
                    ),
                  Text(
                      widget.myBookingServices[index].price.toStringAsFixed(2)),
                ],
              ),
            );
          },
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
