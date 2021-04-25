import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppLocker extends StatefulWidget {
  final Widget Function(BuildContext context) appRouteBuilder;
  final Widget Function(BuildContext context, void Function() unlocker)
      lockScreenBuilder;

  AppLocker({
    @required this.appRouteBuilder,
    @required this.lockScreenBuilder,
  });

  @override
  _AppLockerState createState() => _AppLockerState();
}

class _AppLockerState extends State<AppLocker> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool _startUp = true;
  bool _inBackground = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        _inBackground = true;
      });
    }
  }

  void unlockApp() {
    setState(() {
      _startUp = false;
      _inBackground = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_startUp || _inBackground)
        ? widget.lockScreenBuilder(context, unlockApp)
        : widget.appRouteBuilder(context);
  }
}
