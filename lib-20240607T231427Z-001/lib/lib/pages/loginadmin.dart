import 'package:animate_do/animate_do.dart';
import 'package:ecommerce_app/lib/pages/dashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}
class _AdminLoginState extends State<AdminLogin> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user!= null) {
        // Check if the email is "s@admin.com" and the password is "123456"
        if (user.email == 's@admin.com' && password == '123456') {
          return 'Login successful';
        } else {
          return 'Invalid admin credentials';
        }
      } else {
        return 'Login failed';
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-1.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-2.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeInUp(duration: Duration(milliseconds: 1300), child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                        ),
                      )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251,.2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              )
                            ]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(color: Colors.grey[700])
                                ),
                                controller: _emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _email = value!,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle
                                      (color: Colors.grey[700])
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _password = value!,
                              ),
                            )
                          ],
                        ),
                      )),
                      SizedBox(height: 30,),
                      TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Use the text from the controllers for the email and password.
                              login(_emailController.text, _passwordController.text);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  const DashBoard())
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Processing Data')));
                            }
                          },
                        child: FadeInUp(duration: Duration(milliseconds: 1900),
                            child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )),

                      SizedBox(height: 70,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}