import 'package:flutter/material.dart';

class CategoryProduct extends ChangeNotifier {
  String name;
  IconData icon;
  int? selectedIndex;
  CategoryProduct({required this.name, required this.icon, this.selectedIndex});
  void changeColorSelected(int index) {
    print('object${index}');
    selectedIndex = index;
    notifyListeners();
  }
}

List<CategoryProduct> listCategoryProduct = [
  CategoryProduct(
    name: 'Phone',
    icon: (Icons.smartphone_outlined),
  ),
  CategoryProduct(
    name: 'Laptop',
    icon: (Icons.laptop_outlined),
  ),
  CategoryProduct(
    name: 'Book',
    icon: (Icons.book_online_outlined),
  ),
  CategoryProduct(
    name: 'Healthy',
    icon: (Icons.favorite_border_outlined),
  ),
  CategoryProduct(
    name: 'Phone',
    icon: (Icons.smartphone_outlined),
  ),
  CategoryProduct(
    name: 'Laptop',
    icon: (Icons.laptop_outlined),
  ),
  CategoryProduct(
    name: 'Book',
    icon: (Icons.book_online_outlined),
  ),
  CategoryProduct(
    name: 'Healthy',
    icon: (Icons.favorite_border_outlined),
  ),
];
