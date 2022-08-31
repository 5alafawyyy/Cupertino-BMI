import 'package:cupertino_app/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  late int unit;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double hieght = MediaQuery.of(context).size.height;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('BMI'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: hieght * 0.8,
            ),
            child: Column(
              children: [
                Image.network(
                  'https://bit.ly/img_bmi',
                ),
                Util.paddingTop,
                Row(
                  children: [
                    Util.paddingLeft,
                    SizedBox(width: width / 4, child: const Text('Height')),
                    Expanded(
                      child: CupertinoTextField(
                        controller: heightController,
                      ),
                    ),
                    Util.paddingLeft,
                  ],
                ),
                Util.paddingTop,
                Row(
                  children: [
                    Util.paddingLeft,
                    SizedBox(width: width / 4, child: const Text('Weight')),
                    Expanded(
                      child: CupertinoTextField(
                        controller: weightController,
                      ),
                    ),
                    Util.paddingLeft,
                  ],
                ),
                const Expanded(child: Util.paddingTop),
                CupertinoButton.filled(
                  onPressed: showResult,
                  child: const Text('Calculate BMI'),
                ),
                Util.paddingTop,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showResult() async {
    double height;
    double weight;

    unit = await Util.getSettings();

    height = double.tryParse(heightController.text) ?? 0;
    weight = double.tryParse(weightController.text) ?? 0;

    double result = Util.calculateBMI(height, weight, unit);

    String message = 'Your BMI is: ${result.toStringAsFixed(2)}';

    CupertinoAlertDialog dialog = CupertinoAlertDialog(
      title: const Text('Result'),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: ((context) {
        return dialog;
      }),
    );
  }
}
