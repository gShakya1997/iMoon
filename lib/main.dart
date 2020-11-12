import 'package:flutter/material.dart';
import 'package:i_moon/constants.dart';
// import 'package:i_moon/screens/dashboard/dashboard_screen.dart';
import 'package:i_moon/screens/register/register_screen.dart';
import 'package:i_moon/screens/welcome/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   // providers: [
    //   //   Provider<AuthenticationSevice>(
    //   //     create: (_) => AuthenticationSevice(FirebaseAuth.instance),
    //   //   ),
    //   //   StreamProvider(create: (context) => context.read<AuthenticationSevice>().authStateChanges,
    //   //   ),
    //   // ],
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "iZoom",
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: WelcomeScreen(),
      );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = context.watch<User>();
//     if (firebaseUser != null){
//       return DashboardScreen();
//     }
//     return WelcomeScreen();
//   }
// }
