import 'package:crypto_keys/crypto_keys.dart';

class SSHKey {
  late String _name;
  late String _privateKey;
  late String _publicKey;

  SSHKey({
    required String privateKey,
    String publicKey = '',
    String name = '',
  })  : _privateKey = privateKey,
        _publicKey = publicKey,
        _name = name;

  SSHKey.generate(String name) {
    final keys = KeyPair.generateRsa();
    _privateKey = keys.privateKey.toString();
    _publicKey = keys.publicKey.toString();
    _name = name;
  }

  SSHKey.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _publicKey = json['public_key'],
        _privateKey = json['private_key'];

  Map<String, dynamic> toJson() => {
        'name': _name,
        'public_key': _publicKey,
        'private_key': _privateKey,
      };

  get privateKey => _privateKey;
  get publicKey => _publicKey;
  get name => _name;
}
