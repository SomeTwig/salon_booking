import 'package:flutter/material.dart';
import 'package:fl_booking_app/models/models.dart';

import 'package:provider/provider.dart';

class TimeVariantBuilder extends StatefulWidget {
  final List<BookingVariant> bookingVarList;

  const TimeVariantBuilder({super.key, required this.bookingVarList});

  @override
  State<TimeVariantBuilder> createState() => _TimeVariantBuilderState();
}

class _TimeVariantBuilderState extends State<TimeVariantBuilder> {
  bool isShow = false;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          direction: Axis.vertical,
          spacing: 16,
          runSpacing: 16,
          children: List<Widget>.generate(
            widget.bookingVarList.length,
            (int index) {
              //print(value.length);
              String wTimeFrom = widget.bookingVarList[index].timeFrom.substring(
                  0, widget.bookingVarList[index].timeFrom.lastIndexOf(':'));
              String wTimeTo = widget.bookingVarList[index].timeTo.substring(
                  0, widget.bookingVarList[index].timeFrom.lastIndexOf(':'));
              return ChoiceChip(
                label: Text("$wTimeFrom - $wTimeTo"),
                showCheckmark: false,
                selected: index == _selectedIndex,
                onSelected: (bool selected) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Provider.of<BookingInfo>(context, listen: false)
                      .addTime("$wTimeFrom - $wTimeTo");
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
