import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/models/app_startup.dart';
import 'package:provider/provider.dart';

class AppLocker extends StatefulWidget {
  final Widget Function(BuildContext context) appRouteBuilder;

  final Widget Function(
    BuildContext context,
    void Function() unlocker,
  ) lockScreenBuilder;

  AppLocker({
    @required this.appRouteBuilder,
    @required this.lockScreenBuilder,
  });

  @override
  _AppLockerState createState() => _AppLockerState();
}

class _AppLockerState extends State<AppLocker> with WidgetsBindingObserver {
  bool _startUp;
  bool _inBackground;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _inBackground = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        _inBackground = true;
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  void unlockApp() {
    setState(() {
      Provider.of<AppStartup>(context, listen: false).setValue(false);
      _startUp = false;
      _inBackground = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _startUp = Provider.of<AppStartup>(context).getValue();
    return (_startUp || _inBackground)
        ? widget.lockScreenBuilder(context, unlockApp)
        : widget.appRouteBuilder(context);
  }
}
