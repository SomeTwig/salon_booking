import 'package:flutter/material.dart';

import 'package:fl_booking_app/data/booking_data.dart';

import 'package:fl_booking_app/models/models.dart';
import 'package:fl_booking_app/data/db_helper.dart';
import 'package:fl_booking_app/data/data.dart';

class ConfirmedButtons extends StatefulWidget {
  final BookingData myBooking;

  const ConfirmedButtons({super.key, required this.myBooking});

  @override
  State<ConfirmedButtons> createState() => _ConfirmedButtonsState();
}

class _ConfirmedButtonsState extends State<ConfirmedButtons> {
  final List<String> entries = <String>[
    'Change booking time',
    'Edit services',
    'Cancel booking'
  ];

  late DatabaseHelper dbHelper;

  void initState() {
    super.initState();

    dbHelper = DatabaseHelper();
    dbHelper.initDatabase();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm cancellation'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Don`t cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes, cancel'),
              onPressed: () {
                dbHelper.deleteBooking(widget.myBooking);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topRight,
        child: FilledButton(
          child: const Text('Edit booking'),
          onPressed: () {
            showModalBottomSheet<void>(
              useRootNavigator:
                  true, // * set to "true" for the bottom sheet to cover the bottom navigation
              context: context,
              builder: (BuildContext context) {
                return Container(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 400),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                  child: Text(entries[index],
                                      style: TextStyle(fontSize: 16))),
                              Ink(
                                decoration: const ShapeDecoration(
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.navigate_next),
                                  iconSize: 32,
                                  color: Color.fromARGB(255, 132, 84, 0),
                                  onPressed: () {
                                    switch (index) {
                                      case 2:
                                        {
                                          Navigator.pop(context);
                                          _dialogBuilder(context);
                                        }
                                        break;
                                      default:
                                        {
                                          print("No implementation yet!");
                                        }
                                        break;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
