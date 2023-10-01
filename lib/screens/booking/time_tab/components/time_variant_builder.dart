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
    final Size size = MediaQuery.of(context).size;
    return ListView.separated(
      itemCount: widget.bookingVarList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 1,
        color: Color.fromARGB(0, 255, 255, 255),
      ),
      itemBuilder: (context, index) {
        //print(value.length);
        String wTimeFrom = widget.bookingVarList[index].timeFrom.substring(
            0, widget.bookingVarList[index].timeFrom.lastIndexOf(':'));
        String wTimeTo = widget.bookingVarList[index].timeTo.substring(
            0, widget.bookingVarList[index].timeFrom.lastIndexOf(':'));
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          child: Material(
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text("$wTimeFrom - $wTimeTo"),
              selectedColor: Color.fromARGB(255, 7, 4, 4),
              selectedTileColor: Color.fromARGB(255, 198, 205, 220),
              selected: index == _selectedIndex,
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                Provider.of<BookingInfo>(context, listen: false)
                    .addTime("$wTimeFrom - $wTimeTo");
              },
            ),
          ),
        );
      },
    );
  }
}
