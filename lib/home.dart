import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  // Animation Controller
  late final AnimationController _controller;

  // storage
  final _storage = const FlutterSecureStorage();

  static const _animationDuration = Duration(milliseconds: 4000);
  static const _animationStart = 0.0;
  static const _animationEnd = 0.5;

  @override
  void initState() {
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(45),
                child: Image.asset('assets/images/logo.png'),
              ),
              RotationTransition(
                turns: Tween(
                  begin: _animationStart,
                  end: _animationEnd,
                ).animate(_controller),
                child: Image.asset('assets/images/gear.png'),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  String? key = await _storage.read(key: 'xdoor-key');
                  try {
                    await _close(key.toString());
                    _controller.forward();
                  } on FormatException {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Please provide a valid key!'),
                        content: const Text('Please provide a valid key!'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    );
                  }
                },
                label: const Text('Lock'),
                icon: const Icon(Icons.lock),
              ),
              ButtonTheme(
                minWidth: 1000,
                height: 100,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    String? key = await _storage.read(key: 'xdoor-key');
                    try {
                      await _open(key.toString());
                      _controller.animateBack(
                        _animationStart,
                        duration: _animationDuration,
                      );
                    } on FormatException {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Please provide a valid key!'),
                          content: const Text('Please provide a valid key!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  label: const Text('Unlock'),
                  icon: const Icon(Icons.lock_open),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

_open(String sshKey) async {
  final client = SSHClient(
    await SSHSocket.connect('xdoor', 22),
    username: 'open',
    identities: [
      // A single private key file may contain multiple keys.
      ...SSHKeyPair.fromPem(sshKey),
    ],
    onVerifyHostKey: (type, fingerprint) {
      debugPrint("Close: verify hostkey...");
      return true;
    },
    onAuthenticated: () {
      debugPrint("Close: authenticated...");
    },
    onPasswordRequest: () {
      debugPrint("Close: requesting password...");
      return '';
    },
    onChangePasswordRequest: (prompt) {
      debugPrint(prompt);
      return;
    },
    onUserInfoRequest: (request) {
      debugPrint(request.toString());
      return;
    },
    onUserauthBanner: (banner) {
      debugPrint(banner);
    },
    // printDebug: ((p0) {
    //   debugPrint(p0);
    // }),
  );

  await client.authenticated;
  final shell = await client.shell();
  await shell.done;
  await client.done;
  debugPrint('Closing connection!');
}

_close(String sshKey) async {
  final socket = await SSHSocket.connect('xdoor', 22);
  final client = SSHClient(
    socket,
    username: 'close',
    identities: [
      // A single private key file may contain multiple keys.
      ...SSHKeyPair.fromPem(sshKey),
    ],
    onVerifyHostKey: (type, fingerprint) {
      debugPrint("Close: verify hostkey...");
      return true;
    },
    onAuthenticated: () {
      debugPrint("Close: authenticated...");
    },
    onPasswordRequest: () {
      debugPrint("Close: requesting password...");
      return '';
    },
    onChangePasswordRequest: (prompt) {
      debugPrint(prompt);
      return;
    },
    onUserInfoRequest: (request) {
      debugPrint(request.toString());
      return;
    },
    onUserauthBanner: (banner) {
      debugPrint(banner);
    },
    // printDebug: ((p0) {
    //   debugPrint(p0);
    // }),
  );
  await client.authenticated;
  final shell = await client.shell();
  await shell.done;
  await client.done;
  debugPrint('Closing connection!');
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Popup example'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Accept'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Decline'),
      ),
    ],
  );
}
