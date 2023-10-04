import 'package:flutter/material.dart';
import 'package:news_app/utils/responsive.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Nothing is saved !!....',
          style: TextStyle(fontSize: R.sw(20, context)),
        ),
      ),
    );
  }
}
