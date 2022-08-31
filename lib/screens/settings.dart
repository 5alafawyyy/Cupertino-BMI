import 'package:cupertino_app/util.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int unit = 1;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double hieght = MediaQuery.of(context).size.height;
    final Map<int, Widget> systems = <int, Widget>{
      0: const Text('Decimal'),
      1: const Text('Imperial'),
    };

    Util.getSettings().then(updateControl);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Image.network(
              'https://bit.ly/fl_earth',
            ),
            Util.paddingTop,
            Row(
              children: [
                SizedBox(
                  width: width,
                  child: CupertinoSegmentedControl(
                    children: systems,
                    onValueChanged: ((int value) {
                      Util.saveSettings(value);
                      updateControl(value);
                    }),
                    groupValue: unit,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateControl(int value) {
    if (value != unit) {
      setState(() {
        unit = value;
      });
    }
  }
}
