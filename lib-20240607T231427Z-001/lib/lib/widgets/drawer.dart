
import 'package:ecommerce_app/lib/pages/sales.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/dashBoard.dart';
import '../pages/orders.dart';
import '../widgets/ProductTable.dart';

class defaultDrawer extends StatelessWidget {
  const defaultDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              color: Colors.black,
              child: ListTile(
                leading: FaIcon(FontAwesomeIcons.tableColumns,
                color: Colors.red,),
                title: const Text('User Management',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashBoard()));
                },
              ),
            ),
          ),
          Divider(
            thickness: 0,
            color: Colors.white,
          ),
          Container(
            color: Colors.black,
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.cartShopping,
                color: Colors.green,
              ),
              title: const Text('Orders',
                style: TextStyle(
                  color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewOrders()));
              },
            ),
          ),
          Divider(
            thickness: 0,
            color: Colors.white,
          ),
          Container(
            color: Colors.black,
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.bagShopping,
              color: Colors.indigo,),
              title: const Text('Products',
                style: TextStyle(
                  color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductTable()));
              },
            ),
          ),
          Divider(
            thickness: 0,
            color: Colors.black,
          ),
          Container(
            color: Colors.black,
            child: ListTile(
              leading: FaIcon(FontAwesomeIcons.chartLine,color: Colors.blue[500],),
              title: const Text('Sales Report',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SalesReportPage()));
              },
            ),
          ),
          Divider(
            thickness: 0,
            color: Colors.black,
          ),


        ],
      ),
    );
  }
}
