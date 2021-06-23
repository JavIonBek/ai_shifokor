import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:intl/intl.dart';

import '../models/heart_disease_model.dart';
import '../helpers/db_helper.dart';

class HeartDiseaseProvider with ChangeNotifier {
  List<ResultHeartDisease> _items = [];

  List<ResultHeartDisease> get items {
    return [..._items];
  }

  ResultHeartDisease findById(String id) {
    return _items.firstWhere((resHD) => resHD.id == id);
  }

  Future<void> predictAndAddHD(
      int sex,
      int cp,
      int fbs,
      int restecg,
      int exang,
      String thal,
      int ca,
      int age,
      int trestbps,
      int chol,
      int thalach,
      num oldpeak,
      int slope) async {
    try {
      final newHD = HeartDiseaseModel(
        sex: sex,
        cp: cp,
        fbs: fbs,
        restecg: restecg,
        exang: exang,
        thal: thal,
        ca: ca,
        age: age,
        trestbps: trestbps,
        chol: chol,
        thalach: thalach,
        oldpeak: oldpeak,
        slope: slope,
      );

      // ********** Prediction **********
      final Interpreter _interpreter =
          await Interpreter.fromAsset('tflite_models/heart_disease.tflite');
      // input of shape [1, 27].
      final List<List<double>> input = [newHD.inputToList()];
      // output of shape [1, 1].
      final output = List<double>.filled(1 * 1, 0).reshape([1, 1]);
      // The run method will run inference and store the resulting values in output.
      _interpreter.run(input, output);
      // Closing the interpreter
      _interpreter.close();

      final num predict =
          num.tryParse((output[0][0] * 100).toStringAsFixed(2)) ?? 0;
      // *********************************

      final String dateTimeId =
          DateFormat('d-M-y HH:mm:ss').format(DateTime.now());
      final addHD = ResultHeartDisease(
        id: dateTimeId,
        predict: predict,
        hdModel: newHD,
      );
      _items.insert(0, addHD);
      notifyListeners();
      await DBHelper.insert('heart_diseases', {
        'id': addHD.id,
        'predict': addHD.predict,
        'sex': addHD.hdModel.sex,
        'cp': addHD.hdModel.cp,
        'fbs': addHD.hdModel.fbs,
        'restecg': addHD.hdModel.restecg,
        'exang': addHD.hdModel.exang,
        'thal': addHD.hdModel.thal,
        'ca': addHD.hdModel.ca,
        'age': addHD.hdModel.age,
        'trestbps': addHD.hdModel.trestbps,
        'chol': addHD.hdModel.chol,
        'thalach': addHD.hdModel.thalach,
        'oldpeak': addHD.hdModel.oldpeak,
        'slope': addHD.hdModel.slope,
      });
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetHD() async {
    try {
      final dataList = await DBHelper.getData('heart_diseases');
      _items = dataList.reversed
          .map(
            (item) => ResultHeartDisease(
              id: item['id'].toString(),
              predict: num.parse(item['predict'].toString()),
              hdModel: HeartDiseaseModel(
                sex: int.parse(item['sex'].toString()),
                cp: int.parse(item['cp'].toString()),
                fbs: int.parse(item['fbs'].toString()),
                restecg: int.parse(item['restecg'].toString()),
                exang: int.parse(item['exang'].toString()),
                thal: item['thal'].toString(),
                ca: int.parse(item['ca'].toString()),
                age: int.parse(item['age'].toString()),
                trestbps: int.parse(item['trestbps'].toString()),
                chol: int.parse(item['chol'].toString()),
                thalach: int.parse(item['thalach'].toString()),
                oldpeak: num.parse(item['oldpeak'].toString()),
                slope: int.parse(item['slope'].toString()),
              ),
            ),
          )
          .toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteHD(String id) async {
    try {
      final existingHDIndex = _items.indexWhere((resHD) => resHD.id == id);
      _items.removeAt(existingHDIndex);
      await DBHelper.delete('heart_diseases', id);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
