
class CarroCarrinho {
  final int id;
  final String imagem;
  final String nome;
  final String preco;

  CarroCarrinho({
    required this.id,
    required this.imagem,
    required this.nome,
    required this.preco,
  });
}

class CarrinhoService {
  static final List<CarroCarrinho> itens = [];

  static void adicionar(CarroCarrinho carro) {
    final existe = itens.any((item) => item.id == carro.id);

    if (!existe) {
      itens.add(carro);
    }
  }

  static void remover(CarroCarrinho carro) {
    itens.removeWhere((item) => item.id == carro.id);
  }

  static List<int> obterIdsCarros() {
    return itens.map((carro) => carro.id).toList();
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

  static void limpar() {
    itens.clear();
  }
}
