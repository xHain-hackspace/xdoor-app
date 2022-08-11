import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:xdoor/models/ssh_key_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xdoor/screens/settings_screen/ssh_key_input.dart';

import '../../models/ssh_key.dart';

final SSHKey key1 = SSHKey(privateKey: 'private1', name: 'key1', publicKey: '');
final SSHKey key2 =
    SSHKey(privateKey: 'private2', name: 'key2', publicKey: 'public2');

class SSHKeyListView extends StatelessWidget {
  const SSHKeyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sshKeyListProvider = Provider.of<SSHKeyList>(context);
    return ListView.builder(
      itemCount: sshKeyListProvider.sshKeys.length,
      itemBuilder: (context, index) {
        String k = sshKeyListProvider.sshKeys.keys.elementAt(index);
        SSHKey sshKey = sshKeyListProvider[k]!;
        return Material(
          child: Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  flex: 2,
                  label: 'Delete',
                  icon: Icons.delete_forever,
                  onPressed: (context) => showDialog(
                    context: context,
                    builder: (context) => PlatformAlertDialog(
                      content: const Text(
                          'Are you sure you want to delete the ssh-key?'),
                      actions: [
                        PlatformTextButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            sshKeyListProvider.delete(sshKey.name);
                            Navigator.pop(context);
                          },
                        ),
                        PlatformTextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SlidableAction(
                  flex: 2,
                  label: 'Edit',
                  icon: Icons.delete_forever,
                  onPressed: (context) => SSHKeyInput(existingKey: sshKey),
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.key),
              title: Text(sshKey.name),
            ),
          ),
        );
      },
    );
  }
}
