import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/heart_disease_provider.dart';
import '../models/heart_disease_model.dart';
import '../helpers/user_form_inputs.dart';

enum ThalCharacter { normal, fixed, reversible }
enum RestecgCharacter { excellent, good, bad }

class HeartDiseaseForm extends StatefulWidget {
  @override
  _HeartDiseaseFormState createState() => _HeartDiseaseFormState();
}

class _HeartDiseaseFormState extends State<HeartDiseaseForm> {
  final HeartDiseaseModel _model = HeartDiseaseModel(
    sex: 1,
    cp: 0,
    fbs: 0,
    restecg: 1,
    exang: 1,
    thal: 'normal',
    ca: 0,
    age: 25,
    trestbps: 120,
    chol: 126,
    thalach: 90,
    oldpeak: 0.0,
    slope: 2,
  );
  bool _validateChol = false;
  bool _validateOldpeak = false;
  bool _loading = false;
  final List<bool> _isSelectedSex = [false, true];
  static const Map<String, int> _cp = const {
    'Yo\'q': 0,
    'Biroz': 1,
    'Og\'riq': 2,
    'Kuchliroq': 3,
    'O\'ta og\'ir': 4
  };
  static const List<int> _ca = const [0, 1, 2, 3];
  bool _fbsSwitched = false;
  bool _exangSwitched = true;
  RestecgCharacter _restecgCharacter = RestecgCharacter.good;
  ThalCharacter _thalCharacter = ThalCharacter.normal;
  double _ageCurrentSlider = 25;
  double _trestbpsCurrentSlider = 120;
  double _thalachCurrentSlider = 90;
  double _slopeCurrentSlider = 2;
  final _chol = TextEditingController();
  final _oldpeak = TextEditingController();

  @override
  void initState() {
    super.initState();
    _model.sex = 1;
    _model.cp = 0;
    _model.fbs = 0;
    _model.exang = 1;
    _model.restecg = 1;
    _model.thal = 'normal';
    _model.ca = 0;
    _model.age = 25;
    _model.trestbps = 120;
    _model.thalach = 90;
    _model.slope = 2;
  }

  @override
  void dispose() {
    super.dispose();
    _chol.dispose();
    _oldpeak.dispose();
  }

