import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_moon/components/rounded_button.dart';
import 'package:i_moon/constants.dart';
import 'package:i_moon/screens/login/login_screen.dart';
import 'package:i_moon/screens/register/register_screen.dart';
import 'package:i_moon/screens/welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //This size provide us total height and width of the screen
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Welcome to iMoon",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/chat.svg",
            height: size.height * 0.5,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
            text: "Login",
            color: kPrimaryColor,
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
          RoundedButton(
            text: "Register",
            color: kPrimaryLightColor,
            textColor: Colors.black,
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
    ));
  }
}
