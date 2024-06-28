import 'package:flutter/material.dart';
import 'package:fl_booking_app/models/models.dart';

import 'package:fl_booking_app/providers/providers.dart';
import 'package:fl_booking_app/screens/booking/services_tab/services_add/components/service_add_container.dart';
import 'package:fl_booking_app/screens/booking/services_tab/services_add/components/services_sort.dart';

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
            ServicesByLOB servicesList = ServicesByLOB(snapshot.data!);
            return Card(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: servicesList.serviceMapByLOB.length,
                itemBuilder: (BuildContext context, int index) {
                  String lineListkey =
                      servicesList.serviceMapByLOB.keys.elementAt(index);
                  return ExpansionTile(
                    maintainState: true,
                    title: Text(
                      lineListkey,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    children: <Widget>[
                      //ListView Builder for services HasParameter = false
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: servicesList.serviceMapByLOB[lineListkey]
                            .servicesWithNoParam.length,
                        itemBuilder: (BuildContext context, int index) {
                          FLService aService = servicesList
                              .serviceMapByLOB[lineListkey]
                              .servicesWithNoParam[index];
                          return ServiceAddContainer(
                            service: aService,
                          );
                        },
                      ),
                      //ListView Builder for services with HasParameter = true
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: servicesList.serviceMapByLOB[lineListkey]
                            .servicesMapWithParam.length,
                        itemBuilder: (BuildContext context, int index) {
                          int mapKey = servicesList.serviceMapByLOB[lineListkey]
                              .servicesMapWithParam.keys
                              .elementAt(index);

                          return ExpansionServicesWithParam(
                              servicesList: servicesList
                                  .serviceMapByLOB[lineListkey]
                                  .servicesMapWithParam[mapKey]);
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

class ExpansionServicesWithParam extends StatefulWidget {
  final List<FLService> servicesList;

  const ExpansionServicesWithParam({super.key, required this.servicesList});
  @override
  State<ExpansionServicesWithParam> createState() =>
      _ExpansionServicesWithParamState();
}

class _ExpansionServicesWithParamState
    extends State<ExpansionServicesWithParam> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      maintainState: true,
      title: Text(
        widget.servicesList.first.serviceName,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      children: <Widget>[
        //ListView Builder for each of services' parameter
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.servicesList.length,
          itemBuilder: (BuildContext context, int index) {
            FLService aService = widget.servicesList[index];
            return ServiceAddContainer(
              service: aService,
            );
          },
        ),
      ],
    );
  }
}
