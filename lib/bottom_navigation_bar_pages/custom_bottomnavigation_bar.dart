import 'package:flutter/material.dart';
import 'package:untitled1/bottom_navigation_bar_pages/page1.dart';
import 'package:untitled1/bottom_navigation_bar_pages/page2.dart';
import 'package:untitled1/bottom_navigation_bar_pages/page3.dart';
import 'package:untitled1/bottom_navigation_bar_pages/page4.dart';

import 'exitconfirmationdialog.dart';

class CustomBottomnavigationBar extends StatefulWidget {
  const CustomBottomnavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomnavigationBar createState() => _CustomBottomnavigationBar();
}

class _CustomBottomnavigationBar extends State<CustomBottomnavigationBar> {
  int pageIndex = 0;
  bool _canPop = false;
  final List<Widget> pages = [
    const Page1(),
    const Page2(), // Replace with your actual pages
    const Page3(),
    const Page4()
  ];
  // Add this list in your State class
  final List<String> pageTitles = [
    'Home',
    'Notifications',
    'Profile',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
      if (didPop) {
          await ExitConfirmationDialog.show(context);
          setState(() => _canPop = true);
          Navigator.of(context).maybePop();
      }else{
        await ExitConfirmationDialog.show(context);
      }
    },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            pageTitles[pageIndex],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          ),
          //centerTitle: true,
        ),
        body: pages[pageIndex],
        bottomNavigationBar: customNavigationBar(context)
      ),
    );
  }

  Container customNavigationBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          customNavItem(
            icon: pageIndex == 0 ? Icons.home_filled : Icons.home,
            isSelected: pageIndex == 0,
            onTap: () => setState(() => pageIndex = 0),
          ),
          customNavItem(
            icon: pageIndex == 1 ? Icons.notifications : Icons.notifications_none,
            isSelected: pageIndex == 1,
            onTap: () => setState(() => pageIndex = 1),
          ),
          customNavItem(
            icon: pageIndex == 2 ? Icons.person : Icons.person_outline,
            isSelected: pageIndex == 2,
            onTap: () => setState(() => pageIndex = 2),
          ),
          customNavItem(
            icon: pageIndex == 3 ? Icons.settings : Icons.settings_outlined,
            isSelected: pageIndex == 3,
            onTap: () => setState(() => pageIndex = 3),
          ),
/*          IconButton(
            enableFeedback: false,
            icon: pageIndex == 0?
            const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 30,
            ): const Icon(
              Icons.home,
              color: Colors.white,
              size: 30,
            ),

            onPressed: () {
              setState(() {
                pageIndex=0;
              });
              //Navigator.pushNamed(context, '/dashboard');
            },
          ),

          IconButton(
            enableFeedback: false,
            icon: pageIndex == 1 ? const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30
            ): const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                pageIndex=1;
              });
             // Navigator.pushNamed(context, '/notification');
            },
          ),

          IconButton(
            enableFeedback: false,
            icon: pageIndex == 2 ? const Icon(
                Icons.person,
                color: Colors.white,
                size: 30
            ): const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                pageIndex=2;
              });
              //Navigator.pushNamed(context, '/signin');
            },
          ),

          IconButton(
            enableFeedback: false,
            icon: pageIndex == 3 ? const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30
            ): const Icon(
              Icons.settings_outlined,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                pageIndex=3;
              });
              //Navigator.pushNamed(context, '/signin');
            },
          ),*/
        ],
      ),
    );
  }

  Widget customNavItem({required IconData icon, required bool isSelected, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.white24,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

}