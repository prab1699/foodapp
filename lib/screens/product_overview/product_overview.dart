

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/wish_list_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/count.dart';
import '../review_cart/review_cart.dart';

enum SigninCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productId;
  ProductOverview(
      {required this.productName,
      required this.productImage,
      required this.productPrice,
      required this.productId});
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SigninCharacter character = SigninCharacter.fill;

  Widget BottomNavigatonBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required Function onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
          if(this.mounted){
            if(value.exists){
              setState(
                    () {
                  wishListBool = value.get("wishlist");
                },
              ),
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
   getWishListBool();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          BottomNavigatonBar(
              backgroundColor: textColor,
              color: Colors.white70,
              iconColor: Colors.grey,
              title: "Add to Wishlist",
              iconData: wishListBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                setState(() {
                  wishListBool = !wishListBool;
                });
                if (wishListBool == true) {
                  wishListProvider.addWishListData(
                      wishListId: widget.productId,
                      wishListName: widget.productName,
                      wishListImage: widget.productImage,
                      wishListPrice: widget.productPrice,
                      wishListQuantity: 2, );
                }else {
                  wishListProvider.deleteWishList(widget.productId);
                }
              }),
          BottomNavigatonBar(
            backgroundColor: primaryColor,
            color: textColor,
            iconColor: Colors.white70,
            title: "Go to Cart",
            iconData: Icons.shop_outlined,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=> ReviewCart(),
                ),
              );
            },
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text("Product Overview", style: TextStyle(color: textColor)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.productName),
                    subtitle: Text("Rs 30"),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(40),
                    child: Image.network(widget.productImage),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      "Available Options",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              value: SigninCharacter.fill,
                              groupValue: character,
                              activeColor: Colors.green[700],
                              onChanged: (value) {
                                setState(() {
                                  character = value!;
                                });
                              },
                            )
                          ],
                        ),
                        Text(
                          ('₹${widget.productPrice}'),
                        ),
                        Count(
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                          productUnit: "500gm",
                        ),
                      //  Container(
                        //  padding: EdgeInsets.symmetric(
                         //     horizontal: 30, vertical: 10),
                        //  decoration: BoxDecoration(
                          //  border: Border.all(color: Colors.grey),
                         //   borderRadius: BorderRadius.circular(30),
                         // ),
                          //child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          //  children: [
                          //    Icon(
                           //     Icons.add,
                           //     size: 17,
                          //      color: primaryColor,
                         //     ),
                         //     Text(
                            //    "ADD",
                             //   style: TextStyle(
                             //     color: primaryColor,
                            //    ),
                          //    )
                         //   ],
                       //   ),
                      //  ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About this Product",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "In marketing, a product is an object, or system, or service made available for consumer use as of the consumer demand; it is anything that can be offered to a market to satisfy the desire or need of a customer. Wikipedia.",
                    style: TextStyle(
                      fontSize: 15,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
