class DiabeticsModel {
  int glucose;
  int bloodPressure;
  int skinThickness;
  int insulin;
  num bmi;
  num diabetesPedigreeFunction;
  int age;

  DiabeticsModel({
    required this.glucose,
    required this.bloodPressure,
    required this.skinThickness,
    required this.insulin,
    required this.bmi,
    required this.diabetesPedigreeFunction,
    required this.age,
  });

  List<double> inputToList() {
    final Map<String, double> _inputMap = {
      'glucose': this.glucose.toDouble(),
      'bloodPressure': this.bloodPressure.toDouble(),
      'skinThickness': this.skinThickness.toDouble(),
      'insulin': this.insulin.toDouble(),
      'bmi': this.bmi.toDouble(),
      'diabetesPedigreeFunction': this.diabetesPedigreeFunction.toDouble(),
      'age': this.age.toDouble(),
    };
    return _inputMap.values.toList();
  }
}

class ResultDiabetics {
  final String id;
  final num predict;
  final DiabeticsModel diabeticsModel;

  const ResultDiabetics(
      {required this.id, required this.predict, required this.diabeticsModel});
}
