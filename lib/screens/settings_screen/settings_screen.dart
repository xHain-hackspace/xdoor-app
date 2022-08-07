import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:xdoor/screens/settings_screen/ssh_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Settings'),
      ),
      body: SafeArea(
          child: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile.navigation(
                title: const Text('SSH-Key'),
                leading: const Icon(Icons.key),
                enabled: true,
                trailing: const Icon(Icons.arrow_forward_ios),
                value: Text('ijbwq'),
                onPressed: (context) async {
                  final sshKey = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SSHKeySettings(),
                    ),
                  );
                }),
          ]),
        ],
      )),
    );
  }
}
