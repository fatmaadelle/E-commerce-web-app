import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/CustomCard.dart';
import '../widgets/ProductTable.dart';
import 'dashBoard.dart';


class productManagment extends StatefulWidget {
  const productManagment({Key? key}) : super(key: key);

  @override
  State<productManagment> createState() => _productManagmentState();
}

class _productManagmentState extends State<productManagment> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Allow vertical scrolling
          child: Container(
            width: MediaQuery.of(context).size.width * 2, // Adjust width to fit content
            height: MediaQuery.of(context).size.height * 2, // Adjust height to fit content
            color: const Color(0xffE7DFD9),
            child: Row(
              children: [
                Container(
                  width: 250,
                  child: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: ListTile(
                            leading: FaIcon(FontAwesomeIcons.tableColumns),
                            title: const Text('User Management'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashBoard()));
                            },
                          ),
                        ),
                        Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.cartShopping),
                          title: const Text('Orders'),
                          onTap: () {
                            // Handle Settings menu item selection
                          },
                        ),
                        Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.bagShopping),
                          title: const Text('Products'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductTable()));
                          },
                        ),
                        Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.chartLine),
                          title: const Text('Sales Report'),
                          onTap: () {
                            // Handle Profile menu item selection
                          },
                        ),
                        Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.message),
                          title: const Text('Messages'),
                          onTap: () {
                            // Handle Profile menu item selection
                          },
                        ),
                        Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.gears),
                          title: const Text('Settings'),
                          onTap: () {
                            // Handle Profile menu item selection
                          },
                        ),
                        Divider(
                          thickness: 0,
                          color: Colors.transparent,
                        ),
                        ListTile(
                          leading: FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                          title: const Text('Sign out'),
                          onTap: () {
                            // Handle Profile menu item selection
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CustomCard(
                            content: Column(
                              children: [
                                 ProductTable(),
                              ],
                            ),
                            color: Colors.white,
                            onTap: () {},
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
