import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/app/user/modules/orders/controllers/orders_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/no_data.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Orders', style: TextStyle(color: Colors.white))),
        leading: IconButton(
          onPressed: () {
            Get.offNamed(Routes.HOME);
          },
          icon: FaIcon(FontAwesomeIcons.arrowLeft, size: 25, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 100,
      ),
      floatingActionButton:  Container(
        width: MediaQuery.sizeOf(context).width*0.25,
        child: FloatingActionButton(
          onPressed: (){Get.offNamed(Routes.HOME);},backgroundColor: Color(0xFF40DF9F),
          child: Text("add order"),
        ),
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: controller.getOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.blue[900]));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return ListView(children: [NoData(text: 'No Orders Found'),


            ],
            );
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final documentSnapshot = orders[index];
              final orderData = documentSnapshot.data() as Map<String, dynamic>;
              final totalPrice = orderData['total'];
              final orderStatus = orderData["orderStatus"];
              final List<dynamic> products = orderData['products'];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 100,
                  child: InkWell(
                    onTap: () {
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start  ,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(Icons.receipt, color: Colors.blue[900],
                                  size: 50,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Order ${documentSnapshot.id.substring(0, 8)}...', // Use substring to limit to 8 letters
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 12.sp),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              decoration:BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 2,
                                    color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.6),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text('Are you sure you want to cancel this order?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Perform cancel action
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                            child: Text('Cancel'), // Button for Cancel
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              controller.deleteOrder(documentSnapshot.id);
                                              controller.deleteOrderAdmin(documentSnapshot.id);
                                              Navigator.of(context).pop(); // Close the dialog
                                            },
                                            child: Text('OK'), // Button for OK
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  'Cancel Order',
                                  style: TextStyle(
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                            )
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, productIndex) {
                            final product = products[productIndex] as Map<String, dynamic>;
                            final productName = product['productName'] ?? 'Unknown Product';
                            final productPrice = product['price'];
                            final productQuantity = product['quantity'];
                            final productId = product['productId'];
                            return FutureBuilder<String?>(
                              future: controller.getProductImageURL(productId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator(color: Colors.blue[900],);
                                } else if (snapshot.hasError) {
                                  return Text('Error loading image');
                                } else if (snapshot.hasData && snapshot.data != null) {
                                  return ListTile(
                                    leading: Container(
                                      width: 100,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                        color: Colors.black
                                        ),
                                      ),
                                      child: Image.network(
                                        snapshot.data!,
                                        width: 100,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      productName,
                                      style: TextStyle(color: Colors.grey[700]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Quantity: $productQuantity", style: TextStyle(color: Colors.black)),
                                        Text("\$${productPrice?.toStringAsFixed(2) ?? '0.00'}", style: TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListTile(
                                    title: Text(
                                      productName,
                                      style: TextStyle(color: Colors.grey[700]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Quantity: $productQuantity", style: TextStyle(color: Colors.black)),
                                        Text("\$${productPrice?.toStringAsFixed(2) ?? '0.00'}", style: TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        Divider(color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Total: \$${totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Order Status:"),
                                    Text(
                                      " $orderStatus",
                                      style: TextStyle(
                                        color: orderStatus == 'Pending'
                                            ? Colors.blue[700]
                                            : orderStatus == 'Preparing'
                                            ? Colors.yellow[700]
                                            : orderStatus == 'Shipping'
                                            ? Colors.orange[900]
                                            : orderStatus == 'Delivered'
                                            ? Colors.green[700]
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}