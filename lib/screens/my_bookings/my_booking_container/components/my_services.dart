import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/data/db_helper.dart';
import 'package:fl_booking_app/data/data.dart';
import 'package:fl_booking_app/data/booking_data.dart';

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
          <Widget>[
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.myBookingServices.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                style: TextStyle(
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
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Expanded(
        //               child: Text(widget.myBookingServices.first.serviceName)),
        //           if (widget.myBookingServices.first.discountedPercent != 0)
        //             Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: <Widget>[
        //                 Row(
        //                   children: <Widget>[
        //                     Text(
        //                         widget.myBookingServices.first.discountedPrice
        //                             .toStringAsFixed(2),
        //                         style: TextStyle(
        //                             decoration: TextDecoration.lineThrough)),
        //                   ],
        //                 ),
        //                 Row(
        //                   children: <Widget>[
        //                     Text(widget
        //                         .myBookingServices.first.discountedPercent
        //                         .toString()),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           Text(widget.myBookingServices.first.price.toStringAsFixed(2)),
        //         ],
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         crossAxisAlignment: CrossAxisAlignment.baseline,
        //         textBaseline: TextBaseline.alphabetic,
        //         children: [
        //           Text('Service name'),
        //           Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               Row(
        //                 children: <Widget>[
        //                   Text('123.00 USD',
        //                       style: TextStyle(
        //                           decoration: TextDecoration.lineThrough)),
        //                 ],
        //               ),
        //               Row(
        //                 children: <Widget>[
        //                   Text('-12%'),
        //                 ],
        //               ),
        //             ],
        //           ),
        //           Text('123.00 USD'),
        //         ],
        //       ),
        //     ),
        //     ],
        //   ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _customTileExpanded = expanded;
        });
      },
    );
  }
}
