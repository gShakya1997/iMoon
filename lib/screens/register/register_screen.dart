import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_moon/authentication_service.dart';
// import 'package:i_moon/authentication_service.dart';
import 'package:i_moon/components/already_have_an_account_check.dart';
import 'package:i_moon/components/text_field_container.dart';
import 'package:i_moon/screens/login/login_screen.dart';
import 'package:i_moon/screens/register/components/background.dart';
// import 'package:i_moon/screens/welcome/welcome_screen.dart';

import '../../constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              TextFieldContainer(
                child: TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person, color: kPrimaryColor),
                      labelText: "Enter your first name",
                      border: InputBorder.none),
                ),
              ),
              TextFieldContainer(
                child: TextField(
                  controller: lastnameController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person, color: kPrimaryColor),
                      labelText: "Enter your last name",
                      border: InputBorder.none),
                ),
              ),
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
              TextFieldContainer(
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    labelText: "Confirm password",
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
                      AuthenticationSevice().register(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        confirmPasswordController.text.trim(),
                        firstnameController.text.trim(),
                        lastnameController.text.trim()
                      );
                      // context.read<AuthenticationSevice>().register(
                      //     email: emailController.text.trim(),
                      //     password: passwordController.text.trim());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return WelcomeScreen();
                      //     },
                      //   ),
                      // );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.03)
            ],
          ),
        ),
      ),
    );
  }
}
