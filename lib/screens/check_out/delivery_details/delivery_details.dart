import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:food_app/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:food_app/screens/check_out/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  late DeliveryAddressModel  value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider=Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Delivery Details"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliveryAddress(),
              ),
          );
        },
      ),
      bottomNavigationBar: Container(
          // width: 160,
          height: 48,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: MaterialButton(
            child:  deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Text("Add New Address")
                : Text("Payment Summary"),
            onPressed: () {
              deliveryAddressProvider.getDeliveryAddressList.isEmpty
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddDeliveryAddress(),
                      ),
                    )
                  : Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentSummary(
                          deliveryAddressList: value,
                        ),
                      ),
                    );
            },
            color: primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),
            leading: Image.asset(
              "assets/location.png",
              height: 27,
            ),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty ?
           Container(
           child: Center(child: Text("No Data",),
           ),
           )
          :Column(
            children: deliveryAddressProvider.getDeliveryAddressList
                .map<Widget>((e){
                  setState(() {
                    value=e;
                  });
                  return SingleDeliveryItem(
                       address:
                       "HouseNo- ${e.houseNo}, Area- ${e.area},Landmark- ${e.landMark},City- ${e.city},State- ${e.state},Pincode-${e.pincode}",
                       title: "${e.firstName} ${e.lastName}",
                        number: e.mobileNo,
                       addressType: e.addressType == "AddressTypes.Other" ?"Other" :
                       e.addressType =="AddressTypes.Home"
                           ?"Home"
                           :"Work"
                      );
            })
                .toList(),

          )
        ],
      ),
    );
  }
}
