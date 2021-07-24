import 'package:get/get.dart';
import 'package:integradora_oficial/src/models/temp_model.dart';
import 'package:integradora_oficial/src/providers/temp_provider.dart';


class TemperaturasState extends GetxController{
  List<TemperaturasModel> temperaturas = [];
  final _temperaturasProvider = TemperaturasProviders();
  Future<void> obtenerTemperaturas()async{
    final temps = await _temperaturasProvider.obtenerTemperaturas();
    temperaturas.addAll(temps);
    update();
  }
}