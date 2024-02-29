import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:social_boster/firebase_options.dart';
import 'package:social_boster/providers/upload_progress_provider.dart';
import 'package:social_boster/providers/user_provider.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/bottom_nav_bar_screen.dart';
import 'package:social_boster/screens/onbaording_screens/onboarding_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = "pk_test_51Nn6HPGNqLxAA3gqVQiEmwX7HsD3iFVnhtLsGXk1xZwYKi8ZmBYVWmw5faPxkeyZD7ikEqqgT0suI20G3tqWdfZ200dYy2eO5o";

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "assets/stripe/.env");
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider()),
        ChangeNotifierProvider(create: (_)=>UploadProgressProvider())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //   colorScheme: ColorScheme.dark(background: blackColor),
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser!=null?
          BottomNavBarScreen()
          :const OnBoardingScreen(),
    );
  }
}
