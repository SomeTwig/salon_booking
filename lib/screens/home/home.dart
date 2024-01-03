import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:fl_booking_app/models/locale.dart';

import 'package:fl_booking_app/models/flOffice.dart';
import 'package:fl_booking_app/screens/home/components/salon_container.dart';
import 'package:fl_booking_app/providers/providers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget cardShell = Padding(
    // special offer card
    padding: const EdgeInsets.only(left: 10.0),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            // image container
            flex: 3,
            child: ClipRRect(
              //clipped to fit the card
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Image(
                  image: AssetImage('assets/images/manicure_image.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Name'),
                  const CircleAvatar(
                    child: Center(
                      child: Text('30%'),
                    ),
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('More'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;

    var selectedLocale = Localizations.localeOf(context).toString();

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        actions: <Widget>[
          Consumer<LocaleModel>(
            builder: (context, localeModel, child) => DropdownButton(
              value: selectedLocale,
              items: [
                DropdownMenuItem(
                  value: "en",
                  child: Text(t.pageSettingsInputLanguage("en")),
                ),
                DropdownMenuItem(
                  value: "uk",
                  child: Text(t.pageSettingsInputLanguage("uk")),
                ),
                DropdownMenuItem(
                  value: "ru",
                  child: Text(t.pageSettingsInputLanguage("ru")),
                ),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  localeModel.set(Locale(value));
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text(
              t.pageHomeOffersHeader,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            LimitedBox(
              maxHeight: 200,
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) =>
                    LimitedBox(maxWidth: width * 0.9, child: cardShell),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              t.pageHomeSalonsHeader,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            const SalonsList(),
          ],
        ),
      ),
    );
  }
}

class SalonsList extends StatefulWidget {
  const SalonsList({super.key});

  @override
  State<SalonsList> createState() => _SalonsListState();
}

class _SalonsListState extends State<SalonsList> {
  late Future<List<FLOffice>> futureServiceList;
  @override
  void initState() {
    super.initState();
    futureServiceList = OfficeList().fetchAllOffices();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FLOffice>>(
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
      },
    );
  }
}
