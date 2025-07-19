import 'package:flutter/material.dart';

import '../dashboard/home_page_screen.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TicketDashboardScreen()
      ),
    );
  }
}