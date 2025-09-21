class ProdutoModel {
  final String? codigo;
  final String? descricao;
  final String? codigoBarras;
  final int quantidadeUnidadeVenda;
  final String? unidadeVenda;
  final int quantidadeUnidadeCompra;
  final int quantidadePorItem;
  final String? unidadeEstoque;
  final int? quantidadePallet;

  ProdutoModel({
    required this.codigo,
    required this.descricao,
    required this.codigoBarras,
    required this.quantidadeUnidadeVenda,
    required this.unidadeVenda,
    required this.quantidadeUnidadeCompra,
    required this.quantidadePorItem,
    required this.unidadeEstoque,
    required this.quantidadePallet,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      codigo: json['codigo'],
      descricao: json['descricao'],
      codigoBarras: json['codigoBarras'],
      quantidadeUnidadeVenda: json['quanidadeUnidadeVenda'],
      unidadeVenda: json['unidadeVenda'],
      quantidadeUnidadeCompra: json['quantidadeUnidadeCompra'],
      quantidadePorItem: json['quantidadePorItem'],
      unidadeEstoque: json['unidadeEstoque'],
      quantidadePallet: json['quantidadePallet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'codigoBarras': codigoBarras,
      'quanidadeUnidadeVenda': quantidadeUnidadeVenda,
      'unidadeVenda': unidadeVenda,
      'quantidadeUnidadeCompra': quantidadeUnidadeCompra,
      'quantidadePorItem': quantidadePorItem,
      'unidadeEstoque': unidadeEstoque,
      'quantidadePallet': quantidadePallet,
    };
  }
}