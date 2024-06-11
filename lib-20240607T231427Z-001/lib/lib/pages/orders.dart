import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../app/data/models/order_model.dart';
import '../widgets/drawer.dart';

class ViewOrders extends StatefulWidget {
  @override
  _ViewOrdersState createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  List<OrderModel> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final ordersRef = FirebaseFirestore.instance.collection('orders');
    final ordersSnapshot = await ordersRef.get();
    setState(() {
      _orders = ordersSnapshot.docs.map((doc) => OrderModel.fromDocument(doc)).toList();
    });
  }

  Future<void> _updateOrderState(String orderId, String newState) async {
    // Update order state in 'orders' collection
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'orderStatus': newState,
    });

    // Update order state in 'users/orders' collection for each user
    final usersRef = FirebaseFirestore.instance.collection('users');
    final usersSnapshot = await usersRef.get();
    for (var userDoc in usersSnapshot.docs) {
      final uid = userDoc.id;
      final orderDoc = await usersRef.doc(uid).collection('orders').doc(orderId).get();
      if (orderDoc.exists) {
        await usersRef.doc(uid).collection('orders').doc(orderId).update({
          'orderStatus': newState,
        });
      }
    }
  }

  Future<void> _updateAcceptanceStatus(String orderId, String newStatus) async {
    // Update acceptance status in 'orders' collection
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'acceptanceStatus': newStatus,
    });

    // Update order state in 'users/orders' collection for each user
    final usersRef = FirebaseFirestore.instance.collection('users');
    final usersSnapshot = await usersRef.get();
    for (var userDoc in usersSnapshot.docs) {
      final uid = userDoc.id;
      final orderDoc = await usersRef.doc(uid).collection('orders').doc(orderId).get();
      if (orderDoc.exists) {
        await usersRef.doc(uid).collection('orders').doc(orderId).update({
          'acceptanceStatus': newStatus,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Orders View",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Disable the default back arrow
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            Container(
              width: 250,
              child: defaultDrawer(),
            ),
            SizedBox(width: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.black,
                    child: Card(
                      color: _orders[index].acceptanceStatus == 'Accepted'
                          ? Colors.green // If accepted, set color to green
                          : _orders[index].acceptanceStatus == 'Declined'
                          ? Colors.red // If declined, set color to red
                          : Colors.white, // Default color is white
                      child: Container(
                        color: Colors.black,
                        child: ListTile(
                          leading: Icon(Icons.receipt,
                          color: Colors.cyan,),
                          title: Text(_orders[index].orderId, style: TextStyle(color: Colors.white)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Date: ${DateFormat('yyyy-MM-dd (HH:mm)').format(_orders[index].orderDate)}',
                                style: TextStyle(color: Colors.white), // Set text color to white
                              ),
                              SizedBox(height: 8),
                              Text('User ID: ${_orders[index].userId}', style: TextStyle(color: Colors.white)),
                              Text('User Name: ${_orders[index].userName}', style: TextStyle(color: Colors.white)),
                              Text('User E-mail: ${_orders[index].userEmail}', style: TextStyle(color: Colors.white)),
                              Text('User Phone: ${_orders[index].phoneNumber}', style: TextStyle(color: Colors.white)),
                              Text('User Address: ${_orders[index].address}', style: TextStyle(color: Colors.white)),

                              SizedBox(height: 8),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Products:',
                                              style: TextStyle(color: Colors.white,
                                              fontWeight: FontWeight.bold)
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: _orders[index].products.length,
                                            itemBuilder: (context, productIndex) {
                                              final product = _orders[index].products[productIndex];
                                              return ListTile(
                                                title: Text(product['productName']
                                                    , style: TextStyle(color: Colors.white)),
                                                subtitle: Text(
                                                  'Quantity: ${product['quantity']} | Price: \$${product['price']}',
                                                     style: TextStyle(color: Colors.white)),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Total:',
                                            style: TextStyle(fontWeight: FontWeight.bold
                                            ,color: Colors.white),
                                          ),
                                          Text(
                                            '\$${_orders[index].total}',
                                            style: TextStyle(fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check_circle_outline),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    _updateAcceptanceStatus(_orders[index].orderId, 'Accepted');
                                    _orders[index].acceptanceStatus = 'Accepted';
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.cancel_outlined),
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    _updateAcceptanceStatus(_orders[index].orderId, 'Declined');
                                    _orders[index].acceptanceStatus = 'Declined';
                                  });
                                },
                              ),
                              SizedBox(width: 8),
                              if (_orders[index].acceptanceStatus == 'Accepted')
                                Container(
                                  decoration: BoxDecoration(
                                    color: _orders[index].status == 'Pending'
                                        ? Colors.blue[600] // If accepted, set color to green
                                        : _orders[index].status == 'Preparing'
                                        ? Colors.yellow[900]
                                        : _orders[index].status == 'Shipping'
                                        ? Colors.orange[900] // If accepted, set color to green
                                        : _orders[index].status == 'Delivered'
                                        ? Colors.green[800] // If declined, set color to red
                                        : Colors.white, // Def
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButton<String>(
                                    value: _orders[index].status,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _updateOrderState(_orders[index].orderId, newValue!);
                                        _orders[index].status = newValue;
                                      });
                                    },
                                    items: <String>['Pending', 'Preparing', 'Shipping', 'Delivered']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              SizedBox(height: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
