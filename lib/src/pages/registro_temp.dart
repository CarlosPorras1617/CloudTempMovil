import 'dart:ui';
import 'package:flutter/material.dart';

class RegTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(131, 175, 235, 1),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(131, 175, 235, 1),
              Color.fromRGBO(153, 153, 153, 1)
            ],
          ),
        ),
        child: Container(
          width: _mediaSize.height * 0.25,
          height: _mediaSize.height * 1,
          child: Column(
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: NetworkImage(
                        'https://scontent.fmxl1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/218083271_403458621095955_6251887432281665556_n.png?_nc_cat=104&ccb=1-3&_nc_sid=ae9488&_nc_ohc=6zOl6ukmTJkAX-WKHLG&_nc_ht=scontent.fmxl1-1.fna&oh=afe46b9e8ec956f3c371ffbf39df90c7&oe=60FCEDAF'),
                  ),
                ),
              ),
              Text('Esta es la interfaz de Registro de Temperaturas')
            ],
          ),
        ),
      ),
    );
  }
}