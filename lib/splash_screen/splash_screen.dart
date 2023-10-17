import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/scenes/bottom_nav/bottom_nav_page.dart';
import 'package:lean_scale_food_app/scenes/home/category_list_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getCategories() {
    Timer(const Duration(seconds: 4), () async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const BottomNavPage()),
          (Route<dynamic> route) => false);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CategoryListProvider>(context, listen: false).getCategories();
    });
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}
