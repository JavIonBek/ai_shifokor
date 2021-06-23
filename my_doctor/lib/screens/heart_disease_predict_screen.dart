import 'package:flutter/material.dart';

import '../widgets/heart_disease_form.dart';

class HeartDiseasePredictScreen extends StatelessWidget {
  static const routeName = '/heart-disease';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tashxis qo\'yish'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'Ma\'lumotlarni kiriting',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                HeartDiseaseForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
