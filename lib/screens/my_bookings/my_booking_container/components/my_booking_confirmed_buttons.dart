import 'package:flutter/material.dart';

class ConfirmedButtons extends StatefulWidget {
  const ConfirmedButtons({super.key});

  @override
  State<ConfirmedButtons> createState() =>
      _ConfirmedButtonsState();
}

class _ConfirmedButtonsState extends State<ConfirmedButtons> {

  final List<String> entries = <String>[
    'Change booking time',
    'Edit services',
    'Cancel booking'
  ];

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
                                  onPressed: () {},
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
