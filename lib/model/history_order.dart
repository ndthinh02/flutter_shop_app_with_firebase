class HistoryOrder {
  String discount;
  String shipper;
  String name;
  String phoneNumber;
  String street;
  var totalAmount;
  List<dynamic> orderItem;
  HistoryOrder(
      {required this.discount,
      required this.shipper,
      required this.name,
      required this.phoneNumber,
      required this.street,
      required this.totalAmount,
      required this.orderItem});
}

class OrderItem {
  String orderTime;
  String orderImage;
  String orderName;
  var orderPrice;
  var orderQuantity;
  OrderItem(
      {required this.orderTime,
      required this.orderImage,
      required this.orderName,
      required this.orderPrice,
      required this.orderQuantity});
}
