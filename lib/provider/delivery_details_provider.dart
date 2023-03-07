import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dialog/dialog.dart';
import 'package:flutter_shop_app/model/cart.dart';
import 'package:flutter_shop_app/model/delivery_address.dart';
import 'package:flutter_shop_app/screens/my_home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/history_order.dart';

class DeliveryDetailsProvider extends ChangeNotifier {
  bool isloadding = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  // LocationData setLoaction;
  void clearForm() {
    firstName.text = "";
    lastName.text = "";
    street.text = "";
    landmark.text = "";
    city.text = "";
    phoneNumber.text = "";
  }

  void validator(context, myType) async {
    String idAddress = DateTime.now().millisecondsSinceEpoch.toString();
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (phoneNumber.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone number is empty");
    } else {
      DialogProvider().showDialogLoading(context);
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourAdress")
          .doc(idAddress)
          .set({
        "idAddress": idAddress,
        "firstname": firstName.text,
        "lastname": lastName.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "phoneNumber": phoneNumber.text,
        "addressType": myType.toString(),
        // "longitude": setLoaction.longitude,
        // "latitude": setLoaction.latitude,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        clearForm();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  removeDeliveryAddress(
      String idAddress, int index, BuildContext context) async {
    FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourAdress")
        .doc(idAddress)
        .delete()
        .then((value) async {
      await Fluttertoast.showToast(msg: "Delete your deliver address ");
      deliveryAdressList.removeAt(index);
      notifyListeners();
    });
  }

  List<DeliveryAddress> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddress> newList = [];

    QuerySnapshot db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourAdress")
        .get();
    for (var element in db.docs) {
      DeliveryAddress deliveryAddress = DeliveryAddress(
        firstName: element.get("firstname"),
        lastName: element.get("lastname"),
        addressType: element.get("addressType"),
        phoneNumber: element.get("phoneNumber"),
        city: element.get("city"),
        landMark: element.get("landmark"),
        id: element.get("idAddress"),
        street: element.get("street"),
      );
      newList.add(deliveryAddress);
    }
    deliveryAdressList = newList;
    notifyListeners();
  }

  addPlaceOderData(
    BuildContext context,
    String name,
    String street,
    String phoneNumber, {
    List<CartModel>? oderItemList,
    var subTotal,
    var address,
    var shipping,
  }) async {
    DialogProvider().showDialogLoading(context);
    FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyOrders")
        .doc()
        .set(
      {
        "subTotal": subTotal + 10 - 30,
        "Shipping Charge": "10",
        "Discount": "30",
        "name": name,
        "street": street,
        "phoneNumber": phoneNumber,
        "orderItems": oderItemList!
            .map((e) => {
                  "orderTime": DateTime.now(),
                  "orderImage": e.image,
                  "orderName": e.name,
                  "orderPrice": e.price,
                  "orderQuantity": e.quantity
                })
            .toList(),
      },
    ).then((value) {
      Fluttertoast.showToast(msg: 'Order');
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MyHomePage(title: ''),
      ));
    });
  }

  List<HistoryOrder> _orderItemHistory = [];
  getOrderItem() async {
    var i = FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyOrders")
        .doc()
        .get()
        .then((value) {
      // for (var element in List.from(value.data['oderItems'])) {
      //   OrderItem orderItem = OrderItem(
      //       orderTime: element('orderTime'),
      //       orderImage: element('orderImage'),
      //       orderName: element('orderName'),
      //       orderPrice: element('orderPrice'),
      //       orderQuantity: element('orderQuantity'));
      //   orderItemList.add(orderItem);
      // }
    });
    print('jdnjsadnj $i');
    List<HistoryOrder> newListOrd = [];
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyOrders")
        .get();
    for (var i in query.docs) {
      HistoryOrder historyOrder = HistoryOrder(
        discount: i.get('Discount'),
        shipper: i.get('Shipping Charge'),
        name: i.get('name'),
        phoneNumber: i.get('phoneNumber'),
        street: i.get('street'),
        totalAmount: i.get('subTotal'),
        orderItem: List.from(i.get('orderItems')),
      );
      newListOrd.add(historyOrder);
    }
    _orderItemHistory = newListOrd;

    notifyListeners();
  }

  List<HistoryOrder> get getListHistoryOrder => _orderItemHistory;

  Future<void> deleteAllCart() async {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCart")
        .get()
        .then((value) => ({
              for (DocumentSnapshot ds in value.docs) {ds.reference.delete()}
            }));
  }

  List<DeliveryAddress> get getListDeliveryAddres => deliveryAdressList;
}
