import 'package:flutter/material.dart';
import 'package:test_1/models/models.dart';

import 'package:test_1/data/data.dart';
import 'package:test_1/screens/booking/services_tab/services_add/components/service_container.dart';

class ExpansionTileServices extends StatefulWidget {
  const ExpansionTileServices({super.key});

  @override
  State<ExpansionTileServices> createState() => _ExpansionTileServicesState();
}

class _ExpansionTileServicesState extends State<ExpansionTileServices>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<ServiceList> serviceList = servicesList;
    var seen = Set<int>();
    for (var element in serviceList) {
      seen.add(element.lineOfBusinessId);
    }
    Map map = seen.toList().asMap();
    return Card(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: seen.length,
        itemBuilder: (BuildContext context, int index) {
          List<ServiceList> serviceLineList = serviceList.where((element) => element.lineOfBusinessId==map[index]).toList();
          return ExpansionTile(
            maintainState: true,
            title: Text(
              serviceLineList.first.lineOfBusiness,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serviceLineList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ServiceContainer(
                    service: serviceLineList[index],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
