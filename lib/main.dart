import 'package:flutter/material.dart';
import 'home.dart';
import 'settings.dart';

void main() {
  runApp(const XDoor());
}

Map<int, Color> color = {
  50: const Color.fromRGBO(7, 44, 47, .1),
  100: const Color.fromRGBO(7, 44, 47, .2),
  200: const Color.fromRGBO(7, 44, 47, .3),
  300: const Color.fromRGBO(7, 44, 47, .4),
  400: const Color.fromRGBO(7, 44, 47, .5),
  500: const Color.fromRGBO(7, 44, 47, .6),
  600: const Color.fromRGBO(7, 44, 47, .7),
  700: const Color.fromRGBO(7, 44, 47, .8),
  800: const Color.fromRGBO(7, 44, 47, .9),
  900: const Color.fromRGBO(7, 44, 47, 1),
};

class XDoor extends StatelessWidget {
  const XDoor({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'xDoor',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF072C2F, color),
      ),
      home: const XDoorMain(title: 'xDoor'),
    );
  }
}

class XDoorMain extends StatefulWidget {
  const XDoorMain({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<XDoorMain> createState() => _XDoorState();
}

class _XDoorState extends State<XDoorMain> {
  // Navigation
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    const HomeView(),
    const SettingsView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
