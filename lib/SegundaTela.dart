import 'package:flutter/material.dart';
import 'CarroDetalhes.dart';
import 'Carrinho.dart';

class SegundaTela extends StatelessWidget {
  final String usuario;

  const SegundaTela({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 390,
            ),

            child: SizedBox(
              height: MediaQuery.of(context).size.height,

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    // =========================
                    // TOPO
                    // =========================

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

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
                                builder: (context) =>
                                const Carrinho(),
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

                    // =========================
                    // TÍTULO
                    // =========================

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

                    // =========================
                    // CARROS
                    // =========================

                    Row(
                      children: [

                        Expanded(
                          child: _cardCarro(
                            context,
                            'assets/carro2.jpg',
                            'Carro 1',
                            'R\$ 89.900',
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _cardCarro(
                            context,
                            'assets/carro3.jfif',
                            'Carro 2',
                            'R\$ 109.900',
                          ),
                        ),
                      ],
                    ),

                    // =========================
                    // ESPAÇO
                    // =========================

                    const Spacer(),

                    // =========================
                    // BOTÃO CARRINHO
                    // =========================

                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const Carrinho(),
                            ),
                          );
                        },

                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                        ),

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
                            borderRadius:
                            BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // =========================
                    // VOLTAR
                    // =========================

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: const Text(
                        '← Sair',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
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

  // =========================
  // CARD DO CARRO
  // =========================

  Widget _cardCarro(
      BuildContext context,
      String imagem,
      String nome,
      String preco,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarroDetalhes(
              imagem: imagem,
              nome: nome,
              preco: preco,
            ),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(9),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15),

              child: Image.asset(
                imagem,
                width: double.infinity,
                height: 115,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 9),

            Text(
              nome,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              preco,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}