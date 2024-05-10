import 'package:fahem/core/resources/assets_manager.dart';
import 'package:fahem/core/resources/values_manager.dart';
import 'package:fahem/presentation/screens/categories/controllers/categories_provider.dart';
import 'package:fahem/presentation/screens/categories/widgets/public_relation_category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories5Grid extends StatefulWidget {

  const Categories5Grid({super.key});

  @override
  State<Categories5Grid> createState() => _Categories5GridState();
}

class _Categories5GridState extends State<Categories5Grid> {
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
              if(categoriesProvider.categories.length > 0) PublicRelationCategoryItem(
                categoryModel: categoriesProvider.categories[0],
                height: SizeManager.s225,
                linesImage: ImagesManager.lines3,
              ),
              const SizedBox(height: SizeManager.s10),
              if(categoriesProvider.categories.length > 1) PublicRelationCategoryItem(
                categoryModel: categoriesProvider.categories[1],
                height: SizeManager.s185,
                linesImage: ImagesManager.lines1,
              ),
            ],
          ),
        ),
        const SizedBox(width: SizeManager.s10),
        Expanded(
          child: Column(
            children: [
              if(categoriesProvider.categories.length > 2) PublicRelationCategoryItem(
                categoryModel: categoriesProvider.categories[2],
                height: SizeManager.s100,
                linesImage: ImagesManager.lines1,
              ),
              const SizedBox(height: SizeManager.s10),
              if(categoriesProvider.categories.length > 3) PublicRelationCategoryItem(
                categoryModel: categoriesProvider.categories[3],
                height: SizeManager.s200,
                linesImage: ImagesManager.lines3,
              ),
              const SizedBox(height: SizeManager.s10),
              if(categoriesProvider.categories.length > 4) PublicRelationCategoryItem(
                categoryModel: categoriesProvider.categories[4],
                height: SizeManager.s100,
                linesImage: ImagesManager.lines3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}