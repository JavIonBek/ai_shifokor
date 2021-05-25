import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/animations.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_bar.dart';
import '../providers/heart_disease_provider.dart';
import 'heart_disease_detail_screen.dart';
import 'heart_disease_predict_screen.dart';

class HeartDiseasesListScreen extends StatelessWidget {
  static const routeName = '/heart-disease-list';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Yurak kasalligi'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add, size: 28),
              tooltip: 'Tashxis qo\'yish',
              onPressed: () {
                Navigator.of(context)
                    .push(animationPage(HeartDiseasePredictScreen()));
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<HeartDiseaseProvider>(context, listen: false)
              .fetchAndSetHD(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<HeartDiseaseProvider>(
                  child: Center(
                    child: const Text(
                      'Yurak kasalligiga tashxis qilishni boshlang!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  builder: (ctx, heartDiseases, ch) => heartDiseases
                              .items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          itemCount: heartDiseases.items.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx, i) => Card(
                            elevation: 30.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              leading: Container(
                                padding: const EdgeInsets.only(right: 12.0),
                                decoration: const BoxDecoration(
                                  border: const Border(
                                    right: const BorderSide(
                                      width: 1.0,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '${heartDiseases.items[i].predict} %',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              title: heartDiseases.items[i].predict >= 50.0
                                  ? const Text(
                                      'Xavfli',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )
                                  : const Text(
                                      'Xavfsiz',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      child: const Icon(
                                        Icons.date_range_outlined,
                                        size: 20,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          '${heartDiseases.items[i].id}',
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, size: 30),
                                tooltip: 'Tashxisni o\'chirish',
                                onPressed: () async {
                                  try {
                                    await showDialog(
                                      context: ctx,
                                      builder: (ctx2) => AlertDialog(
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
                                              Navigator.of(ctx2).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'Ha',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            onPressed: () async {
                                              await Provider.of<
                                                          HeartDiseaseProvider>(
                                                      ctx,
                                                      listen: false)
                                                  .deleteHD(heartDiseases
                                                      .items[i].id);
                                              Navigator.of(ctx2).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  } catch (error) {
                                    print(error);
                                    ScaffoldMessenger.of(ctx).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'O\'chirilmadi!',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                color: Colors.redAccent,
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  HeartDiseaseDetailScreen.routeName,
                                  arguments: heartDiseases.items[i].id,
                                );
                              },
                            ),
                          ),
                        ),
                ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
