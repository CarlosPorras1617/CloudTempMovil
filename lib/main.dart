import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:integradora_oficial/src/pages/grafica_temp.dart';
import 'package:integradora_oficial/src/pages/menu_scroll.dart';
import 'package:integradora_oficial/src/pages/registro_temp.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Integradora App',
      initialRoute: '/',
      routes:{
        '/':(_)=>MenuScroll(),
        '/GrafTemp':(_)=>GrafTemp(),
        '/RegTemp':(_)=>RegTemp(),
      }
    );
  }
}