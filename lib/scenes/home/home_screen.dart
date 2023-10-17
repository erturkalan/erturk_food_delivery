import 'package:flutter/material.dart';
import 'package:lean_scale_food_app/scenes/home/category_list_provider.dart';
import 'package:lean_scale_food_app/utils/constants.dart';
import 'package:lean_scale_food_app/widgets/custom_food_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CategoryListProvider>(
        builder: ((context, categoryListProvider, child) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white38,
                appBar: AppBar(
                  backgroundColor: Colors.redAccent,
                  title: const Center(child: Text(Constants.appName)),
                  automaticallyImplyLeading: false,
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 160,
                                    crossAxisSpacing: 8,
                                    childAspectRatio: 0.54),
                            itemCount: categoryListProvider.categories.length,
                            itemBuilder: (context, index) => CustomFoodBox(
                                onPressed: () {
                                  //TODO: Go to Food List
                                  print("pressed");
                                },
                                image: categoryListProvider.categories[index]
                                            .strCategoryThumb !=
                                        null
                                    ? categoryListProvider
                                        .categories[index].strCategoryThumb!
                                    : null,
                                title: categoryListProvider
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
      ),
    );
  }
}
