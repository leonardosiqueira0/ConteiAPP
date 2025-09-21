class RespostaModel {
  final bool status;
  final String mensagem;
  final List<dynamic>? data;

  RespostaModel({required this.status, required this.mensagem, this.data});

  factory RespostaModel.fromJson(Map<String, dynamic> json) {
    return RespostaModel(
      status: json['status'],
      mensagem: json['mensagem'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'mensagem': mensagem,
      'data': data,
    };
  }
}