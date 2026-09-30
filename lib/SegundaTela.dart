import 'package:flutter/material.dart';

import 'CarroDetalhes.dart';
import 'Carrinho.dart';

class SegundaTela extends StatelessWidget {
  final String usuario;

  const SegundaTela({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    // =================================================
                    // TOPO
                    // =================================================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const Text(
                              'Bem-vindo,',

                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),

                            Text(
                              usuario,

                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Carrinho(),
                              ),
                            );
                          },

                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 28,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // =================================================
                    // TÍTULO
                    // =================================================
                    const Align(
                      alignment: Alignment.centerLeft,

                      child: Text(
                        'Carros disponíveis',

                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // =================================================
                    // CARROS
                    // =================================================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // =================================================
                        // AUDI
                        // =================================================

                        Expanded(
                          child: _cardCarro(
                            context,

                            imagem: 'assets/carro2.jpg',

                            nome: 'Audi R8 V10 Performance',

                            preco: 'R\$ 1.310.990',
                          ),
                        ),

                        const SizedBox(width: 12),

                        // =================================================
                        // BUGATTI
                        // =================================================
                        Expanded(
                          child: _cardCarro(
                            context,

                            imagem: 'assets/carro3.jfif',

                            nome: 'Bugatti Chiron Sport',

                            preco: 'R\$ 50.000.000',
                          ),
                        ),
                      ],
                    ),

                    // =================================================
                    // ESPAÇO
                    // =================================================
                    const Spacer(),

                    // =================================================
                    // BOTÃO CARRINHO
                    // =================================================
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Carrinho(),
                            ),
                          );
                        },

                        icon: const Icon(Icons.shopping_cart_outlined),

                        label: const Text(
                          'Carrinho',

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // =================================================
                    // SAIR
                    // =================================================
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        '← Sair',

                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =============================================================
  // CARD DO CARRO
  // =============================================================

  Widget _cardCarro(
    BuildContext context, {
    required String imagem,
    required String nome,
    required String preco,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 220,

      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) =>
                  CarroDetalhes(imagem: imagem, nome: nome, preco: preco),
            ),
          );
        },

        child: Container(
          padding: const EdgeInsets.all(10),

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

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // =================================================
              // IMAGEM
              // =================================================

              ClipRRect(
                borderRadius: BorderRadius.circular(13),

                child: Image.asset(
                  imagem,

                  width: double.infinity,
                  height: 115,

                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 8),

              // =================================================
              // NOME
              // =================================================
              SizedBox(
                height: 44,

                child: Text(
                  nome,

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 2),

              // =================================================
              // PREÇO
              // =================================================
              Text(
                preco,

                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
