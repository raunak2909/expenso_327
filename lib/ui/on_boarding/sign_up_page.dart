import 'package:expense_app_ui/data/local/db_helper.dart';
import 'package:expense_app_ui/data/local/model/user_model.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController newpassController = TextEditingController();

  TextEditingController confirmpassController = TextEditingController();

  DbHelper dbHelper = DbHelper.instance;

  bool isPassVisible = false;

  bool isConfirmPassVisible = false;

  // Create a function that returns InputDecoration
  InputDecoration decorationtext() {
    return InputDecoration(
      labelText: 'Username',
      // Label for the input field
      hintText: 'Enter your username',
      // Hint text inside the field
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
      filled: true,
      // Adds a fill color to the input field
      fillColor: Colors.white, // Color of the fill
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  obscureText: !isPassVisible,
                  obscuringCharacter: "*",
                  decoration: decorationtext().copyWith(
                    suffixIcon: InkWell(
                      onTap: (){
                        isPassVisible = !isPassVisible;
                        setState(() {});
                      },
                        child: Icon(isPassVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined)),
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
                  obscureText: !isConfirmPassVisible,
                  obscuringCharacter: "*",
                  decoration: decorationtext().copyWith(
                    suffixIcon: InkWell(
                      onTap: (){
                        isConfirmPassVisible = !isConfirmPassVisible;
                        setState(() {

                        });
                      },
                        child: Icon(isConfirmPassVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined)),
                    labelText: 'Confirm password',
                    hintText: 'Enter your Confirm password',
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  if (usernameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      mobileController.text.isNotEmpty &&
                      newpassController.text.isNotEmpty &&
                      confirmpassController.text.isNotEmpty) {
                    if (newpassController.text == confirmpassController.text) {

                      /// register user
                      if (await dbHelper.checkIfEmailAlreadyExists(
                          email: emailController.text.toString())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Email already exists, login now!!'), backgroundColor: Colors.orange));
                      } else {
                       bool check = await dbHelper.registerUser(
                            newUser: UserModel(username: usernameController.text,
                                email: emailController.text,
                                mobile: mobileController.text,
                                password: newpassController.text,
                                createAt: DateTime.now().millisecondsSinceEpoch.toString()));
                       if(check){
                         ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Account registered successfully!!'), backgroundColor: Colors.green));
                         Navigator.pop(context);
                       } else {
                         ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('Failed to register account, try again!!'), backgroundColor: Colors.red,));
                       }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords doesn\'t match!!'), backgroundColor: Colors.orange));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all the required blanks!!'), backgroundColor: Colors.orange));
                  }
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
                  Text("Already have an account ?",
                    style: TextStyle(fontSize: 16, color: Colors.blue),),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Expanded(
                      child: Text(
                        " Log in",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
