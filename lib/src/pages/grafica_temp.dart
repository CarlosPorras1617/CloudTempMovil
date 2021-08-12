import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:integradora_oficial/src/models/temp_model.dart';
import 'package:integradora_oficial/src/providers/indicator_provider.dart';
import 'package:integradora_oficial/src/providers/temp_provider.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:integradora_oficial/src/const/const.dart';
//grafica
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';

class GrafTemp extends StatefulWidget {
  @override
  _GrafTempState createState() => _GrafTempState();
}

class _GrafTempState extends State {
  //variables
  final DateTime now = DateTime.now();
  //library instant
  final DateTime eastCoast =
      dateTimeToZone(zone: "PDT", datetime: DateTime.now());
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final tempsProvider = TemperaturasProviders();
  int tempMedia = 0;
  int tempAlta = 0;
  int tempEstable = 0;
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final String formatted = formatter.format(eastCoast);
    final _mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfica de temperaturas'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(88, 170, 224, 1),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          _FondoPantalla(),
          _Logo(),
          Positioned(
            top: 100.0,
            right: 50.0,
            child: _HeaderText(
              text: "Temperaturas del dia de hoy",
            ),
          ),

          //OBTENER CUANTAS TEMPS DE CADA UNO HAY --------------------------------------------------------
          FutureBuilder(
            future: tempsProvider.obtenerTemperaturas(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TemperaturasModel>> snap) {
              if (snap.hasData) {
                final temps = snap.data;
                //ciclamos para obtener cada una de las temperaturas registradas y la cantidad en base a la fecha de hoy
                for (var i = 0; i < temps!.length; i++) {
                  if (temps[i].temperaturaMedia! != 0 &&
                      temps[i].fecha! == formatted) {
                    tempMedia++;
                  } else if (temps[i].temperaturaAlta! != 0 &&
                      temps[i].fecha! == formatted) {
                    tempAlta++;
                  } else if (temps[i].temperatura! < 27 &&
                      temps[i].fecha! == formatted) {
                    tempEstable++;
                  }
                }
              }

              //AQUI EMPIEZA LA GRAFICA --------------------------------------------------------
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 130.0),
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: Card(
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(height: 18.0),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                        touchCallback: (pieTouchResponse) {
                                      //para que no se sumen las temps al tocar un cuadro
                                      //setState(() {
                                      final desiredTouch =
                                          pieTouchResponse.touchInput
                                                  is! PointerExitEvent &&
                                              pieTouchResponse.touchInput
                                                  is! PointerUpEvent;
                                      if (desiredTouch &&
                                          pieTouchResponse.touchedSection !=
                                              null) {
                                        touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      } else {
                                        touchedIndex = -1;
                                      }
                                      // });
                                    }),
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40.0,
                                    sections: showingSections(
                                        tempEstable, tempMedia, tempAlta),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Indicator(
                                    color: Colors.green,
                                    text: 'Temps estables',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xfff8b250),
                                    text: 'Temps en Alerta',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Colors.red,
                                    text: 'Temps Críticas',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 28),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _HeaderText(
                    text: "Temperaturas en desequlibrio",
                  ),
                  _GetTempsAlertAndDanger(fechaActual: formatted),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  //Function chart --------------------------------------------------------------------------
  List<PieChartSectionData> showingSections(
      int tempEstable, int tempMedia, int tempAlta) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green[400],
            value: tempEstable.toDouble(),
            title: '${tempEstable.toString()}  R',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: tempMedia.toDouble(),
            title: '${tempMedia.toString()}  R',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red[400],
            value: tempAlta.toDouble(),
            title: '${tempAlta.toString()}  R',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}

//fondo color azul
class _FondoPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Color.fromRGBO(88, 170, 224, 1)),
    );
  }
}

//logo cloudTemp
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/cloudtemp.png'),
        ),
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String? text;
  _HeaderText({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: Text(
        text!,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class _DividerVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 20,
      color: Colors.grey[300],
    );
  }
}

class _GetTempsAlertAndDanger extends StatelessWidget {
  final String ? fechaActual;
  final tempsProvider = TemperaturasProviders();
  final TextStyle estilo = TextStyle(fontSize: 18);
  _GetTempsAlertAndDanger({required this.fechaActual});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tempsProvider.obtenerTemperaturas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TemperaturasModel>> snap) {
        if (snap.hasData) {
          final temps = snap.data;
          return Container(
            height: 270.0,
            margin: EdgeInsets.only(top: 10.0),
            child: Card(
              child: ListView.builder(
                itemCount: temps!.length,
                itemBuilder: (BuildContext context, int i) {
                  //temps
                  final tempsData = temps[i];
                  return (tempsData.fecha! == fechaActual && tempsData.temperatura! > TemperaturasValues.tempOptima) ? Column(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            tempsData.fecha!,
                            style: estilo,
                          ),
                          _DividerVertical(),
                          Text(
                            tempsData.hora!,
                            style: estilo,
                          ),
                          _DividerVertical(),
                          Text(
                            "${tempsData.temperatura!.toString()} C°",
                            style: estilo,
                          ),
                          _DividerVertical(),
                          if (tempsData.temperatura! >= TemperaturasValues.tempAlerta &&
                              tempsData.temperatura! <= TemperaturasValues.tempCritica)
                            Text(
                              'ALERTA',
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          else if (tempsData.temperatura! > TemperaturasValues.tempCritica)
                            Text(
                              'CRÍTICO',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                        ],
                      ),
                    ],
                  ): Container();
                },
              ),
            ),
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Center(child: CircularProgressIndicator(color: Colors.white,)),
        );
      },
    );
  }
}
