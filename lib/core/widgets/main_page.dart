import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/screen_state.dart';
import 'package:itdols/features/auth/presentation/logout_page.dart';
import 'package:itdols/features/calculation/calculation_controller.dart';
import 'package:itdols/features/calculation/presentation/calculation_page.dart';
import 'package:itdols/features/jobs/jobs_controller.dart';
import 'package:itdols/features/jobs/presentation/jobs_page.dart';
import 'package:itdols/features/places/places_controller.dart';
import 'package:itdols/features/places/presentation/places_page.dart';
import 'package:itdols/features/routes/presentation/routes_page.dart';
import 'package:itdols/features/routes/routes_controller.dart';
import 'dart:io' show Platform;

// ignore: must_be_immutable
class MainPage extends ConsumerWidget {
  MainPage({super.key});

  int _curentPage = 0;

  List<Widget> pages = [
    const CalculationPage(),
    JobsPage(),
    PlacesPage(),
    RoutePage(),
    const LogoutPage(),
  ];

  var icons = {
    0: {'icon': Icons.timeline, 'selectedIcon': Icons.timeline, 'label': 'Расчёт'},
    1: {'icon': Icons.cases_outlined, 'selectedIcon': Icons.cases_rounded, 'label': 'Дела'},
    2: {'icon': Icons.place_outlined, 'selectedIcon': Icons.place, 'label': 'Места'},
    3: {'icon': Icons.route_outlined, 'selectedIcon': Icons.route, 'label': 'Пути'},
    4: {'icon': Icons.logout, 'selectedIcon': Icons.logout, 'label': 'Выйти'},
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _curentPage = ref.watch(screenStateHolder);
    var commands = {
      0: () => ref.read(calculationController).getPlaces(),
      1: () => ref.read(jobsController).getJobs(),
      2: () => ref.read(placesController).getPlaces(),
      3: () => ref.read(routesController).getRoutes(),
      4: () {},
    };
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Platform.isAndroid || Platform.isIOS
            ? NavigationBar(
                backgroundColor: Colors.white,
                selectedIndex: _curentPage,
                onDestinationSelected: (value) {
                  commands[value]!();
                  ref.read(screenStateHolder.notifier).setScreen(value);
                },
                destinations: List.generate(
                  icons.length,
                  (index) => NavigationDestination(
                    icon: Icon(icons[index]!['icon'] as IconData),
                    selectedIcon: Icon(icons[index]!['selectedIcon'] as IconData),
                    label: icons[index]!['label'] as String,
                  ),
                ),
              )
            : null,
        body: Platform.isAndroid || Platform.isIOS
            ? pages[_curentPage]
            : Row(
                children: [
                  NavigationRail(
                    backgroundColor: Colors.white,
                    labelType: NavigationRailLabelType.all,
                    selectedIndex: _curentPage,
                    onDestinationSelected: (value) {
                      commands[value]!();
                      ref.read(screenStateHolder.notifier).setScreen(value);
                    },
                    destinations: List.generate(
                      icons.length,
                      (index) => NavigationRailDestination(
                        icon: Icon(icons[index]!['icon'] as IconData),
                        selectedIcon: Icon(icons[index]!['selectedIcon'] as IconData),
                        label: Text(icons[index]!['label'] as String),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    thickness: 1,
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (p0, p1) => pages[_curentPage],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
