import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:xdoor/models/ssh_key.dart';
import 'package:xdoor/models/ssh_key_list.dart';

const sshKeysKey = 'xdoor_keys';

class SecureStore with ChangeNotifier {
  static const _storage = FlutterSecureStorage();

  // storeSSHKey(SSHKey sshKey) async {
  //   var json = await _storage.read(key: sshKeysKey);
  //   var list = SSHKeyList({});
  //   if (json != null) {
  //     // already stored keys
  //     list = SSHKeyList.fromJSON(jsonDecode(json));
  //   }
  //   list[sshKey.name] = sshKey;
  //   await _storage.write(key: sshKeysKey, value: jsonEncode(list));
  // }

  static Future<SSHKey?> getSSHKey(String name) async {
    final json = await _storage.read(key: sshKeysKey);
    if (json == null) {
      return null;
    }
    return jsonDecode(json)[name] as SSHKey;
  }

  static Future<SSHKeyList> getSSHKeyList() async {
    final json = await _storage.read(key: sshKeysKey);
    if (json == null) {
      return SSHKeyList.fromMap({});
    }
    return SSHKeyList.fromJSON(jsonDecode(json));
  }

  static Future storeSSHKeyList(SSHKeyList list) async {
    final json = jsonEncode(list.toJson());
    return _storage.write(key: sshKeysKey, value: json);
  }

  static Future storeSSHKey(SSHKey sshKey) async {
    final list = await getSSHKeyList();
    list[sshKey.name] = sshKey;
    return storeSSHKeyList(list);
  }
}
