import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(CupertinoIcons.plus),
          onPressed: () async {
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
      ),
      appBar: PlatformAppBar(
        title: PlatformText('Settings'),
        cupertino: (context, platform) => CupertinoNavigationBarData(
            automaticallyImplyLeading: true,
            automaticallyImplyMiddle: true,
            trailing: CupertinoButton(
              child: const Icon(CupertinoIcons.add),
              onPressed: () async {
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
            )),
      ),
      body: const SafeArea(
        child: SSHKeyListView(),
      ),
    );
  }
}
