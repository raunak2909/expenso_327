import 'package:expense_app_ui/third_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // search icon and logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "asset/image/logoremvoe.png",
                  fit: BoxFit.contain,
                  width: 120,
                ),
                Icon(
                  Icons.search,
                  size: 40,
                )
              ],
            ),

            SizedBox(
              height: 20,
            ),

            // user profile
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // profile picture
                Image.asset(
                  "asset/image/profileicon.jpg",
                  height: 45,
                  width: 45,
                  fit: BoxFit.contain,
                ),

                // name of user
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Morning",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "chanderakinjal",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                //button
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        "This Month",
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.black,
                      )
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFFe0e0e0),
                    side: BorderSide.none,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            ///Purple Container
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF727dd6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // Text
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expense total",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "\$3,734",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),

                        /// red button
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              child: Text("+\$240",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: Size(45, 25),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            Text(
                              "than last month",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  ///side Image
                  Expanded(
                    child: Image.asset(
                      "asset/image/containersideimg.png",
                      height: 160,
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),

            ///Expense List
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Expense List",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                )),
            SizedBox(
              height: 20,
            ),
            ///shop, Elecronic container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Colors.grey, width: 0.5), // Set the border color and width
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tuesday, 14",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        Text("-\$1380",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Divider(),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Color(0xFFe0e0e0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                "asset/image/shpotroll-removebg-preview.png",
                                fit: BoxFit.contain,
                                height: 30,
                                width: 30,
                                color: Color(0xFF727dd6),
                              ),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shop",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text("Buy new Clothes")
                          ],
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Text(
                          "-\$90",
                          style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                // color: Color(0xFFe0e0e0),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Image.asset(
                                "asset/image/mobile-removebg-preview.png",
                                fit: BoxFit.contain,
                                height: 40,
                                width: 40,
                              ),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Electronic",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text("Buy new iphone 14")
                          ],
                        ),
                        SizedBox(
                          width: 85,
                        ),
                        Text(
                          "-\$1290",
                          style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            // transportation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Colors.grey, width: 0.5), // Set the border color and width
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Monday, 14",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        Text("-\$60 ",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Divider(),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.asset(
                                "asset/image/transportation-removebg-preview.png",
                                fit: BoxFit.contain,
                                height: 40,
                                width: 40,
                                color: Colors.orangeAccent,
                              ),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Transportation",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text("Trip to Malang")
                          ],
                        ),
                        SizedBox(
                          width: 110,
                        ),
                        Text(
                          "-\$60",
                          style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirdPage()));
      },child: Icon(Icons.add),),
    );
  }
}
