import 'package:flutter/material.dart';
class ProductUnit  extends StatelessWidget {
  final Function onTap;
  final String   title;
  ProductUnit({
    required this.onTap,
    required this.title
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
       onTap();
      },
      child: Container(
          padding: EdgeInsets.only(left: 5),
          height: 20,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                    '$title',
                    style: TextStyle(fontSize: 10),
                  )),
              Center(
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                  color: Color(0xffd0b84c),
                ),
              )
            ],
          )),
    );
  }
}
