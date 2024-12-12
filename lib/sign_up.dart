import 'package:expense_app_ui/login_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController newpassController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  // Create a function that returns InputDecoration
  InputDecoration decorationtext() {
    return InputDecoration(
      labelText: 'Username', // Label for the input field
      hintText: 'Enter your username', // Hint text inside the field
      border: OutlineInputBorder(
        // Border around the input field
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        // Border when not focused
        borderSide: BorderSide(color: Colors.purple, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        // Border when focused
        borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true, // Adds a fill color to the input field
      fillColor: Colors.white, // Color of the fill
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "asset/image/loginlogo.png",
                fit: BoxFit.contain,
                height: 100,
                width: 100,
                color: Color(0xFF727dd6),
              ),
            ),
            Divider(),
            Text(
              "Create your new Account here",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff3545dc),
              ),
            ),

            // username
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: usernameController,
                decoration: decorationtext(), // Using the function here
              ),
            ),

            // e-mail
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                decoration: decorationtext().copyWith(
                  labelText: 'Enter your e-mail',
                  hintText: 'Enter your e-mail here',
                ),
              ),
            ),

            // mobile no
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: mobileController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: decorationtext().copyWith(
                  labelText: 'Enter Your mobile no',
                  hintText: 'Enter your mobile no here',
                ),
              ),
            ),

            // password
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: newpassController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: decorationtext().copyWith(
                  labelText: 'Password',
                  hintText: 'Enter your new password',
                ),
              ),
            ),

            // confirm password
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: confirmpassController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: decorationtext().copyWith(
                  labelText: 'Confirm password',
                  hintText: 'Enter your Confirm password',
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
              },
              child: Text(
                "Sign in",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFF727dd6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("are you have an account ?",style: TextStyle(fontSize: 16,color: Colors.blue),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                  child: Expanded(
                    child: Text(
                      "Log in",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFF727dd6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
