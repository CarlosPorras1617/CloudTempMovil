import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:integradora_oficial/src/models/temp_model.dart';
import 'package:integradora_oficial/src/providers/temp_provider.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';

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
              _TraeTempsCount()
            ],
          ),
        ),
      ),
    );
  }
}

//este metodo trae cuantas temperaturas hay de cada uno, para la grafica
class _TraeTempsCount extends StatelessWidget{
  final DateTime now = DateTime.now();
  //library instant
  final DateTime eastCoast = dateTimeToZone(zone: "PDT", datetime: DateTime.now());
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
      builder: (BuildContext context, AsyncSnapshot<List<TemperaturasModel>> snap){
        if (snap.hasData) {
          final temps = snap.data;
          for (var i = 0; i < temps!.length; i++) {
            if(temps[i].temperaturaMedia! != 0 && temps[i].fecha! == formatted){
              tempMedia++;
            }
            else if(temps[i].temperaturaAlta! != 0 && temps[i].fecha! == formatted){
              tempAlta++;
            }
            else if(temps[i].temperatura! < 27 && temps[i].fecha! == formatted){
              tempEstable++;
            }
          }
        }
        //AQUI POSIBLEMENTE VAYA EL WIDGET DE LA GRAFICA DONDE LE ENVIO ESTOS DATOS
        return Text(tempMedia.toString() + " " + tempAlta.toString() + " " + tempEstable.toString());
      },
    );
  }
}
