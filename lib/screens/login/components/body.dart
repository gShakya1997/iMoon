import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_moon/components/already_have_an_account_check.dart';
import 'package:i_moon/components/rounded_button.dart';
import 'package:i_moon/components/rounded_input_field.dart';
import 'package:i_moon/components/rounded_password_field.dart';
import 'package:i_moon/constants.dart';
import 'package:i_moon/screens/login/components/background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
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
          RoundedInputField(
            hintText: "Your email address",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "Login",
            color: kPrimaryColor,
            press: () {},
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck( 
            press: () {},
          ),
        ],
      ),
    );
  }
}