import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:passman/models/app_state.dart';
import 'package:provider/provider.dart';

class AppLocker extends StatefulWidget {
  static String routeName = "/app-locker-route";

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Provider.of<AppState>(context, listen: false).setBackground(true);
    }
    super.didChangeAppLifecycleState(state);
  }

  void unlockApp() {
    Provider.of<AppState>(context, listen: false).setStartUp(false);
    Provider.of<AppState>(context, listen: false).setBackground(false);
  }

  @override
  Widget build(BuildContext context) {
    bool _startUp = Provider.of<AppState>(context).getStartUp();
    bool _inBackground = Provider.of<AppState>(context).getBackground();

    return (_startUp || _inBackground)
        ? widget.lockScreenBuilder(context, unlockApp)
        : widget.appRouteBuilder(context);
  }
}
