import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var _sshKey = '';
  final _storage = const FlutterSecureStorage();

  getSSHKeyFromStorage() async {
    return await _storage.read(key: 'ssh-key');
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Access'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.key),
              title: const Text('SSH-Key'),
              onPressed: (context) async {
                final sshKey = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SSHKeySettings(),
                  ),
                );
                await _storage.write(key: 'xdoor-key', value: sshKey);
                setState(() {
                  _sshKey = sshKey.toString();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class SSHKeySettings extends StatelessWidget {
  SSHKeySettings({super.key});
  final TextEditingController sshKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSH-Key'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, sshKeyController.text);
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: sshKeyController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your private key',
            ),
            autofocus: true,
          ),
        ),
      ),
    );
  }
}
