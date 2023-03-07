import 'package:flutter/material.dart';
import 'package:flutter_shop_app/model/cart.dart';

class OrderItem extends StatelessWidget {
  final CartModel e;
  const OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.image,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              e.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          Text(
            "\$${e.price}",
          ),
        ],
      ),
      subtitle: Text('Quantity: ${e.quantity.toString()}'),
    );
  }
}
