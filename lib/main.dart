import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/Notes_page.dart';
import 'package:notes/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();


  if(kIsWeb){
   await Firebase.initializeApp(
  options: const FirebaseOptions( apiKey: "AIzaSyAJK9D3piC9adk1d10UhNoClrD5Bxzj72g",
  authDomain: "notes-6d078.firebaseapp.com",
  projectId: "notes-6d078",
  storageBucket: "notes-6d078.appspot.com",
  messagingSenderId: "562462299565",
  appId: "1:562462299565:web:85d0b12d8cb0c3a251fd24"
  )
  );
  }else{
    await Firebase.initializeApp();
  }
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>ThemeDataProvider())
      ],
      child: const MyApp(),
      )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:Provider.of<ThemeDataProvider>(context).themeData,
      home: const HomePages(),
    );
  }
}