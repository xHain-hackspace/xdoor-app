import 'package:flutter/material.dart';
import 'package:xdoor/models/ssh_key.dart';
import 'package:xdoor/utils/secure_store.dart';

class SSHKeyList with ChangeNotifier {
  Map<String, SSHKey> _keys = {};

  SSHKeyList.fromStorage() {
    SecureStore.getSSHKeyList().then((value) {
      _keys = value.sshKeys;
      notifyListeners();
    });
  }

  SSHKeyList.fromMap(Map<String, SSHKey> map) : _keys = map;

  SSHKeyList.fromJSON(Map<String, dynamic> json) {
    json.forEach((key, value) {
      final sshKey = SSHKey.fromJson(value);
      _keys[sshKey.name] = sshKey;
    });
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> keys = {};
    _keys.forEach((key, value) {
      keys[key] = value;
    });
    return keys;
  }

  SSHKey? operator [](String key) {
    return _keys[key];
  }

  operator []=(String key, SSHKey value) async {
    _keys[key] = value;
    await _store();
    notifyListeners();
  }

  bool isEmpty() {
    return _keys.isEmpty;
  }

  Future _store() {
    return SecureStore.storeSSHKeyList(this);
  }

  Map<String, SSHKey> get sshKeys => _keys;

  Future delete(String key) async {
    _keys.remove(key);
    await _store();
    notifyListeners();
  }
}
