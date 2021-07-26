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
        color: Color.fromRGBO(88, 170, 224, 1)
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
                    image: AssetImage('assets/cloudtemp.png'),
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
                      backgroundImage: AssetImage('assets/sol.png'),
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
                      backgroundImage: AssetImage('assets/sol.png'),
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
  final String? fechaActual;
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
        color: Color.fromRGBO(88, 170, 224, 1)
      ),
    );
  }
}

//Container centro temp
class _TempContenedor extends StatelessWidget {
  final String? fechaActual;
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
            ),
          SizedBox(height: 30.0),
          _StatusTemperatura(
            temperatura: tempActual,
            fechaActual: fechaActual,
            fechaTemps: fechaTemps,
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

class _StatusTemperatura extends StatelessWidget {
  final double? temperatura;
  final String? fechaActual;
  final String? fechaTemps;
  _StatusTemperatura({this.temperatura, this.fechaActual, this.fechaTemps});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (temperatura! < 27 && fechaTemps == fechaActual)
          Column(
            children: [
              Row(
                children: [
                  CirculosStatus(color: Colors.green[600]),
                  CirculosStatus(),
                  CirculosStatus(),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                width: 250.0,
                child: Text(
                  'Temperatura Óptima',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              )
            ],
          )
        else if (temperatura! > 27 &&
            temperatura! < 28 &&
            fechaTemps == fechaActual)
          Column(
            children: [
              Row(
                children: [
                  CirculosStatus(),
                  CirculosStatus(color: Colors.yellow),
                  CirculosStatus(),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                width: 250.0,
                child: Text(
                  'Temperatura en Alerta',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              )
            ],
          )
        else if (temperatura! > 28 && fechaTemps == fechaActual)
          Column(
            children: [
              Row(
                children: [
                  CirculosStatus(),
                  CirculosStatus(),
                  CirculosStatus(color: Colors.red),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                width: 250.0,
                child: Text(
                  'Temperatura Crítica',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
              )
            ],
          )
      ],
    );
  }
}

class CirculosStatus extends StatelessWidget {
  final Color? color;
  CirculosStatus({this.color});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5.0, right: 5.0),
          height: 90.0,
          width: 90.0,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(100.0)),
        ),
        Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(100.0)),
        ),
      ],
    );
  }
}
