import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class Count extends StatefulWidget {


  late String productName;
  late String productImage;
  late String productId;
  late int productPrice;
  var productUnit;


  Count({required this.productName,required this.productImage,required this.productId,required this.productPrice,
  required this.productUnit});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {

  int count = 1;
  bool isTrue = false;
  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get().then(
            (value) =>
        {
          if(this.mounted){
            if (value.exists){
              setState(() {
                count=value.get("cartQuantity");
                isTrue = value.get("isAdd");
              }),
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    ReviewCartProvider reviewCartProvider= Provider.of(context);
    return Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){

                      if(count==1) {
                        setState(() {
                          isTrue = false;
                        });

                        reviewCartProvider.reviewCartDataDelete(widget.productId);
                      } else if (count>1) {
                        setState(() {
                          count--;
                        });
                        reviewCartProvider.updateReviewCartData(
                          cartId: widget.productId,
                          cartName: widget.productName,
                          cartImage: widget.productImage,
                          cartPrice: widget.productPrice,
                          cartQuantity: count,

                        );
                      }
                    },
                    child: Icon(
                        Icons.remove, size: 18, color: Color(0xffd0b84c),
                    ),
                  ),
                  Text(
                    "$count",
                    style: TextStyle(
                        color: Color(0xffd0b84c), fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        count++;
                      });
                      reviewCartProvider.updateReviewCartData(cartId: widget.productId,
                        cartName: widget.productName,
                        cartImage: widget.productImage,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,

                      );
                    },
                    child: Icon
                      (Icons.add, size: 18, color: Color(0xffd0b84c),
                    ),
                  ),
                ],
              ) : Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isTrue = true;
                    });
                   reviewCartProvider.addReviewCartData(
                       cartId: widget.productId,
                       cartName: widget.productName,
                       cartImage: widget.productImage,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                        cartUnit: widget.productUnit,
                    );
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(color: primaryColor,fontSize: 13),
                  ),
                ),
              ));
  }
}