  Future<void> _saveData() async {
    try {
      setState(() {
        _validateChol = validation(true, _chol.text, 126, 564) ? true : false;
        _validateOldpeak =
            validation(false, _oldpeak.text, 0.0, 6.2) ? true : false;
      });
      if (!_validateChol && !_validateOldpeak) {
        setState(() {
          _loading = true;
        });
        await Provider.of<HeartDiseaseProvider>(context, listen: false)
            .predictAndAddHD(
          _model.sex,
          _model.cp,
          _model.fbs,
          _model.restecg,
          _model.exang,
          _model.thal,
          _model.ca,
          _model.age,
          _model.trestbps,
          int.tryParse(_chol.text) ?? 0,
          _model.thalach,
          num.tryParse(_oldpeak.text) ?? 0,
          _model.slope,
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
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              toggleButtons(
                const Text(
                  'Jins',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const Text('Ayol', style: TextStyle(fontSize: 16)),
                const Text('Erkak', style: TextStyle(fontSize: 16)),
                _isSelectedSex,
                (int index) => setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < _isSelectedSex.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _isSelectedSex[buttonIndex] = true;
                      _model.sex = index;
                    } else {
                      _isSelectedSex[buttonIndex] = false;
                    }
                  }
                }),
              ),
              dropdownButton(
                const Text(
                  'Ko\'krak qafasidagi og\'riq',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const ValueKey('cp'),
                _model.cp,
                _cp
                    .map((key, value) => MapEntry(
                          key,
                          DropdownMenuItem(
                            value: value,
                            child: Text(key),
                          ),
                        ))
                    .values
                    .toList(),
                (selectedData) => setState(
                    () => _model.cp = int.parse(selectedData.toString())),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              switchButton(
                const Text(
                  'Qand miqdori > 120 mg/dl',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                _fbsSwitched,
                (value) => setState(() {
                  _fbsSwitched = value;
                  if (!_fbsSwitched)
                    _model.fbs = 0;
                  else
                    _model.fbs = 1;
                }),
              ),
              switchButton(
                const Text(
                  'Angina',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                _exangSwitched,
                (value) => setState(() {
                  _exangSwitched = value;
                  if (_exangSwitched)
                    _model.exang = 1;
                  else
                    _model.exang = 0;
                }),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: dropdownButton(
            const Text(
              'Floroskopiya tomirlar soni',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const ValueKey('ca'),
            _model.ca,
            _ca
                .map((value) => DropdownMenuItem(
                      child: Text(value.toString()),
                      value: value,
                    ))
                .toList(),
            (selectedData) =>
                setState(() => _model.ca = int.parse(selectedData.toString())),
          ),
        ),
        const Divider(thickness: 1),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: (deviceOrientation.index == Orientation.landscape.index)
                    ? (screenSize.width - 40) * 0.3
                    : (screenSize.width - 40) * 0.4, // 140
                child: Column(
                  children: [
                    const Text(
                      'EKG natijasi',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    oneRadioListTile(
                      const Text('Zo\'r'),
                      RestecgCharacter.excellent,
                      _restecgCharacter,
                      (value) => setState(() {
                        _restecgCharacter = value;
                        _model.restecg = 0;
                      }),
                    ),
                    oneRadioListTile(
                      const Text('Yaxshi'),
                      RestecgCharacter.good,
                      _restecgCharacter,
                      (value) => setState(() {
                        _restecgCharacter = value;
                        _model.restecg = 1;
                      }),
                    ),
                    oneRadioListTile(
                      const Text('Yomon'),
                      RestecgCharacter.bad,
                      _restecgCharacter,
                      (value) => setState(() {
                        _restecgCharacter = value;
                        _model.restecg = 2;
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                width: (deviceOrientation.index == Orientation.landscape.index)
                    ? (screenSize.width - 40) * 0.5
                    : (screenSize.width - 40) * 0.6, // 200
                child: Column(
                  children: [
                    const Text(
                      'Talassemiya',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    oneRadioListTile(
                      const Text('Normal'),
                      ThalCharacter.normal,
                      _thalCharacter,
                      (value) => setState(() {
                        _thalCharacter = value;
                        _model.thal = value.toString().substring(14);
                      }),
                    ),
                    oneRadioListTile(
                      const Text('Aniqlangan nuqson'),
                      ThalCharacter.fixed,
                      _thalCharacter,
                      (value) => setState(() {
                        _thalCharacter = value;
                        _model.thal = value.toString().substring(14);
                      }),
                    ),
                    oneRadioListTile(
                      const Text('Qaytariladigan nuqson'),
                      ThalCharacter.reversible,
                      _thalCharacter,
                      (value) => setState(() {
                        _thalCharacter = value;
                        _model.thal = value.toString().substring(14);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),
        slider(
          const Text(
            'Yosh',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          _ageCurrentSlider,
          10.0,
          100.0,
          90,
          (double value) => setState(() {
            _ageCurrentSlider = value;
            _model.age = value.toInt();
          }),
        ),
        const Divider(thickness: 1),
        slider(
          const Text(
            'Doimiy qon bosimi (mm Hg)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          _trestbpsCurrentSlider,
          60.0,
          200.0,
          140,
          (double value) => setState(() {
            _trestbpsCurrentSlider = value;
            _model.trestbps = value.toInt();
          }),
        ),
        const Divider(thickness: 1),
        slider(
          const Text(
            'Maksimal yurak urish tezligi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          _thalachCurrentSlider,
          60.0,
          202.0,
          142,
          (double value) => setState(() {
            _thalachCurrentSlider = value;
            _model.thalach = value.toInt();
          }),
        ),
        const Divider(thickness: 1),
        slider(
          const Text(
            'ST segmentining eng yuqori qiyaligi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          _slopeCurrentSlider,
          1.0,
          3.0,
          2,
          (double value) => setState(() {
            _slopeCurrentSlider = value;
            _model.slope = value.toInt();
          }),
        ),
        const Divider(thickness: 1),
        textField(
          const ValueKey('chol'),
          '126 - 564',
          'Sarum xolesterin',
          'Sarum xolesterin (mg/dl)',
          true,
          126,
          564,
          _chol,
          _validateChol,
          screenSize,
        ),
        const Divider(thickness: 1),
        textField(
          const ValueKey('oldpeak'),
          '0.0 - 6.2',
          'ST depressiyasi',
          'Jismoniy mashqlardagi ST depressiyasi',
          false,
          0.0,
          6.2,
          _oldpeak,
          _validateOldpeak,
          screenSize,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: _loading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: const Text(
                    'Tekshirish',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    _saveData();
                  },
                ),
        ),
      ],
    );
  }
}
