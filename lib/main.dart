import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xdoor/models/ssh_key_list.dart';
import 'package:xdoor/utils/secure_store.dart';
import 'screens/home_screen/home_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() async {
  runApp(const App());
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

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: MaterialColor(0xFF072C2F, color),
    );
    return Theme(
      data: theme,
      child: PlatformProvider(
        settings: PlatformSettingsData(
          iosUsesMaterialWidgets: false,
        ),
        builder: (context) => ChangeNotifierProvider<SSHKeyList>(
          create: (context) => SSHKeyList.fromStorage(),
          child: const PlatformApp(
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'xDoor',
            home: HomeView(),
          ),
        ),
      ),
    );
  }
}

// class XDoorMain extends StatefulWidget {
//   const XDoorMain({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<XDoorMain> createState() => _XDoorState();
// }

// class _XDoorState extends State<XDoorMain> {
//   // Navigation
//   int _selectedIndex = 0;
//   static final List<Widget> _pages = <Widget>[
//     const HomeView(),
//     const SettingsView(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _pages,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
