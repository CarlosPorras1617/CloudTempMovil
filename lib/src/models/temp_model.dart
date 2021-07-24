class TemperaturasModel{
  String ? id;
  String ? fecha;
  String ? hora;
  double ? temperatura;
  double ? temperaturaMedia;
  double ? temperaturaAlta;

  TemperaturasModel({
    this.id,
    this.fecha,
    this.hora,
    this.temperatura,
    this.temperaturaMedia,
    this.temperaturaAlta
  });

  factory TemperaturasModel.fromMapJson(Map<String,dynamic> data)=>TemperaturasModel(
    id: data['_id'],
    fecha: data['fecha'],
    hora: data['hora'],
    temperatura: data['temperatura'] / 1,
    temperaturaMedia: data['temperaturamedia'] / 1,
    temperaturaAlta: data['temperaturalta'] / 1
  );
}