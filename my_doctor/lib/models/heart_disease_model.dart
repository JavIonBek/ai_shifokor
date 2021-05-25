import 'package:flutter/foundation.dart';

class HeartDiseaseModel {
  int sex;
  int cp;
  int fbs;
  int restecg;
  int exang;
  String thal;
  int ca;
  int age;
  int trestbps;
  int chol;
  int thalach;
  num oldpeak;
  int slope;

  HeartDiseaseModel({
    this.sex,
    this.cp,
    this.fbs,
    this.restecg,
    this.exang,
    this.thal,
    this.ca,
    this.age,
    this.trestbps,
    this.chol,
    this.thalach,
    this.oldpeak,
    this.slope,
  });

  // Convert user input data to List of (1, 27) shape
  Map<String, double> _inputData = {
    'sex_0': 0.0,
    'sex_1': 0.0,
    'cp_0': 0.0,
    'cp_1': 0.0,
    'cp_2': 0.0,
    'cp_3': 0.0,
    'cp_4': 0.0,
    'fbs_0': 0.0,
    'fbs_1': 0.0,
    'restecg_0': 0.0,
    'restecg_1': 0.0,
    'restecg_2': 0.0,
    'exang_0': 0.0,
    'exang_1': 0.0,
    'thal_fixed': 0.0,
    'thal_normal': 0.0,
    'thal_reversible': 0.0,
    'ca_0': 0.0,
    'ca_1': 0.0,
    'ca_2': 0.0,
    'ca_3': 0.0,
    'age': 0.0,
    'trestbps': 0.0,
    'chol': 0.0,
    'thalach': 0.0,
    'oldpeak': 0.0,
    'slope': 0.0
  };

  // @override
  List<double> inputToList() {
    final Map<String, dynamic> _inputMap = {
      'sex': this.sex,
      'cp': this.cp,
      'fbs': this.fbs,
      'restecg': this.restecg,
      'exang': this.exang,
      'thal': this.thal,
      'ca': this.ca,
      'age': this.age,
      'trestbps': this.trestbps,
      'chol': this.chol,
      'thalach': this.thalach,
      'oldpeak': this.oldpeak,
      'slope': this.slope,
    };

    _inputMap.forEach((k, v) {
      _inputData.forEach((k2, v2) {
        if (k == k2) {
          _inputData[k2] = v.toDouble();
        } else if (k2.contains(k)) {
          if (k2.contains(v.toString())) _inputData[k2] = 1.0;
        }
      });
    });

    return _inputData.values.toList();
  }
}

class ResultHeartDisease {
  final String id;
  final num predict;
  final HeartDiseaseModel hdModel;

  const ResultHeartDisease(
      {@required this.id, @required this.predict, @required this.hdModel});
}
