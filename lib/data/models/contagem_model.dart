class ContagemModel {
  final String id;
  final DateTime data;
  final String deposito;
  final String descricao;
  final String status;

  ContagemModel({
    required this.id,
    required this.data,
    required this.deposito,
    required this.descricao,
    required this.status,
  });

  factory ContagemModel.fromJson(Map<String, dynamic> json) {
    return ContagemModel(
      id: json['id'] as String,
      data: DateTime.parse(json['data'] as String),
      deposito: json['deposito'] as String,
      descricao: json['descricao'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data.toIso8601String(),
      'deposito': deposito,
      'descricao': descricao,
      'status': status,
    };
  }
}