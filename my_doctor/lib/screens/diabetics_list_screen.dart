import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/animations.dart';
import '../providers/diabetics_provider.dart';
import '../providers/dark_theme_provider.dart';
import 'diabetics_detail_screen.dart';
import 'diabetics_predict_screen.dart';

class DiabeticsListScreen extends StatelessWidget {
  static const routeName = '/diabetics-list';

  @override
  Widget build(BuildContext context) {
    final themeChange =
        Provider.of<DarkThemeProvider>(context); // listen: false
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Qandli diabet'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                themeChange.darkTheme = !themeChange.darkTheme;
              },
              icon: themeChange.darkTheme
                  ? const Icon(Icons.wb_sunny, color: Colors.white)
                  : const Icon(Icons.brightness_3, color: Colors.white),
              tooltip: themeChange.darkTheme ? 'Kunduzgi rejim' : 'Tungi rejim',
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<DiabeticsProvider>(context, listen: false)
              .fetchAndSetDiabetics(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<DiabeticsProvider>(
                  child: Center(
                    child: const Text(
                      'Qandli diabetga tashxis qilishni boshlang!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  builder: (ctx, diabetics, ch) => diabetics.items.length <= 0
                      ? ch!
                      : ListView.builder(
                          itemCount: diabetics.items.length,
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
                                  '${diabetics.items[i].predict} %',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              title: diabetics.items[i].predict >= 50.0
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
                                          '${diabetics.items[i].id}',
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
                                            'Ushbu tashxis natijasini o\'chirishga ishonchingiz komilmi?'),
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
                                                          DiabeticsProvider>(
                                                      ctx,
                                                      listen: false)
                                                  .deleteDiabetics(
                                                      diabetics.items[i].id);
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
                                  DiabeticsDetailScreen.routeName,
                                  arguments: diabetics.items[i].id,
                                );
                              },
                            ),
                          ),
                        ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 28,
              color: Colors.white,
            ),
            tooltip: 'Tashxis qo\'yish',
            onPressed: () {
              Navigator.of(context)
                  .push(animationPage(DiabeticsPredictScreen()));
            },
          ),
          onPressed: () {
            Navigator.of(context).push(animationPage(DiabeticsPredictScreen()));
          },
        ),
      ),
    );
  }
}
