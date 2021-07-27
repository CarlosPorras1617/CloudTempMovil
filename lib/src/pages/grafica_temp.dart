import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:integradora_oficial/src/models/temp_model.dart';
import 'package:integradora_oficial/src/providers/indicator_provider.dart';
import 'package:integradora_oficial/src/providers/temp_provider.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
//grafica
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';

class GrafTemp extends StatefulWidget {
  @override
  _GrafTempState createState() => _GrafTempState();
}

class _GrafTempState extends State {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(88, 170, 224, 1),
        elevation: 0,
      ),
      body: Stack(
        children: [
          _FondoPantalla(),
          _Logo(),
          //AQUI EMPIEZA LA GRAFICAAAAA-------------------------
          AspectRatio(
            aspectRatio: 1.3,
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
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              final desiredTouch = pieTouchResponse.touchInput
                                      is! PointerExitEvent &&
                                  pieTouchResponse.touchInput
                                      is! PointerUpEvent;
                              if (desiredTouch &&
                                  pieTouchResponse.touchedSection != null) {
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              } else {
                                touchedIndex = -1;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40.0,
                          sections: showingSections(20, 50, 30),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Indicator(
                        color: Color(0xff0293ee),
                        text: 'First',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xfff8b250),
                        text: 'Second',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Color(0xff845bef),
                        text: 'Third',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                  SizedBox(width: 28),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

//function pie chart ------------------------
List<PieChartSectionData> showingSections(double tempEstable, double tempMedia, double tempAlta) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: tempEstable,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: tempMedia,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: tempAlta,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

}




//este metodo trae cuantas temperaturas hay de cada uno, para la grafica
class _TraeTempsCount extends StatelessWidget {
  final DateTime now = DateTime.now();
  //library instant
  final DateTime eastCoast =
      dateTimeToZone(zone: "PDT", datetime: DateTime.now());
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final tempsProvider = TemperaturasProviders();
  var tempMedia = 0;
  var tempAlta = 0;
  var tempEstable = 0;
  @override
  Widget build(BuildContext context) {
    final String formatted = formatter.format(eastCoast);
    return FutureBuilder(
      future: tempsProvider.obtenerTemperaturas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TemperaturasModel>> snap) {
        if (snap.hasData) {
          final temps = snap.data;
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
        //AQUI POSIBLEMENTE VAYA EL WIDGET DE LA GRAFICA DONDE LE ENVIO ESTOS DATOS
        return Text(tempMedia.toString() +
            " " +
            tempAlta.toString() +
            " " +
            tempEstable.toString());
      },
    );
  }
}

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
