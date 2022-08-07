import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:xdoor/models/door.dart';
import 'package:xdoor/screens/home_screen/connected_to_wifi.dart';
import 'package:xdoor/screens/home_screen/xhain_logo.dart';
import 'package:xdoor/screens/settings_screen/settings_screen.dart';
import 'door_action_button.dart';
import 'progress.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('xDoor'),
        trailingActions: [
          PlatformIconButton(
            icon: Icon(context.platformIcons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ConnectedToWifi>(
              create: (context) => ConnectedToWifi(),
            ),
            ChangeNotifierProvider<Progress>(
              create: (context) => Progress(),
            ),
          ],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: XHainLogo(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    DoorActionButton(DoorAction.open),
                    DoorActionButton(DoorAction.close),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
