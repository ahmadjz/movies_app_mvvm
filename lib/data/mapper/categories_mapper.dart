import 'package:movies_app_mvvm/app/extensions.dart';
import 'package:movies_app_mvvm/app/resources/constants_manager.dart';
import 'package:movies_app_mvvm/data/response/responses.dart';
import 'package:movies_app_mvvm/domain/model/all_categories_model.dart';

extension CategoryMapper on CategoryResponse? {
  CategoryObject toDomain() {
    return CategoryObject(
      id: this?.id.orZero() ?? AppConstants.zero,
      title: this?.title.orEmpty() ?? AppConstants.empty,
    );
  }
}

extension AllCategoriesResponseMapper on AllCategoriesResponse? {
  AllCategoriesObject toDomain() {
    List<CategoryObject> categories = (this
                ?.categories
                ?.map((categoryResponse) => categoryResponse.toDomain()) ??
            const Iterable.empty())
        .cast<CategoryObject>()
        .toList();

    return AllCategoriesObject(categories: categories);
  }
}
