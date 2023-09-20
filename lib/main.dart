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
        apiKey: "AIzaSyDUGfrcTu4YMGL7LgGz_oSF82exGUXkHho",
        authDomain: "chat-tomorrow.firebaseapp.com",
        projectId: "chat-tomorrow",
        storageBucket: "chat-tomorrow.appspot.com",
        messagingSenderId: "981714825307",
        appId: "1:981714825307:web:8867d02a0048a656bf8f7e",
        measurementId: "G-T893R0XEV1",
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
