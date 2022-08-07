import 'package:flutter/material.dart';

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
