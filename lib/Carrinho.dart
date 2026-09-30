import 'package:flutter/material.dart';

import 'CarrinhoService.dart';
import 'CompraFinal.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  void removerCarro(CarroCarrinho carro) {
    setState(() {
      CarrinhoService.remover(carro);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Carro removido do carrinho.')),
    );
  }

  String formatarTotal(double valor) {
    final valorFormatado = valor.toStringAsFixed(2).replaceAll('.', ',');

    final partes = valorFormatado.split(',');

    String inteiro = partes[0];

    final buffer = StringBuffer();

    for (int i = 0; i < inteiro.length; i++) {
      if (i > 0 && (inteiro.length - i) % 3 == 0) {
        buffer.write('.');
      }

      buffer.write(inteiro[i]);
    }

    return 'R\$ ${buffer.toString()},${partes[1]}';
  }

  @override
  Widget build(BuildContext context) {
    final itens = CarrinhoService.itens;
    final total = CarrinhoService.calcularTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),

            child: SizedBox(
              height: MediaQuery.of(context).size.height,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // =========================
                    // TOPO
                    // =========================

                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                        ),

                        const SizedBox(width: 5),

                        const Text(
                          'Carrinho',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // =========================
                    // CARRINHO VAZIO
                    // =========================
                    if (itens.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 60,
                                color: Colors.grey,
                              ),

                              SizedBox(height: 15),

                              Text(
                                'Seu carrinho está vazio.',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                'Adicione um veículo para continuar.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.separated(
                          itemCount: itens.length,

                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),

                          itemBuilder: (context, index) {
                            final carro = itens[index];

                            return Container(
                              padding: const EdgeInsets.all(12),

                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(18),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),

                                    blurRadius: 10,

                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),

                              child: Row(
                                children: [
                                  // FOTO
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),

                                    child: Image.asset(
                                      carro.imagem,

                                      width: 95,
                                      height: 80,

                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // INFORMAÇÕES
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          carro.nome,

                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        Text(
                                          carro.preco,

                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // LIXEIRA
                                  IconButton(
                                    onPressed: () {
                                      removerCarro(carro);
                                    },

                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                    // =========================
                    // TOTAL
                    // =========================
                    if (itens.isNotEmpty) ...[
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            formatarTotal(total),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // =========================
                      // CONTINUAR
                      // =========================
                      SizedBox(
                        width: double.infinity,
                        height: 52,

                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CompraFinal(),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          child: const Text(
                            'Continuar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
