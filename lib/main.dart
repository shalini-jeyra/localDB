import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:w2s_task/pages/pages.dart';

import 'models/user.dart';

void main()async {
  Hive.registerAdapter(UserAdapter());
   await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ApiService().getService();
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
