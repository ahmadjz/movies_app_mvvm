class CategoryObject {
  int id;
  String title;
  CategoryObject({
    required this.id,
    required this.title,
  });
}

class AllCategoriesObject {
  List<CategoryObject> categories;
  AllCategoriesObject({
    required this.categories,
  });
}
