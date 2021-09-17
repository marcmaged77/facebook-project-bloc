import 'package:facebook/data/data.dart';
import 'package:facebook/screens/home_screen.dart';
import 'package:facebook/widgets/responsive.dart';
import 'package:facebook/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavScreen extends StatefulWidget {
  static const String routeName = '/nav';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (_, __, ___) => NavScreen(),
    );
  }

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    Icons.account_circle_outlined,
    Icons.group_outlined,
    Icons.doorbell_outlined,
    Icons.menu
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;


    return DefaultTabController(
        length: _icons.length,
        child: Scaffold(
            appBar: Responsive.isDesktop(context)
                ? PreferredSize(preferredSize: Size(size.width, 100),
            child: CustomAppBar(
              currentUser: currentUser,
              icons: _icons,
              selectedIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index)
            ),
            )
                : null,
            body: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
            bottomNavigationBar:

                // if true
                !Responsive.isDesktop(context)
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: CustomTabBar(
                            icons: _icons,
                            selectedIndex: _selectedIndex,
                            onTap: (index) =>
                                setState(() => _selectedIndex = index)),
                      )
                    : SizedBox.shrink()
            //it will be at the bottom of the screen

            ));
  }
}
