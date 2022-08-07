import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:xdoor/models/door.dart';
import 'package:xdoor/screens/home_screen/connected_to_wifi.dart';
import 'package:xdoor/screens/home_screen/progress.dart';
import 'package:provider/provider.dart';

class DoorActionButton extends StatelessWidget {
  final DoorAction _action;

  const DoorActionButton(DoorAction action, {Key? key})
      : _action = action,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<Progress>(context);
    final connected = Provider.of<ConnectedToWifi>(context);
    return CupertinoButton(
        pressedOpacity: (progress.get() || !connected.get()) ? 1 : 0.4,
        color: Theme.of(context).primaryColor,
        alignment: Alignment.topCenter,
        child: Icon(
          (_action == DoorAction.close)
              ? CupertinoIcons.lock_fill
              : CupertinoIcons.lock_open_fill,
          color:
              (progress.get() || !connected.get()) ? Colors.grey : Colors.white,
          semanticLabel: (_action == DoorAction.close) ? 'Lock' : 'Unlock',
        ),
        onPressed: () async {
          if (progress.get() || !connected.get()) {
            if (!connected.get()) {
              showPlatformDialog(
                  context: context,
                  builder: ((context) => PlatformAlertDialog(
                        content: const Text(
                            'Please connect to xHain wireless network.'),
                        actions: [
                          PlatformTextButton(
                            child: const Text('Ok'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      )));
            }
            return null;
          } else {
            progress.set(true);
            switch (_action) {
              case DoorAction.open:
                Door.open().then((value) => progress.set(false));
                break;
              case DoorAction.close:
                Door.open().then((value) => progress.set(false));
                break;
            }
          }
        });
  }
}
