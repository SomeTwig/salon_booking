import 'package:flutter/material.dart';

import 'package:fl_booking_app/screens/booking/services_tab/services_tab.dart';
import 'package:fl_booking_app/screens/booking/time_tab/time_tab.dart';
import 'package:fl_booking_app/screens/booking/appointment_tab/appointment_tab.dart';
import 'package:go_router/go_router.dart';

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
    return const Scaffold(
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

  static final List<Category> _categories = [
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
      TimeTab(
        onNext: () => _tabController.index = 2,
        onPrev: () => _tabController.index = 0,
      ),
      AppointmentTab(
        onSubmit: () {
          int count = 0;
          context.go('/home');
        },
        onPrev: () => _tabController.index = 1,
      ),
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
          bottom: ReadOnlyTabBar(
            child: TabBar(
              controller: _tabController,
              tabs: myTabs,
            ),
          ),
          title: const Text('Бронирование'),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: bookingTabsBody,
        ),
      ),
    );
  }
}

// https://stackoverflow.com/a/57354375/436422
class ReadOnlyTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar child;

  const ReadOnlyTabBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: child);
  }

  @override
  Size get preferredSize => child.preferredSize;
}
