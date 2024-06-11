

import 'package:flutter/material.dart';

import '../widgets/CustomCard.dart';
import '../widgets/CustomTable.dart';
import '../widgets/drawer.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text("User Management"
            ,
            style: TextStyle(
                color: Colors.white,

                fontSize: 25,
                fontWeight: FontWeight.bold
            ),),
        ),
        automaticallyImplyLeading: false, // Disable the default back arrow

      ),
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
                  child:defaultDrawer()
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CustomCard(
                              content: Column(
                                children: [
                                  CustomTable (),
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
