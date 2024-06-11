import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../app/data/models/user_model.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  List<UserData> _userData = []; // List to store user data

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      List<UserData> users = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Check and convert birthday field to DateTime
        if (data['birthday'] is Timestamp) {
          data['birthday'] = (data['birthday'] as Timestamp).toDate();
        } else if (data['birthday'] is String) {
          data['birthday'] = DateTime.parse(data['birthday']);
        } else {
          data['birthday'] = DateTime.now(); // Default in case of unknown type
        }
        return UserData.fromJson(data);
      }).toList();
      setState(() {
        _userData = users;
      });
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle exceptions during fetching
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: Colors.black,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('First Name', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Last Name', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Phone Number', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Email', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Address', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Gender', style: TextStyle(color: Colors.white)),
                  ),
                  DataColumn(
                    label: Text('Birthday', style: TextStyle(color: Colors.white)),
                  ),
                ],
                rows: _buildRows(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildRows() {
    List<DataRow> rows = [];
    for (var data in _userData) {
      final index = _userData.indexOf(data);
      rows.add(DataRow(
        selected: selected[index],
        onSelectChanged: (bool? value) {
          setState(() {
            selected[index] = value!;
          });
        },
        cells: [
          _buildDataCell(data.firstName),
          _buildDataCell(data.lastName),
          _buildDataCell(data.phoneNumber),
          _buildDataCell(data.email),
          _buildDataCell(data.address),
          _buildDataCell(data.gender),
          _buildDataCell(data.getFormattedBirthday()),
        ],
      ));
    }
    return rows;
  }
  DataCell _buildDataCell(String text) {
    // Truncate text to 5 characters and add tree points if text is longer
    String truncatedText = text.length <= 5 ? text : '${text.substring(0, 6)}...';
    return DataCell(
      GestureDetector(
        onTap: () {
          _showFullDataDialog(text);
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            truncatedText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showFullDataDialog(String text) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('data'),
          content: Container(
            width: 200,
              height: 50,
              color:Colors.black,
              child: Center(
                child: Text(text,
                style: TextStyle(
                  color: Colors.white
                ),),
              )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


}
