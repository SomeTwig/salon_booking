import 'package:flutter/material.dart';
import 'package:fl_booking_app/models/models.dart';
import 'package:http/http.dart' as http;

import 'package:fl_booking_app/providers/providers.dart';
import 'package:fl_booking_app/data/data.dart';
import 'package:fl_booking_app/screens/booking/services_tab/services_add/components/service_add_container.dart';

class ExpansionTileServices extends StatefulWidget {
  const ExpansionTileServices({super.key});

  @override
  State<ExpansionTileServices> createState() => _ExpansionTileServicesState();
}

class _ExpansionTileServicesState extends State<ExpansionTileServices> {
  late Future<List<FLService>> futureServiceList;
  @override
  void initState() {
    super.initState();
    futureServiceList = ServiceList().fetchAllServices();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<FLService>>(
        future: futureServiceList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FLService> serviceList = snapshot.data!;
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
                  List<FLService> serviceLineList = serviceList
                      .where(
                          (element) => element.lineOfBusinessId == map[index])
                      .toList();
                  //print(serviceLineList);
                  return ExpansionTile(
                    maintainState: true,
                    title: Text(
                      serviceLineList.first.lineOfBusiness!,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: <Widget>[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: serviceLineList.length,
                        itemBuilder: (BuildContext context, int index) {
                          
                          // print(serviceLineList.length);
                          FLService aService = serviceLineList[index];
List<FLService> serviceParams = serviceList.where((element) => element.serviceParamId == serviceLineList[index].serviceParamId &&  element.serviceId == serviceLineList[index].serviceId).toList();
                          for(var el in serviceParams){
                            print(el.serviceName);
                            print(el.serviceParamId.toString());
                          }
                          // print(aService.serviceParamId.toString());
                          // print(aService.serviceName);
                            return ServiceAddContainer(
                              service: aService,
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
