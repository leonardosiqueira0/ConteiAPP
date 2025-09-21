import 'package:contei_app/data/models/produto_model.dart';

class EtiquetaModel {
  final int etiquetaID;
  final ProdutoModel produto;
  final String lote;
  final int quantidadePallet;
  final String qrCode;
  final String tipoObjeto;
  final int numeroDocumento;
  final int sequencialEtiqueta;

  EtiquetaModel({
    required this.etiquetaID,
    required this.produto,
    required this.lote,
    required this.quantidadePallet,
    required this.qrCode,
    required this.tipoObjeto,
    required this.numeroDocumento,
    required this.sequencialEtiqueta,
  });

  factory EtiquetaModel.fromJson(Map<String, dynamic> json) {
    return EtiquetaModel(
      etiquetaID: json['etiquetaID'],
      produto: ProdutoModel.fromJson(json['produto']),
      lote: json['lote'],
      quantidadePallet: json['quantidadePallet'],
      qrCode: json['qrCode'],
      tipoObjeto: json['tipoObjeto'],
      numeroDocumento: json['numeroDocumento'],
      sequencialEtiqueta: json['sequencialEtiqueta'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['etiquetaID'] = etiquetaID;
    data['produto'] = produto.toJson();
    data['lote'] = lote;
    data['quantidadePallet'] = quantidadePallet;
    data['qrCode'] = qrCode;
    data['tipoObjeto'] = tipoObjeto;
    data['numeroDocumento'] = numeroDocumento;
    data['sequencialEtiqueta'] = sequencialEtiqueta;
    return data;
  }
}
