import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/categories/view/widgets/category_item_widget.dart';

class CategoriesGridBuilder extends StatelessWidget {
  const CategoriesGridBuilder({
    Key? key,
    required this.categories,
  }) : super(key: key);
  final List<CategoryObject> categories;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 4 / 3.5,
      ),
      itemBuilder: (context, index) {
        return CategoryItemWidget(
          category: categories[index],
        );
      },
    );
  }
}
