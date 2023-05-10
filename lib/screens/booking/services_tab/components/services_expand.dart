import 'package:flutter/material.dart';

import 'package:test_1/data/data.dart';
import 'package:test_1/screens/booking/services_tab/components/service_container.dart';

class ExpansionTileServices extends StatefulWidget {
  const ExpansionTileServices({super.key});

  @override
  State<ExpansionTileServices> createState() => _ExpansionTileServicesState();
}

class _ExpansionTileServicesState extends State<ExpansionTileServices> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          "Руки",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: flSalon.length,
            itemBuilder: (BuildContext context, int index) {
              return ServiceContainer(
                serviceList: servicesList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
