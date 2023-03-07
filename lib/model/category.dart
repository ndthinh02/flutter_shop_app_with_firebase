import 'package:flutter/material.dart';

class CategoryProduct extends ChangeNotifier {
  String name;
  IconData icon;
  int? selectedIndex;
  CategoryProduct({required this.name, required this.icon, this.selectedIndex});
  void changeColorSelected(int index) {
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
    name: 'Headphones',
    icon: (Icons.book_online_outlined),
  ),
  CategoryProduct(
    name: 'Mouse',
    icon: (Icons.mouse),
  ),
];
