import 'package:flutter/cupertino.dart';

import '../model/category.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryProduct> _mList = listCategoryProduct;
  List<CategoryProduct> get mListCategory => _mList;
}
