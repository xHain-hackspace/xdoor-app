import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:xdoor/screens/settings_screen/ssh_key_generate.dart';
import 'package:xdoor/screens/settings_screen/ssh_key_input.dart';
import 'package:xdoor/screens/settings_screen/ssh_key_list_view.dart';

import '../../models/ssh_key_list.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final sshKeyProvider = Provider.of<SSHKeyList>(context);
    return PlatformScaffold(
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: SpeedDial(
          children: [
            SpeedDialChild(
                child: const Icon(CupertinoIcons.gear_big),
                label: 'Generate key',
                onTap: () {
                  final key = Navigator.of(context).push(
                    MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => const SSHKeyGenerate(),
                    ),
                  );
                }),
            SpeedDialChild(
              child: const Icon(CupertinoIcons.plus),
              label: 'Add custom key',
              onTap: () async {
                final key = await Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: false,
                    builder: (context) => const SSHKeyInput(),
                  ),
                );
                if (key != null && key.name != '') {
                  sshKeyProvider[key.name] = key;
                }
              },
            ),
          ],
          child: const Icon(Icons.add),
        ),
      ),
      appBar: PlatformAppBar(
        title: PlatformText('Settings'),
        cupertino: (context, platform) => CupertinoNavigationBarData(
          automaticallyImplyLeading: true,
          automaticallyImplyMiddle: true,
        ),
      ),
      body: const SafeArea(
        child: SSHKeyListView(),
      ),
    );
  }
}
