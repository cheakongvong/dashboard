import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'screens/chatscreen.dart';
import 'screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD5Af7i1JRyCZpDZA7fwK9xvA08IFoeE6o",
        authDomain: "dashboard-tomorrow.firebaseapp.com",
        projectId: "dashboard-tomorrow",
        storageBucket: "dashboard-tomorrow.appspot.com",
        messagingSenderId: "68018638864",
        appId: "1:68018638864:web:ee812f8bc797e66ffd7a95",
        measurementId: "G-F06L1GJ3SX",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggedIn = FirebaseAuth.instance.currentUser == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoggedIn
          ? Login(
              getProfileCallback: () {
                debugPrint("Logged In");
                Navigator.pop(context);
                setState(() {
                  _isLoggedIn = !_isLoggedIn;
                });
              },
            )
          : ChatScreen(
              isLoggedInCallback: () {
                setState(() {
                  _isLoggedIn = !_isLoggedIn;
                });
              },
            ),
    );
  }
}
