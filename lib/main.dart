import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lean_scale_food_app/scenes/food_list/food_list_provider.dart';
import 'package:lean_scale_food_app/scenes/home/category_list_provider.dart';
import 'package:lean_scale_food_app/scenes/splash_screen/splash_screen.dart';
import 'package:lean_scale_food_app/utils/constants.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize hive
  await Hive.initFlutter();
  //open our boxes
  var favouriteBox = await Hive.openBox(Constants.favouriteBoxIdentifier);
  var basketBox = await Hive.openBox(Constants.basketBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryListProvider()),
        ChangeNotifierProvider(create: (context) => FoodListProvider())
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
