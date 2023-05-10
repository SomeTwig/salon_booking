import 'package:flutter/material.dart';

import 'package:test_1/screens/booking/services_tab/services_tab.dart';
import 'package:test_1/screens/booking/time_tab/time_tab.dart';
import 'package:test_1/screens/booking/appointment_tab/appointment_tab.dart';
import 'package:test_1/models/models.dart';

//Main body of the page
class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookingTabs(),
    );
  }
}

//class for tab Categories
//extract into a separate file?
class Category {
  String name;
  IconData icon;

  Category(this.name, this.icon);
}

//Tabs for booking - services/date-time/contact info
class BookingTabs extends StatefulWidget {
  const BookingTabs({super.key});

  @override
  State<BookingTabs> createState() => _BookingTabsState();
}

class _BookingTabsState extends State<BookingTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  bool isNext = true;

  static List<Category> _categories = [
    Category('Services', Icons.add_shopping_cart),
    Category('Time', Icons.access_time_outlined),
    Category('Book', Icons.book_outlined),
  ];

  static List<Tab> myTabs = <Tab>[
    Tab(
      icon: Icon(_categories[0].icon),
    ),
    Tab(
      icon: Icon(_categories[1].icon),
    ),
    Tab(
      icon: Icon(_categories[2].icon),
    ),
  ];

  List<Widget> get bookingTabsBody {
    return <Widget>[
      ServicesTab(
        onNext: () => _tabController.index = 1,
      ),
      TimeTab(onNext: () => _tabController.index = 2,),
      AppointmentTab(onSubmit: () {
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      },),
    ];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        isNext = (_selectedIndex + 1) < _tabController.length ? true : false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
          title: Text('Бронирование'),
        ),
        body: TabBarView(
          controller: _tabController,
          children: bookingTabsBody,
        ),
        // floatingActionButton: ElevatedButton.icon(
        //   onPressed: isNext
        //       ? () => _tabController.animateTo(_selectedIndex += 1)
        //       : null,
        //   icon: Icon(Icons.arrow_forward),
        //   label: Text('Далее'),
        // ),
        // persistentFooterButtons: [
        //   Visibility(
        //     visible: isNext,
        //     child: ElevatedButton.icon(
        //       onPressed: isNext
        //           ? () => _tabController.animateTo(_selectedIndex += 1)
        //           : null,
        //       icon: Icon(Icons.arrow_forward),
        //       label: Text('Далее'),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
