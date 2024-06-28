import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:fl_booking_app/models/models.dart';

// Define Routes
import 'package:fl_booking_app/screens/home/home.dart';
import 'package:fl_booking_app/screens/booking/booking.dart';
import 'package:fl_booking_app/screens/my_bookings/my_bookings.dart';
import 'package:fl_booking_app/screens/account/account.dart';
import 'package:fl_booking_app/screens/account/login.dart';
import 'package:fl_booking_app/screens/account/register.dart';

import 'package:provider/provider.dart';

const String homePage = 'home';
const String bookingPage = 'booking';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const MyHomePage());
    case bookingPage:
      return MaterialPageRoute(builder: (context) => const BookingPage());
    default:
      throw ('This route name does not exit');
  }
}

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorBookingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellMyBookings');
final _shellNavigatorAccountKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellAccount');
final _shellNavigatorLoginKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellLogin');

final goRouter = GoRouter(
  initialLocation: '/home',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MyHomePage(),
              ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'booking',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: BookingPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBookingsKey,
          routes: [
            GoRoute(
              path: '/mybookings',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: MyBookings(),
              ),
              redirect: (context, state) {
                if (Provider.of<MyAccount>(context, listen: false)
                    .accountPhone
                    .isEmpty) {
                  return '/login';
                }
                return '/mybookings';
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAccountKey,
          routes: [
            GoRoute(
              path: '/account',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AccountPage(),
              ),
              redirect: (context, state) {
                if (Provider.of<MyAccount>(context, listen: false)
                    .accountPhone
                    .isEmpty) {
                  return '/login';
                }
                return '/account';
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        // receive and pass to the registration page the users phone number
        if (state.extra != null) {
          final data = state.extra! as Map<String, dynamic>;
          return LoginPage(pageData: data["pageData"]);
        } else {
          return LoginPage();
        }
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        // receive and pass to the registration page the users phone number
        final data = state.extra! as Map<String, dynamic>;
        return RegisterPage(phoneData: data["phoneData"]);
      },
    ),
  ],
);

// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: 'My Bookings',
            icon: Icon(Icons.calendar_today),
          ),
          NavigationDestination(
            label: 'Account',
            icon: Icon(Icons.person),
          ),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
