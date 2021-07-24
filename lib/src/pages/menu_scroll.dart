import 'dart:ui';
import 'package:integradora_oficial/src/models/temp_model.dart';
import 'package:integradora_oficial/src/providers/temp_provider.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class MenuScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: LiquidSwipe(
        pages: [
          _MenuTemp(),
          _BotonesNav(),
        ],
        fullTransitionValue: 500,
        enableSideReveal: false,
      ),
    );
  }
}

////////// EMPIEZA PRIMERA INTERFAZ MENU TEMP \\\\\\\\\\\\
class _MenuTemp extends StatelessWidget {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    final String formatted = formatter.format(now);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: [
              Text(
                'Temperatura',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formatted,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          _FondoMenu(),
          _TempActual(fechaActual: formatted),
        ],
      ),
    );
  }
}

////////// TERMINA PRIMERA INTERFAZ MENU TEMP \\\\\\\\\\\\\\\\\\\\\

////////// EMPIEZA SEGUNDA INTERFAZ BOTONES DE NAVEGACION \\\\\\\\\\\\
class _BotonesNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;

    return Container(
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
      child: Center(
        child: Container(
          width: _mediaSize.height * 0.25,
          height: _mediaSize.height * 1,
          child: Column(
            children: [
              Container(
                height: 200,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://scontent.fmxl1-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/218083271_403458621095955_6251887432281665556_n.png?_nc_cat=104&ccb=1-3&_nc_sid=ae9488&_nc_ohc=6zOl6ukmTJkAX-WKHLG&_nc_ht=scontent.fmxl1-1.fna&oh=afe46b9e8ec956f3c371ffbf39df90c7&oe=60FCEDAF'),
                  ),
                ),
              ),

              ///// BOTONES DE NAVEGACION //////
              _BtnRegTemp(),
              SizedBox(height: 20),
              _BtnGrafTemp(),
              ///// BOTONES DE NAVEGACION //////
            ],
          ),
        ),
      ),
    );
  }
}
////////// TERMINA SEGUNDA INTERFAZ BOTONES DE NAVEGACION \\\\\\\\\\\\

/// PRIMER BOTON \\\
class _BtnRegTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/RegTemp');
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Color.fromRGBO(252, 96, 100, 1.0),
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 34.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://scontent.fmxl1-1.fna.fbcdn.net/v/t1.15752-9/p1080x2048/217750793_512174956725523_1895438781630908219_n.png?_nc_cat=105&ccb=1-3&_nc_sid=ae9488&_nc_ohc=bJFGZFB3T6MAX_7OXR1&_nc_ht=scontent.fmxl1-1.fna&oh=1d653d26b477edc63a1c733508237b9d&oe=60FDCAA3'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Registro de Temperaturas',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// SEGUNDO BOTON \\\
class _BtnGrafTemp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/GrafTemp');
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Color.fromRGBO(252, 96, 100, 1.0),
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 34.0,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://scontent.fmxl1-1.fna.fbcdn.net/v/t1.15752-9/p1080x2048/217703423_1513223692363187_4316509888885426142_n.png?_nc_cat=101&ccb=1-3&_nc_sid=ae9488&_nc_ohc=mfWFsgZB2K0AX8B7Tgb&_nc_ht=scontent.fmxl1-1.fna&oh=7dd5bf1328974e7c109d0146e0b10a76&oe=60FE1834'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Grafica de Temperaturas',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TempActual extends StatelessWidget {
  final String ? fechaActual;
  final tempsProvider = TemperaturasProviders();
  _TempActual({this.fechaActual});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tempsProvider.obtenerTemperaturas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TemperaturasModel>> snap) {
        //temp
        if (snap.hasData) {
          final temps = snap.data;
          final tempActual = temps!.last.temperatura;
          final fechaTemps = temps.last.fecha!;
          return Center(
            child: _TempContenedor(
              tempActual: tempActual,
              fechaTemps: fechaTemps,
              fechaActual: fechaActual,
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

//fondo primer interfaz
class _FondoMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

//Container centro temp
class _TempContenedor extends StatelessWidget {
  final String ? fechaActual;
  final double? tempActual;
  final String? fechaTemps;
  _TempContenedor({this.tempActual, this.fechaTemps, this.fechaActual});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      width: 300.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Column(
        children: [
          if (tempActual! < 27 && fechaTemps == fechaActual)
            _TempOptima(temp: tempActual)
          else if (tempActual! > 27 && fechaTemps == fechaActual)
            _TempCritica(temp: tempActual)
          else if (fechaTemps != fechaActual)
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Text(
                'Compruebe el estado del sensor',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            )
        ],
      ),
    );
  }
}

class _TempOptima extends StatelessWidget {
  final double? temp;
  _TempOptima({this.temp});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100.0,
          width: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
            color: Colors.blue[800],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Image.asset(
                    'assets/colder.png',
                    height: 70.0,
                    color: Colors.blue,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "${temp.toString()} C°",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(60),
            ),
          ),
          child: Center(
              child: Image.asset(
            'assets/sol.png',
            height: 70.0,
            fit: BoxFit.cover,
          )),
        )
      ],
    );
  }
}

class _TempCritica extends StatelessWidget {
  final double? temp;
  _TempCritica({this.temp});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
            color: Colors.grey,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  Image.asset(
                    'assets/colder.png',
                    height: 70.0,
                    fit: BoxFit.cover,
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          height: 100.0,
          width: 200.0,
          decoration: BoxDecoration(
            color: Colors.red[800],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(60),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                "${temp.toString()} C°",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                width: 10.0,
              ),
              Center(
                child: Image.asset(
                  'assets/sol.png',
                  height: 70.0,
                  color: Colors.red,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
