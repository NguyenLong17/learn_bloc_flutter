import 'package:flutter/material.dart';
import 'package:mini_shop/mini_shop/widget/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

AppBar buildAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  Color? backgroudColor,
}) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: backgroudColor ?? Colors.pinkAccent,
    actions: actions,
    centerTitle: true,
  );
}
