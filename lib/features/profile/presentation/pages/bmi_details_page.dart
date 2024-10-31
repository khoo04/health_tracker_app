import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_tracker_app/core/enums/gender.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:toggle_switch/toggle_switch.dart';

class BmiDetailsPage extends StatefulWidget {
  const BmiDetailsPage({super.key});

  @override
  State<BmiDetailsPage> createState() => _BmiDetailsPageState();
}

class _BmiDetailsPageState extends State<BmiDetailsPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bmiController =
      TextEditingController(text: 'N/A');
  //Default Value to Male
  Gender gender = Gender.male;

  @override
  void initState() {
    super.initState();
    heightController.addListener(_onWeightHeightChanged);
    weightController.addListener(_onWeightHeightChanged);
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    ageController.dispose();
    bmiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculate Your BMI",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: heightController,
                  onTap: () async {
                    //SHOW DIALOG
                    int? value;
                    if (heightController.text == "") {
                      value = await _heightNumberPicker(context);
                    } else {
                      value = await _heightNumberPicker(
                        context,
                        int.parse(heightController.text),
                      );
                    }

                    if (value != null) {
                      heightController.text = value.toString();
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppPallete.primaryColor)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelStyle: TextStyle(color: AppPallete.primaryColor),
                    labelText: "Height (cm)",
                    hintText: "Please choose your height",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: weightController,
                  onTap: () async {
                    //SHOW DIALOG
                    int? value;
                    if (weightController.text == "") {
                      value = await _weightNumberPicker(context);
                    } else {
                      value = await _weightNumberPicker(
                        context,
                        int.parse(weightController.text),
                      );
                    }

                    if (value != null) {
                      weightController.text = value.toString();
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppPallete.primaryColor)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelStyle: TextStyle(color: AppPallete.primaryColor),
                    labelText: "Weight (kg)",
                    hintText: "Please choose your weight",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: ageController,
                  onTap: () async {
                    //SHOW DIALOG
                    int? value;
                    if (ageController.text == "") {
                      value = await _ageNumberPicker(context);
                    } else {
                      value = await _ageNumberPicker(
                        context,
                        int.parse(ageController.text),
                      );
                    }

                    if (value != null) {
                      ageController.text = value.toString();
                    }
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppPallete.primaryColor)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelStyle: TextStyle(color: AppPallete.primaryColor),
                    labelText: "Age",
                    hintText: "Please choose your age",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ToggleSwitch(
                  minWidth: 100.0,
                  initialLabelIndex: 0,
                  cornerRadius: 10.0,
                  activeFgColor: AppPallete.whiteColor,
                  inactiveBgColor: AppPallete.inactiveColor,
                  inactiveFgColor: AppPallete.whiteColor,
                  totalSwitches: 2,
                  labels: const ['Male', 'Female'],
                  icons: const [Icons.male, Icons.female],
                  activeBgColors: [
                    const [Colors.blue],
                    [Colors.pink[500]!]
                  ],
                  onToggle: (index) {
                    switch (index) {
                      case 0:
                        gender = Gender.male;
                      case 1:
                        gender = Gender.female;
                      default:
                        gender = Gender.male;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(thickness: 3, color: Colors.black),
                Text("Your BMI is", style: TextStyle(fontSize: 40)),
                Text(bmiController.text,
                    style:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                Image.asset(
                  "assets/images/bmi_bar.png",
                  width: MediaQuery.sizeOf(context).width * 0.90,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (ageController.text == "" ||
                        heightController.text == "" ||
                        weightController.text == "") {
                      Fluttertoast.showToast(
                          msg: "Please fill up all the field!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: AppPallete.primaryColor,
                          textColor: AppPallete.whiteColor,
                          fontSize: 14.0);
                      return;
                    }

                    vLog(
                        "Data to send: ${gender} ,${ageController.text}, ${heightController.text}, ${weightController.text}");
                    context.read<ProfileBloc>().add(
                          ProfileUpdateBasicDetails(
                            height: int.parse(heightController.text),
                            weight: int.parse(weightController.text),
                            bmi: double.parse(bmiController.text),
                            age: int.parse(ageController.text),
                            gender: gender,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    foregroundColor: AppPallete.whiteColor,
                    backgroundColor: AppPallete.primaryColor,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  child: const Text(
                    "Save and confirm",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onWeightHeightChanged() {
    if (weightController.text == "" || heightController.text == "") {
      bmiController.text = 'N/A';
      return;
    }

    double weightKg = double.parse(weightController.text);
    double heightCm = double.parse(heightController.text);

    double heightM = heightCm / 100;
    double bmi = weightKg / (heightM * heightM);

    setState(() {
      bmiController.text = bmi.toStringAsFixed(2);
    });
  }

  Future<int?> _heightNumberPicker(
    BuildContext context, [
    int selectedValue = 150,
  ]) async {
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Select your height (cm)"),
              content: NumberPicker(
                minValue: 0,
                maxValue: 250,
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value; // Update the selected value
                  });
                },
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(null); // Return selected value
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(selectedValue); // Return selected value
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<int?> _weightNumberPicker(
    BuildContext context, [
    int selectedValue = 60,
  ]) async {
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Select your weight (kg)"),
              content: NumberPicker(
                minValue: 0,
                maxValue: 200,
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value; // Update the selected value
                  });
                },
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(null); // Return selected value
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(selectedValue); // Return selected value
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<int?> _ageNumberPicker(
    BuildContext context, [
    int selectedValue = 20,
  ]) async {
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Select your age"),
              content: NumberPicker(
                minValue: 0,
                maxValue: 100,
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value; // Update the selected value
                  });
                },
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(null); // Return selected value
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(selectedValue); // Return selected value
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
