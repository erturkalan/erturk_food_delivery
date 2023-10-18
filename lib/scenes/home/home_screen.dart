import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/scenes/food_list/food_list_screen.dart';
import 'package:lean_scale_food_app/scenes/home/category_list_provider.dart';
import 'package:lean_scale_food_app/utils/constants.dart';
import 'package:lean_scale_food_app/widgets/custom_food_box.dart';
import 'package:lean_scale_food_app/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryListProvider>(
      builder: ((context, categoryListProvider, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.redAccent,
                title: const Text(
                  Constants.appName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                ),
                automaticallyImplyLeading: false,
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 2),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 160,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 0.54),
                          itemCount: categoryListProvider.categories.length,
                          itemBuilder: (context, index) => CustomFoodBox(
                              onPressed: () {
                                categoryListProvider
                                            .categories[index].strCategory !=
                                        null
                                    ? Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (c) => FoodListScreen(
                                                categoryName:
                                                    categoryListProvider
                                                        .categories[index]
                                                        .strCategory!)))
                                    : showDialog(
                                        context: context,
                                        builder: (ctx) => const CustomDialog(
                                              message: "Category Is Not Active",
                                            ));
                              },
                              image: categoryListProvider
                                          .categories[index].strCategoryThumb !=
                                      null
                                  ? categoryListProvider
                                      .categories[index].strCategoryThumb!
                                  : null,
                              name: categoryListProvider
                                          .categories[index].strCategory !=
                                      null
                                  ? categoryListProvider
                                      .categories[index].strCategory!
                                  : "N/A")),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
                visible: categoryListProvider.isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
          ],
        );
      }),
    );
  }
}
