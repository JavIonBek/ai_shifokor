import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:intl/intl.dart';

import '../helpers/db_helper.dart';
import '../models/diabetics_model.dart';

class DiabeticsProvider with ChangeNotifier {
  List<ResultDiabetics> _items = [];

  List<ResultDiabetics> get items {
    return [..._items];
  }

  ResultDiabetics findById(String id) {
    return _items.firstWhere((resDiabetics) => resDiabetics.id == id);
  }

  Future<void> predictAndAddDiabetics(
    int glucose,
    int bloodPressure,
    int skinThickness,
    int insulin,
    num bmi,
    num diabetesPedigreeFunction,
    int age,
  ) async {
    try {
      final newDiabetics = DiabeticsModel(
        glucose: glucose,
        bloodPressure: bloodPressure,
        skinThickness: skinThickness,
        insulin: insulin,
        bmi: bmi,
        diabetesPedigreeFunction: diabetesPedigreeFunction,
        age: age,
      );

      // ********** Prediction **********
      final Interpreter _interpreter =
          await Interpreter.fromAsset('tflite_models/diabetics.tflite');
      // input of shape [1, 7].
      final List<List<double>> input = [newDiabetics.inputToList()];
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
      final addDiabetics = ResultDiabetics(
        id: dateTimeId,
        predict: predict,
        diabeticsModel: newDiabetics,
      );
      _items.insert(0, addDiabetics);
      notifyListeners();
      await DBHelper.insert('diabetics', {
        'id': addDiabetics.id,
        'predict': addDiabetics.predict,
        'glucose': addDiabetics.diabeticsModel.glucose,
        'bloodPressure': addDiabetics.diabeticsModel.bloodPressure,
        'skinThickness': addDiabetics.diabeticsModel.skinThickness,
        'insulin': addDiabetics.diabeticsModel.insulin,
        'bmi': addDiabetics.diabeticsModel.bmi,
        'diabetesPedigreeFunction':
            addDiabetics.diabeticsModel.diabetesPedigreeFunction,
        'age': addDiabetics.diabeticsModel.age,
      });
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetDiabetics() async {
    try {
      final dataList = await DBHelper.getData('diabetics');
      _items = dataList.reversed
          .map(
            (item) => ResultDiabetics(
              id: item['id'],
              predict: item['predict'],
              diabeticsModel: DiabeticsModel(
                glucose: item['glucose'],
                bloodPressure: item['bloodPressure'],
                skinThickness: item['skinThickness'],
                insulin: item['insulin'],
                bmi: item['bmi'],
                diabetesPedigreeFunction: item['diabetesPedigreeFunction'],
                age: item['age'],
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

  Future<void> deleteDiabetics(String id) async {
    try {
      final existingDiabeticsIndex =
          _items.indexWhere((resDiabetics) => resDiabetics.id == id);
      _items.removeAt(existingDiabeticsIndex);
      await DBHelper.delete('diabetics', id);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
