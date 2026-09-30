class CarroCarrinho {
  final String imagem;
  final String nome;
  final String preco;

  CarroCarrinho({
    required this.imagem,
    required this.nome,
    required this.preco,
  });
}

class CarrinhoService {
  static final List<CarroCarrinho> itens = [];

  static void adicionar(CarroCarrinho carro) {
    final existe = itens.any((item) => item.nome == carro.nome);

    if (!existe) {
      itens.add(carro);
    }
  }

  static void remover(CarroCarrinho carro) {
    itens.removeWhere((item) => item.nome == carro.nome);
  }

  static double calcularTotal() {
    double total = 0;

    for (final carro in itens) {
      final valor = carro.preco
          .replaceAll('R\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .trim();

      total += double.tryParse(valor) ?? 0;
    }

    return total;
  }
}
