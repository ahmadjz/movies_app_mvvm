import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key, required this.category});
  final CategoryObject category;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Center(
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManager.primaryColor,
              ),
        ),
      ),
    );
  }
}
