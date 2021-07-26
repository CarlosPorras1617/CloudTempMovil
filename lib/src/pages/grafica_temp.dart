import 'dart:ui';
import 'package:flutter/material.dart';

class GrafTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(88, 170, 224, 1),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(88, 170, 224, 1)
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
                    image: AssetImage('assets/cloudtemp.png'),
                  ),
                ),
              ),
              Text('Esta es la interfaz de Grafica de Temperaturas')
            ],
          ),
        ),
      ),
    );
  }
}
