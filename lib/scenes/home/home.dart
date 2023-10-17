import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          Constants.appName,
          style: TextStyle(color: Colors.white),
        )),
        automaticallyImplyLeading: false,
      ),
    ));
  }
}
