import 'package:flutter/material.dart';
import 'package:test_1/models/models.dart';
import 'package:http/http.dart' as http;

import 'package:test_1/data/data.dart';
import 'package:test_1/screens/booking/services_tab/services_add/components/service_add_container.dart';

class ExpansionTileServices extends StatefulWidget {
  const ExpansionTileServices({super.key});

  @override
  State<ExpansionTileServices> createState() => _ExpansionTileServicesState();
}

class _ExpansionTileServicesState extends State<ExpansionTileServices> {
  late Future<List<Service>> futureServiceList;
  @override
  void initState() {
    super.initState();
    futureServiceList = fetchServices(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Service>>(
        future: futureServiceList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Service> serviceList = snapshot.data!;
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
                  List<Service> serviceLineList = serviceList
                      .where(
                          (element) => element.lineOfBusinessId == map[index])
                      .toList();
                  return ExpansionTile(
                    maintainState: true,
                    title: Text(
                      serviceLineList.first.lineOfBusiness,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: <Widget>[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: serviceLineList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ServiceAddContainer(
                            service: serviceLineList[index],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
