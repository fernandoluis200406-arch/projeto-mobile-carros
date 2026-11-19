class ItemPedido {
  final int? carroId;
  final String nome;
  final double preco;

  ItemPedido({
    this.carroId,
    required this.nome,
    required this.preco,
  });

  factory ItemPedido.fromJson(Map<String, dynamic> json) {
    return ItemPedido(
      carroId: json['carro_id'],
      nome: json['nome'],
      preco: (json['preco'] as num).toDouble(),
    );
  }
}

class Pedido {
  final int id;
  final String nomeCliente;
  final String telefone;
  final List<ItemPedido> itens;
  final double total;
  final String status;

  Pedido({
    required this.id,
    required this.nomeCliente,
    required this.telefone,
    required this.itens,
    required this.total,
    required this.status,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      nomeCliente: json['nome_cliente'],
      telefone: json['telefone'],
      itens: (json['itens'] as List)
          .map((item) => ItemPedido.fromJson(item))
          .toList(),
      total: (json['total'] as num).toDouble(),
      status: json['status'],
    );
  }
}