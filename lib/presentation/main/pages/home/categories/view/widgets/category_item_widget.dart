import 'package:flutter/material.dart';
import 'package:movies_app_mvvm/app/dependency_injection.dart';
import 'package:movies_app_mvvm/app/resources/color_manager.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';
import 'package:movies_app_mvvm/presentation/main/pages/home/movies/view/home_page_movies_view.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key, required this.category});
  final CategoryObject category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        initHomeMoviesModule();
        Navigator.of(context, rootNavigator: false).push(
          MaterialPageRoute(
            builder: (context) => HomePageMoviesView(categoryObject: category),
          ),
        );
      },
      child: Card(
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
      ),
    );
  }
}
