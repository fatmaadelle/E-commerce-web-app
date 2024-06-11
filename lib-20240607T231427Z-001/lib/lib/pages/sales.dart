import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/drawer.dart';

class SalesReportPage extends StatefulWidget {
  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  late List<LineSeries<SalesData, DateTime>> _seriesLineData;
  late List<PieSeries<SalesData, String>> _seriesPieData;

  @override
  void initState() {
    super.initState();
    _seriesLineData = [];
    _seriesPieData = [];
    _fetchSalesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            "Sales Report",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Disable the default back arrow
      ),
      body: Row(
        children: [
          Container(
            width: 250, // Adjust the width as needed
            child: defaultDrawer(), // Using defaultDrawer here
          ),
          SizedBox(width: 15,),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildLineChart(),
                  Column(

                    children: [
                      SizedBox(height: 20),
                    ],
                  ),
                  _buildPieChart(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      color: Colors.white,
      height: 300,
      padding: EdgeInsets.all(10),
      child: _seriesLineData.isNotEmpty
          ? SfCartesianChart(
        primaryXAxis: DateTimeAxis(),
        series: _seriesLineData,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(10),
      child: _seriesPieData.isNotEmpty
          ? SfCircularChart(
        series: _seriesPieData,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _fetchSalesData() async {
    QuerySnapshot ordersSnapshot =
    await FirebaseFirestore.instance.collection('orders').get();

    List<SalesData> salesData = [];
    Map<String, int> productCounts = {}; // To store the count of each product

    for (QueryDocumentSnapshot orderDoc in ordersSnapshot.docs) {
      double totalRevenue = 0;
      double totalProfit = 0;
      int totalOrders = 0;

      List<dynamic> products = orderDoc['products'];

      products.forEach((product) {
        double price = product['price'];
        int quantity = product['quantity'];
        totalRevenue += price * quantity;
        totalProfit += (price * quantity) * 0.1; // Assuming profit is 10% of revenue
        totalOrders += quantity;

        String productName = product['productName'];

        // Increment the count of the product
        productCounts[productName] = (productCounts[productName] ?? 0) + quantity;
      });

      salesData.add(SalesData(
        date: (orderDoc['orderDate'] as Timestamp).toDate(),
        revenue: totalRevenue,
        profit: totalProfit,
        orders: totalOrders,
      ));
    }

    // Find the most sold item
    String mostSoldItem = productCounts.entries.fold('', (prev, entry) {
      if (prev.isEmpty || entry.value > productCounts[prev]!) {
        return entry.key;
      } else {
        return prev;
      }
    });

    // Add the most sold item to the sales data list
    salesData.add(SalesData(
      date: DateTime.now(), // Use current date for simplicity
      revenue: 0, // Not applicable for the most sold item
      profit: 0, // Not applicable for the most sold item
      orders: productCounts[mostSoldItem] ?? 0,
      mostSoldItem: mostSoldItem,
    ));

    _createChartData(salesData);
  }

  void _createChartData(List<SalesData> salesData) {
    _createLineChart(salesData);
    _createPieChart(salesData);
    setState(() {});
  }

  void _createLineChart(List<SalesData> salesData) {
    _seriesLineData = [
      LineSeries<SalesData, DateTime>(
        dataSource: salesData,
        xValueMapper: (SalesData sales, _) => sales.date,
        yValueMapper: (SalesData sales, _) => sales.revenue,
        name: 'Revenue',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
      LineSeries<SalesData, DateTime>(
        dataSource: salesData,
        xValueMapper: (SalesData sales, _) => sales.date,
        yValueMapper: (SalesData sales, _) => sales.profit,
        name: 'Profit',
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
    ];
  }

  void _createPieChart(List<SalesData> salesData) {
    _seriesPieData = [
      PieSeries<SalesData, String>(
        dataSource: salesData,
        xValueMapper: (SalesData sales, _) => sales.mostSoldItem ?? 'Others',
        yValueMapper: (SalesData sales, _) => sales.orders.toDouble(),
        dataLabelMapper: (SalesData sales, _) {
          String label = sales.mostSoldItem ?? '';
          if (sales.mostSoldItem != null) {
            label += '\nOrders: ${sales.orders}';
          }
          return label;
        },
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
    ];
  }
}

class SalesData {
  final DateTime date;
  final double revenue;
  final double profit;
  final int orders;
  final String? mostSoldItem;

  SalesData({
    required this.date,
    required this.revenue,
    required this.profit,
    required this.orders,
    this.mostSoldItem,
  });
}
