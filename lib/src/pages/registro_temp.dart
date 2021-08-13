import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:integradora_oficial/src/models/temp_model.dart';
import 'package:integradora_oficial/src/providers/temp_provider.dart';
import 'package:integradora_oficial/src/const/const.dart';

class RegTemp extends StatefulWidget {
  RegTempState createState() => RegTempState();
}

class RegTempState extends State {
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de Temperaturas'),
        backgroundColor: Color.fromRGBO(88, 170, 224, 1),
        elevation: 0,
      ),
      body: Stack(
        children: [
          _FondoColor(),
          _Logo(),
          _BarraBusquedaFecha(editingController: editingController),
          _Header(),
          _GetTempsFutureB(),
        ],
      ),
    );
    ;
  }
}

class _FondoColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(88, 170, 224, 1),
      ),
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

class _BarraBusquedaFecha extends StatelessWidget {
  final TextEditingController? editingController;
  _BarraBusquedaFecha({this.editingController});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100.0,
      child: Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0),
        width: 320.0,
        child: TextField(
          controller: editingController,
          decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          onChanged: (value) {},
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final TextStyle estilo =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Positioned(
      top: _mediaSize.height * 0.22,
      child: Container(
        margin: EdgeInsets.only(right: _mediaSize.width * 0.01, left: _mediaSize.width * 0.01),
        width: _mediaSize.width * 0.99,
        child: Card(
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: _mediaSize.width * 0.03,
              ),
              Text('Fecha', style: estilo),
              SizedBox(
                width: _mediaSize.width * 0.15,
              ),
              Text('Hora', style: estilo),
              SizedBox(
                width: _mediaSize.width * 0.13,
              ),
              Text('Temp', style: estilo),
              SizedBox(
                width: _mediaSize.width * 0.09,
              ),
              Text('Estado', style: estilo)
            ],
          ),
        ),
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

class _GetTempsFutureB extends StatelessWidget {
  final tempsProvider = TemperaturasProviders();
  final TextStyle estilo = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tempsProvider.obtenerTemperaturas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<TemperaturasModel>> snap) {
        if (snap.hasData) {
          final temps = snap.data;
          return Container(
            height: double.maxFinite,
            margin: EdgeInsets.only(top: 200.0),
            child: Card(
              child: ListView.builder(
                  itemCount: temps!.length,
                  itemBuilder: (BuildContext context, int i) {
                    //temps
                    final tempsData = temps[i];
                    return Column(
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
                            if (tempsData.temperatura! < TemperaturasValues.tempAlerta)
                              Text(
                                'ÓPTIMA',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )
                            else if (tempsData.temperatura! > TemperaturasValues.tempOptima &&
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
                    );
                  },
                ),
              ),
            );
        }
        return Center(child:CircularProgressIndicator(color: Colors.white,));
      },
    );
  }
}
