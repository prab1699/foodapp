import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import '../../auth/sign_in.dart';
import '../../providers/user_provider.dart';
import '../home/drawer_side.dart';

class MyProfile extends StatelessWidget {
  void _logout(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(
        builder: (context) => SignIn()));
  }

  Widget listTile({required IconData icon,required String title,required onTap(), required Color tileColor }) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          tileColor: scaffoldBackgroundColor,
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: Text("My Profile",
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            )),
      ),
      drawer: DrawerSide(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                color: primaryColor,
              ),
              Container(
                height: 567,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 250,
                          height: 120,
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Prabhjot Singh",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("prab1671@gmail.com"),
                                ],
                              ),
                              CircleAvatar(
                                radius: 13,
                                backgroundColor: primaryColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black45,
                                  ),
                                  backgroundColor: scaffoldBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    listTile(
                      tileColor: scaffoldBackgroundColor,
                      icon: Icons.shop_outlined,
                      title: "My Orders",
                      onTap: () {
                        // Handle My Orders tap
                      },
                    ),
                    listTile(
                      tileColor: scaffoldBackgroundColor,
                      icon: Icons.location_on_outlined,
                      title: "My Delivery address",
                      onTap: () {
                        // Handle My Delivery address tap
                      },
                    ),
                    listTile(
                      tileColor: scaffoldBackgroundColor,
                      icon: Icons.person_outline,
                      title: "Refer A Friends",
                      onTap: () {
                        // Handle Refer A Friends tap
                      },
                    ),
                    listTile(
                      tileColor: scaffoldBackgroundColor,
                      icon: Icons.file_copy,
                      title: "Terms & Conditions",
                      onTap: () {
                        // Handle Terms & Conditions tap
                      },
                    ),
                    listTile(
                      tileColor: scaffoldBackgroundColor,
                      icon: Icons.policy_outlined,
                      title: "Privacy Policy",
                      onTap: () {
                        // Handle Privacy Policy tap
                      },
                    ),
                    listTile(
                      tileColor: scaffoldBackgroundColor,
                      icon: Icons.add_chart_outlined,
                      title: "About",
                      onTap: () {
                        // Handle About tap
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  _logout(context); // Call the logout function
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ), backgroundColor:  Color(0xffcbcbcb),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                ),
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.black87,fontSize: 16),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://s3.envato.com/files/328957910/vegi_thumb.png"),
                radius: 50,
                backgroundColor: scaffoldBackgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
