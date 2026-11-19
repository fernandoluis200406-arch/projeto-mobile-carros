
class Carro {
  final int id;
  final String nome;
  final double preco;
  final String imagem;
  final String descricao;
  final List<String> especificacoes;

  Carro({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagem,
    required this.descricao,
    required this.especificacoes,
  });

  factory Carro.fromJson(Map<String, dynamic> json) {
    return Carro(
      id: json['id'],
      nome: json['nome'],
      preco: (json['preco'] as num).toDouble(),
      imagem: json['imagem'],
      descricao: json['descricao'],
      especificacoes:
      List<String>.from(json['especificacoes']),
    );
  }

  String get precoFormatado {
    final valor = preco.toStringAsFixed(2);
    final partes = valor.split('.');

    final inteiro = partes[0];
    final buffer = StringBuffer();

    for (int i = 0; i < inteiro.length; i++) {
      if (i > 0 && (inteiro.length - i) % 3 == 0) {
        buffer.write('.');
      }

      buffer.write(inteiro[i]);
    }

    return 'R\$ ${buffer.toString()},${partes[1]}';
  }
}
