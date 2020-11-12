import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:i_moon/authentication_service.dart';
import 'package:i_moon/components/already_have_an_account_check.dart';
import 'package:i_moon/components/text_field_container.dart';
import 'package:i_moon/screens/dashboard/dashboard_screen.dart';
import 'package:i_moon/screens/register/register_screen.dart';
import 'package:i_moon/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_moon/screens/login/components/background.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldContainer(
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email, color: kPrimaryColor),
                      labelText: "Enter email address",
                      border: InputBorder.none),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    labelText: "Enter your password",
                    suffixIcon: Icon(
                      Icons.visibility_off,
                      color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: kPrimaryColor,
                    onPressed: () {
                      AuthenticationSevice()
                          .login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      )
                          .then((val) {
                        if (val.data["isAuth"]) {
                          Fluttertoast.showToast(
                            msg: "Authenticated",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return DashboardScreen();
                            }),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Either email or password is incorrect",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      });
                      // context.read<AuthenticationSevice>().login(
                      //   email: emailController.text.trim(),
                      //   password: passwordController.text.trim()
                      // );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
