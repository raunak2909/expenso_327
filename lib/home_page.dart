import 'package:expense_app_ui/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
                        "asset/image/logoremvoe.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.contain,
                      ),
            Image.asset("asset/image/boxjpg.png",width: 350,fit: BoxFit.contain,height: 400,),
            SizedBox(
              height: 20,
            ),
            Text("Easy way to monitor",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
            Text("Your expense",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 20,
            ),
            Text("Safe Your Future by managing Your",style: TextStyle(fontSize:18,color: Colors.grey),),
            Text("expense right now",style: TextStyle(fontSize: 18,color: Colors.grey),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondPage()));
      },child: Icon(Icons.east_rounded,color: Colors.white,),
      backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
