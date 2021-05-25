import 'package:flutter/material.dart';

Widget toggleButtons(
  Widget title,
  Widget firstToggle,
  Widget secondToggle,
  List<bool> isSelectedSex,
  Function onPressed,
) {
  return Column(
    children: [
      title,
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ToggleButtons(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: firstToggle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: secondToggle,
            ),
          ],
          isSelected: isSelectedSex,
          onPressed: onPressed,
          // renderBorder: false,
        ),
      ),
    ],
  );
}

Widget dropdownButton(
  Widget title,
  ValueKey<String> key,
  int value,
  List<DropdownMenuItem<int>> items,
  Function onChanged,
) {
  return Column(
    children: [
      title,
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: DropdownButton(
          key: key,
          isExpanded: false,
          value: value,
          items: items,
          onChanged: onChanged,
        ),
      ),
    ],
  );
}

Widget switchButton(
  Widget title,
  bool switched,
  Function onChanged,
) {
  return Column(
    children: [
      title,
      Row(
        children: [
          const Text(
            'Yo\'q',
            style: TextStyle(fontSize: 12),
          ),
          Switch(
            value: switched,
            onChanged: onChanged,
          ),
          const Text(
            'Ha',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    ],
  );
}

Widget oneRadioListTile(
  Widget radioTitle,
  var value,
  var groupValue,
  Function onChanged,
) {
  return RadioListTile(
    title: radioTitle,
    value: value,
    groupValue: groupValue,
    onChanged: onChanged,
  );
}

Widget slider(
  Widget title,
  double currentSlider,
  num min,
  num max,
  int divisions,
  Function onChanged,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      children: [
        title,
        Row(
          children: [
            Expanded(
              child: Slider(
                value: currentSlider,
                min: min,
                max: max,
                divisions: divisions,
                label: currentSlider.round().toString(),
                onChanged: onChanged,
              ),
            ),
            Container(
              width: 40,
              child: Center(
                child: Text(
                  '${currentSlider.toInt()}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget textField(
  ValueKey<String> key,
  String hintText,
  String labelText,
  String helperText,
  bool isInt,
  num min,
  num max,
  TextEditingController controller,
  bool validate,
  Size screenSize,
) {
  return Container(
    width: (screenSize.width - 40) * 0.75,
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      key: key,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(),
        ),
        errorText: validate ? 'Iltimos to\'g\'ri qiymat kiriting.' : null,
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
      ),
      keyboardType: TextInputType.number,
      // textInputAction: TextInputAction.next,
      controller: controller,
    ),
  );
}

bool validation(
  bool isInt,
  String value,
  num min,
  num max,
) {
  final num val = isInt ? int.tryParse(value) : num.tryParse(value);
  if (value.isEmpty || !(val is num) || !(min <= val && val <= max)) {
    return true;
  }
  return false;
}

Widget textFormField(
  ValueKey<String> key,
  String hintText,
  String labelText,
  String helperText,
  bool isInt,
  num min,
  num max,
  TextEditingController controller,
  Size screenSize,
) {
  return Container(
    width: (screenSize.width - 40) * 0.75,
    padding: const EdgeInsets.all(10),
    child: TextFormField(
      key: key,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(),
        ),
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
      ),
      keyboardType: TextInputType.number,
      // textInputAction: TextInputAction.next,
      validator: (value) {
        final num val = isInt ? int.tryParse(value) : num.tryParse(value);
        if (value.isEmpty || !(val is num) || !(min <= val && val <= max)) {
          return 'Iltimos to\'g\'ri qiymat kiriting.';
        }
        return null;
      },
      controller: controller,
    ),
  );
}
