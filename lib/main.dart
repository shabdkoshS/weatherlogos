import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_logo/module/auth/sign_in_screen.dart';
import 'package:weather_logo/module/user/admin/screensss/admin_dashboard_screen.dart';
import 'package:weather_logo/module/user/user_dashboard_screen.dart';
import 'package:weather_logo/shared/servies/auth_service.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
      home: FutureBuilder(
        future: AuthService().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              User user = snapshot.data as User;
              return FutureBuilder(
                future: AuthService().isAdmin(user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    return snapshot.data as bool
                        ? AdminDashboardScreen()
                        : UserDashboardScreen();
                  }
                },
              );
            } else {
              return SignInScreen();
            }
          }
        },
      ),
    );
  }
}
