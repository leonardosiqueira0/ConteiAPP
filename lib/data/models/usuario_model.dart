class UsuarioModel {
  String id;
  String name;
  String usuario;
  String senha;
  int departamentoID;
  String sapID;
  String label;

  UsuarioModel({required this.id, required this.name, required this.usuario, required this.senha, required this.departamentoID, required this.sapID, required this.label});

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      name: json['nome'],
      usuario: json['usuario'],
      senha: json['senha'],
      departamentoID: json['departamentoID'],
      sapID: json['sapID'],
      label: json['label']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = name;
    data['usuario'] = usuario;
    data['senha'] = senha;
    data['departamentoID'] = departamentoID;
    data['sapID'] = sapID;
    data['label'] = label;
    return data;
  }
}
