import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/diabetics_provider.dart';
import '../helpers/user_form_inputs.dart';

class DiabeticsForm extends StatefulWidget {
  @override
  _DiabeticsFormState createState() => _DiabeticsFormState();
}

class _DiabeticsFormState extends State<DiabeticsForm> {
  final _formKey = GlobalKey<FormState>();
  final _glucose = TextEditingController();
  final _bloodPressure = TextEditingController();
  final _skinThickness = TextEditingController();
  final _insulin = TextEditingController();
  final _bmi = TextEditingController();
  final _diabetesPedigreeFunction = TextEditingController();
  final _age = TextEditingController();

  var _autovalidateMode = AutovalidateMode.disabled;
  bool _loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    _glucose.dispose();
    _bloodPressure.dispose();
    _skinThickness.dispose();
    _insulin.dispose();
    _bmi.dispose();
    _diabetesPedigreeFunction.dispose();
    _age.dispose();
  }

  Future<void> _saveFrom() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _loading = true;
        });
        // Form is valid, proceed further save once fields are valid, onSaved method invoked for every form fields
        _formKey.currentState!.save();
        await Provider.of<DiabeticsProvider>(context, listen: false)
            .predictAndAddDiabetics(
          int.tryParse(_glucose.text) ?? 0,
          int.tryParse(_bloodPressure.text) ?? 0,
          int.tryParse(_skinThickness.text) ?? 0,
          int.tryParse(_insulin.text) ?? 0,
          num.tryParse(_bmi.text) ?? 0,
          num.tryParse(_diabetesPedigreeFunction.text) ?? 0,
          int.tryParse(_age.text) ?? 0,
        );
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Tashxis muvaffaqiyatli amalga oshirildi',
              textAlign: TextAlign.center,
            ),
            duration: Duration(milliseconds: 3000),
          ),
        );
      } else {
        setState(() {
          // Enable realtime validation
          _autovalidateMode = AutovalidateMode.onUserInteraction;
        });
      }
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Xatolik!'),
          content: const Text(
              'Xatolik yuz berdi. Iltimos, ma\'lumotingizni tekshiring.'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Column(
        children: [
          textFormField(
            const ValueKey('glucose'),
            '0 - 200',
            'Glyukoza',
            'Glyukoza miqdori',
            true,
            0,
            200,
            _glucose,
            screenSize,
          ),
          textFormField(
            const ValueKey('bloodPressure'),
            '0 - 122',
            'Qon bosimi',
            'Qon bosimi',
            true,
            0,
            122,
            _bloodPressure,
            screenSize,
          ),
          textFormField(
            const ValueKey('skinThickness'),
            '0 - 99',
            'Teri qalinligi',
            'Teri qalinligi',
            true,
            0,
            99,
            _skinThickness,
            screenSize,
          ),
          textFormField(
            const ValueKey('insulin'),
            '0 - 846',
            'Insulin',
            'Insulin miqdori',
            true,
            0,
            846,
            _insulin,
            screenSize,
          ),
          textFormField(
            const ValueKey('bmi'),
            '0.0 - 67.1',
            'Tana massasi indeksi',
            'Tana vazni(kg) / bo\'y(m)^2',
            false,
            0.0,
            67.1,
            _bmi,
            screenSize,
          ),
          textFormField(
            const ValueKey('diabetesPedigreeFunction'),
            '0.078 - 2.42',
            'Diabet naslchilik funktsiyasi',
            'Diabet naslchilik funktsiyasi',
            false,
            0.078,
            2.42,
            _diabetesPedigreeFunction,
            screenSize,
          ),
          textFormField(
            const ValueKey('age'),
            '21 - 81',
            'Yosh',
            'Yosh',
            true,
            21,
            81,
            _age,
            screenSize,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: const Text(
                      'Tekshirish',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      _saveFrom();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
