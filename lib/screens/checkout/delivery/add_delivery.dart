import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/delivery_details_provider.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:flutter_shop_app/ui/text_input.dart';
import 'package:provider/provider.dart';

import '../../../ui/text.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;

  DeliveryDetailsProvider get deliveryDetailsProvider =>
      context.read<DeliveryDetailsProvider>();
  @override
  Widget build(BuildContext context) {
    // CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add delivery address',
          style: MyTextStyle().textAppbar,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              deliveryDetailsProvider.validator(context, myType);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colorMain,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
            ),
            child: const Text(
              "Add Address",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            TextInput(
                labelText: 'First name',
                textEditingController: deliveryDetailsProvider.firstName,
                hintText: 'First name',
                isShowPass: false),
            TextInput(
                labelText: 'Last name',
                textEditingController: deliveryDetailsProvider.lastName,
                hintText: 'Last name',
                isShowPass: false),
            TextInput(
                labelText: 'Street',
                textEditingController: deliveryDetailsProvider.street,
                hintText: 'Street',
                isShowPass: false),
            TextInput(
                labelText: 'Landmark',
                textEditingController: deliveryDetailsProvider.landmark,
                hintText: 'Landmark',
                isShowPass: false),
            TextInput(
                labelText: 'City',
                textEditingController: deliveryDetailsProvider.city,
                hintText: 'City',
                isShowPass: false),
            TextInput(
                textInputType: TextInputType.number,
                labelText: 'Phone number',
                textEditingController: deliveryDetailsProvider.phoneNumber,
                hintText: 'Phone number',
                isShowPass: false),
            InkWell(
              onTap: () {
                //  Navigator.of(context).push(
                //     MaterialPageRoute(
                //       builder: (context) => CostomGoogleMap(),
                //     ),
                //   );
              },
              child: SizedBox(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // checkoutProvider.setLoaction == null? Text("Set Loaction"):
                    // Text("Done!"),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile(
              value: AddressTypes.Home,
              groupValue: myType,
              title: const Text("Home"),
              onChanged: (value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: const Icon(
                Icons.home,
                color: colorGreen,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: const Text("Work"),
              onChanged: (value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: const Icon(
                Icons.work,
                color: colorGreen,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: const Text("Other"),
              onChanged: (value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: const Icon(
                Icons.devices_other,
                color: colorGreen,
              ),
            )
          ],
        ),
      ),
    );
  }
}
