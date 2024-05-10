import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/presentation/screens/categories/controllers/categories_provider.dart';
import 'package:fahem/presentation/screens/categories/widgets/lawyer_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories6Grid extends StatefulWidget {

  const Categories6Grid({super.key});

  @override
  State<Categories6Grid> createState() => _Categories6GridState();
}

class _Categories6GridState extends State<Categories6Grid> {
  late CategoriesProvider categoriesProvider;

  @override
  void initState() {
    super.initState();
    categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              if(categoriesProvider.categories.length > 0) LawyerCategoryItem(
                categoryModel: categoriesProvider.categories[0],
                height: SizeManager.s150,
                linesImage: ImagesManager.lines3,
              ),
              const SizedBox(height: SizeManager.s10),
              if(categoriesProvider.categories.length > 1) LawyerCategoryItem(
                categoryModel: categoriesProvider.categories[1],
                height: SizeManager.s100,
                linesImage: ImagesManager.lines1,
              ),
              const SizedBox(height: SizeManager.s10),
              if(categoriesProvider.categories.length > 2) LawyerCategoryItem(
                categoryModel: categoriesProvider.categories[2],
                height: SizeManager.s125,
                linesImage: ImagesManager.lines2,
              ),
            ],
          ),
        ),
        const SizedBox(width: SizeManager.s10),
        Expanded(
          child: Column(
            children: [
              if(categoriesProvider.categories.length > 3) LawyerCategoryItem(
                categoryModel: categoriesProvider.categories[3],
                height: SizeManager.s100,
                linesImage: ImagesManager.lines1,
              ),
              const SizedBox(height: SizeManager.s10),
              if(categoriesProvider.categories.length > 4) LawyerCategoryItem(
                categoryModel: categoriesProvider.categories[4],
                height: SizeManager.s125,
                linesImage: ImagesManager.lines3,
              ),
              const SizedBox(height: SizeManager.s10),
              if(categoriesProvider.categories.length > 5) LawyerCategoryItem(
                categoryModel: categoriesProvider.categories[5],
                height: SizeManager.s150,
                linesImage: ImagesManager.lines3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}