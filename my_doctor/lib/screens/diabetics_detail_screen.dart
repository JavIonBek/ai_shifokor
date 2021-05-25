import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/diabetics_provider.dart';
import '../widgets/detail_topContent.dart';
import '../widgets/detail_bottomContent.dart';

class DiabeticsDetailScreen extends StatelessWidget {
  static const routeName = '/diabetics-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedDiabetics =
        Provider.of<DiabeticsProvider>(context, listen: false).findById(id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DetailTopContent(selectedDiabetics, true),
              DetailBottomContent(selectedDiabetics, true),
            ],
          ),
        ),
      ),
    );
  }
}
