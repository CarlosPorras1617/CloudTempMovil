import 'package:dio/dio.dart';
import 'package:integradora_oficial/src/models/temp_model.dart';


class TemperaturasProviders{
  final String url = 'https://integradora-app.herokuapp.com/api/18b20';
  final http = Dio();
  var temperaturas = [];

  Future<List<TemperaturasModel>> obtenerTemperaturas()async{
    final response = await http.get(url);
    List<dynamic> responseData = response.data;
    //trae la ultima temperatura registrada
    //print(responseData.last['temperatura']);
    return responseData.map((data)=> TemperaturasModel.fromMapJson(data)).toList();
  }
}