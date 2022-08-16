import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../models/ssh_key.dart';

class SSHKeyInput extends StatefulWidget {
  final SSHKey? _existingKey;
  const SSHKeyInput({SSHKey? existingKey, Key? key})
      : _existingKey = existingKey,
        super(key: key);

  @override
  State<SSHKeyInput> createState() => _SSHKeyInputState();
}

class _SSHKeyInputState extends State<SSHKeyInput> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _privateKeyController = TextEditingController();
    final TextEditingController _publicKeyController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();

    final _sshFormKey = GlobalKey<FormState>();

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
                  PlatformWidget(
                    material: (context, platform) => const Text('Name'),
                  ),
                  PlatformTextFormField(
                    cupertino: (context, platform) =>
                        CupertinoTextFormFieldData(
                      prefix: const Text("Name:"),
                      placeholder: "Required",
                      validator: _validateNameIos,
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                    material: (context, platform) => MaterialTextFormFieldData(
                      validator: _validateNameMaterial,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                    initialValue: widget._existingKey?.name,
                    controller: _nameController,
                    keyboardType: TextInputType.multiline,
                  ),
                  // const Padding(padding: EdgeInsets.only(top: 10)),
                  PlatformWidget(
                    material: (context, platform) => const Text('Private Key'),
                  ),
                  PlatformTextFormField(
                    cupertino: (context, platform) =>
                        CupertinoTextFormFieldData(
                      prefix: const Text("Private Key:"),
                      placeholder: "Required",
                      validator: _validatePrivateKeyIos,
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                    material: (context, platform) => MaterialTextFormFieldData(
                      autovalidateMode: AutovalidateMode.always,
                      validator: _validatePrivateKeyMaterial,
                    ),
                    initialValue: widget._existingKey?.privateKey,
                    controller: _privateKeyController,
                    minLines: 1,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                  ),

                  // const Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0)),
                  PlatformWidget(
                    material: (context, platform) => const Text('Public Key'),
                  ),
                  PlatformTextFormField(
                    cupertino: (context, platform) =>
                        CupertinoTextFormFieldData(
                      prefix: const Text("Public Key:"),
                      placeholder: "Optional",
                      validator: _validatePublicKeyIos,
                      autovalidateMode: AutovalidateMode.disabled,
                    ),
                    material: (context, platform) => MaterialTextFormFieldData(
                      validator: _validatePublicKeyMaterial,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                    initialValue: widget._existingKey?.publicKey,
                    minLines: 1,
                    maxLines: 2,
                    controller: _publicKeyController,
                    keyboardType: TextInputType.multiline,
                  ),
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _nameController,
                    builder: (context, value, child) {
                      return PlatformTextButton(
                        child: Text('Generate'),
                        onPressed: value.text.isEmpty
                            ? null
                            : () {
                                final key =
                                    SSHKey.generate(_nameController.text);
                                _privateKeyController.text = key.privateKey;
                                _publicKeyController.text = key.publicKey;
                              },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePrivateKeyMaterial(String? val) {
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

  String? _validateNameMaterial(String? val) {
    if (val == null || val == '') {
      return 'Required field';
    }
    return null;
  }

  String? _validatePublicKeyMaterial(String? val) {
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

  String? _validatePrivateKeyIos(String? val) {
    if (val == null || val == '') {
      return '';
    }
    try {
      SSHKeyPair.fromPem(val);
    } catch (ex) {
      return 'Invalid Format';
    }
    return null;
  }

  String? _validateNameIos(String? val) {
    if (val == null || val == '') {
      return '';
    }
    return null;
  }

  String? _validatePublicKeyIos(String? val) {
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
