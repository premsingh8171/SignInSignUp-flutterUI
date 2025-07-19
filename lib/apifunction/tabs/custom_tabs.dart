import 'package:flutter/material.dart';

class CustomTabExample extends StatefulWidget {
  @override
  _CustomTabExampleState createState() => _CustomTabExampleState();
}

class _CustomTabExampleState extends State<CustomTabExample> {
  int _selectedIndex = 0; // 0 for Tab1, 1 for Tab2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Tab Demo")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = 0),
                  child: Container(
                    color: _selectedIndex == 0 ? Colors.orange : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      "Tab1",
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedIndex = 1),
                  child: Container(
                    color: _selectedIndex == 1 ? Colors.orange : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      "Tab2",
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                _selectedIndex == 0 ? "Tab1 Content" : "Tab2 Content",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
