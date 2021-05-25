import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/heart_disease_provider.dart';
import '../providers/diabetics_provider.dart';

class DetailTopContent extends StatelessWidget {
  final selectedObj;
  final bool isDiabetics;

  DetailTopContent(this.selectedObj, this.isDiabetics);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          height: 270,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: isDiabetics
                  ? const AssetImage('assets/images/diabetics.png')
                  : const AssetImage('assets/images/heart_disease.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(30.0),
          height: 270,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: const Color.fromRGBO(58, 66, 86, .8),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Icon(
                  Icons.favorite,
                  size: 40,
                  color: selectedObj.predict >= 50.0
                      ? Colors.redAccent
                      : Colors.greenAccent,
                ),
                Container(
                  width: 80,
                  child: const Divider(color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(
                  '${selectedObj.predict}%',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        child: LinearProgressIndicator(
                          backgroundColor:
                              const Color.fromRGBO(209, 224, 224, 0.2),
                          value: selectedObj.predict / 100.0,
                          valueColor: AlwaysStoppedAnimation(
                              selectedObj.predict >= 50.0
                                  ? Colors.redAccent
                                  : Colors.greenAccent),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: selectedObj.predict >= 50.0
                            ? const Text('Xavfli',
                                style: TextStyle(color: Colors.white))
                            : const Text('Xavfsiz',
                                style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                      width: 150,
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          '${selectedObj.id}',
                          style: TextStyle(color: Colors.white),
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Orqaga qaytish',
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Tashxisni o\'chirish',
                color: Colors.white,
                onPressed: () async {
                  try {
                    await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('O\'chirish!'),
                        content: const Text(
                          'Ushbu tashxis natijasini o\'chirishga ishonchingiz komilmi?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            child: const Text(
                              'Yo\'q',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Ha',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () async {
                              Navigator.of(ctx).pop();
                              isDiabetics
                                  ? await Provider.of<DiabeticsProvider>(
                                          context,
                                          listen: false)
                                      .deleteDiabetics(selectedObj.id)
                                  : await Provider.of<HeartDiseaseProvider>(
                                          context,
                                          listen: false)
                                      .deleteHD(selectedObj.id);
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  } catch (error) {
                    print(error);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'O\'chirilmadi!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
