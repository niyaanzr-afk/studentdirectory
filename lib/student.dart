import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:studentdirectory/home.dart';

class Student extends StatelessWidget {
  const Student({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
    });
  
    return Scaffold(body: Center(child: Lottie.asset("assets/studentani.json"),));
  }
}