import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SystemThemePicker extends StatefulWidget {
  @override
  _SystemThemePickerState createState() => _SystemThemePickerState();
}

class _SystemThemePickerState extends State<SystemThemePicker> {
  final _defaultContentSpacing = 10.0;
  final _defaultRadioPadding = const EdgeInsets.all(15);

  ThemeMode _groupValue;

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = EasyDynamicTheme.of(context).themeMode.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            "Application theme",
            style: NeumorphicTheme.currentTheme(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: _defaultContentSpacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Light theme"),
              NeumorphicRadio(
                style: NeumorphicRadioStyle(
                  lightSource: LightSource.topLeft,
                ),
                isEnabled: !(currentThemeMode == "ThemeMode.light"),
                onChanged: (value) {
                  setState(() {
                    _groupValue = value;
                  });
                  EasyDynamicTheme.of(context).changeTheme(dark: false);
                },
                padding: _defaultRadioPadding,
                value: ThemeMode.light,
                groupValue: _groupValue,
                child: Icon(
                  Icons.check,
                  color: NeumorphicTheme.accentColor(context),
                ),
              ),
            ],
          ),
          SizedBox(
            height: _defaultContentSpacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dark theme"),
              NeumorphicRadio(
                isEnabled: !(currentThemeMode == "ThemeMode.dark"),
                onChanged: (value) {
                  setState(() {
                    _groupValue = value;
                  });
                  EasyDynamicTheme.of(context).changeTheme(dark: true);
                },
                padding: _defaultRadioPadding,
                value: ThemeMode.dark,
                groupValue: _groupValue,
                child: Icon(
                  Icons.check,
                  color: NeumorphicTheme.accentColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
