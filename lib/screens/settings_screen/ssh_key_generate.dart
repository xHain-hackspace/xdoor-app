import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../models/ssh_key.dart';

class SSHKeyGenerate extends StatefulWidget {
  const SSHKeyGenerate({Key? key}) : super(key: key);

  @override
  State<SSHKeyGenerate> createState() => _SSHKeyGenerateState();
}

class _SSHKeyGenerateState extends State<SSHKeyGenerate> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _privateKeyController = TextEditingController();
    final TextEditingController _publicKeyController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    final _sshFormKey = GlobalKey<FormState>();
    SSHKey key = SSHKey(privateKey: '');
    return PlatformScaffold(
      appBar: PlatformAppBar(),
      body: WillPopScope(
        onWillPop: () async {
          if (_sshFormKey.currentState!.validate()) {
            Navigator.pop(
                context,
                SSHKey(
                  privateKey: _privateKeyController.text,
                  name: _nameController.text,
                  publicKey: _publicKeyController.text,
                ));
          } else {
            await showDialog(
              context: context,
              builder: (context) => PlatformAlertDialog(
                content: const Text('Please fill out all required fields!'),
                actions: [
                  PlatformTextButton(
                    child: const Text('Go back'),
                    onPressed: () {
                      Navigator.pop(context);
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
            );
          }
          return false;
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _sshFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Name'),
                  PlatformTextFormField(
                    initialValue: key.name,
                    controller: _nameController,
                    validator: (value) => _validateName(value),
                    autovalidateMode: AutovalidateMode.always,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Text('Private Key'),
                  PlatformTextFormField(
                    initialValue: key.privateKey,
                    controller: _privateKeyController,
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    validator: (value) => _validatePrivateKey(value),
                    autovalidateMode: AutovalidateMode.always,
                    enabled: false,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Text('Public Key'),
                  PlatformTextFormField(
                    initialValue: key.publicKey,
                    minLines: 1,
                    maxLines: 5,
                    controller: _publicKeyController,
                    keyboardType: TextInputType.multiline,
                    validator: (value) => _validatePublicKey(value),
                    autovalidateMode: AutovalidateMode.always,
                    enabled: false,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  PlatformElevatedButton(
                    child: const Text('Generate'),
                    onPressed: () {
                      key = SSHKey.generate(_nameController.text);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePrivateKey(String? val) {
    if (val == null || val == '') {
      return 'Required field';
    }
    try {
      SSHKeyPair.fromPem(val);
    } catch (ex) {
      return 'Invalid Format';
    }
    return null;
  }

  String? _validateName(String? val) {
    if (val == null || val == '') {
      return 'Required field';
    }
    return null;
  }

  String? _validatePublicKey(String? val) {
    if (val == null || val == '') {
      return null;
    }
    try {
      SSHKeyPair.fromPem(val);
    } catch (ex) {
      return 'Invalid Format';
    }
    return null;
  }
}
