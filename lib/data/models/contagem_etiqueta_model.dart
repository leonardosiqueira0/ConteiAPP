import 'package:contei_app/data/models/etiqueta_model.dart';

class ContagemEtiquetaModel {
  final String id;
  final String contagemID;
  final int etiquetaID;
  final EtiquetaModel? etiqueta;
  final String usuarioID;
  final DateTime data;
  final int quantidade;
  final bool status;

  ContagemEtiquetaModel({
    required this.id,
    required this.contagemID,
    required this.etiquetaID,
    this.etiqueta,
    required this.usuarioID,
    required this.data,
    required this.quantidade,
    required this.status,
  });

  factory ContagemEtiquetaModel.fromJson(Map<String, dynamic> json) {
    return ContagemEtiquetaModel(
      id: json['id'] as String,
      contagemID: json['contagemID'] as String,
      etiquetaID: json['etiqueta']['etiquetaID'] as int,
      etiqueta: json['etiqueta'] != null ? EtiquetaModel.fromJson(json['etiqueta']) : null,
      usuarioID: json['usuarioID'] as String,
      data: DateTime.parse(json['data'] as String),
      quantidade: json['quantidade'] as int,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contagemID': contagemID,
      'etiquetaID': etiquetaID,
      'usuarioID': usuarioID,
      'data': data.toIso8601String(),
      'quantidade': quantidade,
      'status': status,
    };
  }
}