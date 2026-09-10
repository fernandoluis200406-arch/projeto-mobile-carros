import 'package:flutter/material.dart';

class CarroDetalhes extends StatelessWidget {
  final String imagem;
  final String nome;
  final String preco;

  const CarroDetalhes({
    super.key,
    required this.imagem,
    required this.nome,
    required this.preco,
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    // =========================
                    // TOPO
                    // =========================

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // =========================
                    // FOTO
                    // =========================

                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(22),

                      child: Image.asset(
                        imagem,
                        width: double.infinity,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =========================
                    // NOME
                    // =========================

                    Text(
                      nome,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =========================
                    // PREÇO
                    // =========================

                    Text(
                      preco,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Sobre o veículo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Veículo selecionado pela LA Motors. '
                          'Entre em contato para saber mais detalhes '
                          'sobre este carro, condições e disponibilidade.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),

                    // =========================
                    // ESPAÇO ATÉ O RODAPÉ
                    // =========================

                    const Spacer(),

                    // =========================
                    // BOTÃO CARRINHO
                    // =========================

                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Carro adicionado ao carrinho!',
                              ),
                            ),
                          );
                        },

                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                        ),

                        label: const Text(
                          'Adicionar ao carrinho',
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