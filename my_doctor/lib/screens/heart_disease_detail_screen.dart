import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/heart_disease_provider.dart';
import '../widgets/detail_topContent.dart';
import '../widgets/detail_bottomContent.dart';

class HeartDiseaseDetailScreen extends StatelessWidget {
  static const routeName = '/heart-disease-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedHD =
        Provider.of<HeartDiseaseProvider>(context, listen: false).findById(id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DetailTopContent(selectedHD, false),
              DetailBottomContent(selectedHD, false),
            ],
          ),
        ),
      ),
    );
  }
}
