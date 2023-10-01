import 'package:fl_booking_app/models/flOffice.dart';
import 'package:flutter/material.dart';
import 'package:fl_booking_app/screens/salons/components/salon_container.dart';
import 'package:fl_booking_app/providers/providers.dart';

class SalonsPage extends StatefulWidget {
  const SalonsPage({super.key});

  @override
  State<SalonsPage> createState() => _SalonsPageState();
}

class _SalonsPageState extends State<SalonsPage> {
  late Future<List<FLOffice>> futureServiceList;
  @override
  void initState() {
    super.initState();
    futureServiceList = OfficeList().fetchAllOffices();
  }

  @override
  Widget build(BuildContext context) {
    
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Салоны'),
      ),
      body: Container(
        color:Colors.white,
        child: SizedBox(
          height: screenheight,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Выберите желаемый салон:',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          FutureBuilder<List<FLOffice>>(
                              future: futureServiceList,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<FLOffice> officesList = snapshot.data!;
                                  for (var element in officesList) {
                                    print(element.officeName);
                                  }
                                  return ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: officesList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return SalonContainer(
                                        flSalon: officesList[index],
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
              
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
