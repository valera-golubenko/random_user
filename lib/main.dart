import 'package:flutter/material.dart';
import 'package:random_user/pages/bottom_sheet/bottom_sheet_p.dart';
import 'package:random_user/pages/home/home_p.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomSheetCustom(),
    );
  }
}
