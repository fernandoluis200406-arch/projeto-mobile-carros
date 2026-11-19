import 'package:flutter/material.dart';

import 'package:projetomobilecarros/services/carrinho_service.dart';

class CarroDetalhes extends StatelessWidget {
  final int id;
  final String imagem;
  final String nome;
  final String preco;
  final String descricao;
  final List<String> especificacoes;

  const CarroDetalhes({
    super.key,
    required this.id,
    required this.imagem,
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.especificacoes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),

            // =================================================
            // ROLAGEM
            // =================================================
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // =================================================
                  // VOLTAR
                  // =================================================

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  ),

                  const SizedBox(height: 10),

                  // =================================================
                  // FOTO
                  // =================================================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),

                    child: Image.asset(
                      imagem,

                      width: double.infinity,
                      height: 220,

                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // NOME
                  // =================================================
                  Text(
                    nome,

                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // =================================================
                  // PREÇO
                  // =================================================
                  Text(
                    preco,

                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // SOBRE O VEÍCULO
                  // =================================================
                  const Text(
                    'Sobre o veículo',

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    descricao,

                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // ESPECIFICAÇÕES
                  // =================================================
                  const Text(
                    'Especificações',

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ...especificacoes.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 7),

                      child: Text(
                        '• $item',

                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =================================================
                  // BOTÃO
                  // =================================================
                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        CarrinhoService.adicionar(
                          CarroCarrinho(
                            id: id,
                            imagem: imagem,
                            nome: nome,
                            preco: preco,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Carro adicionado ao carrinho!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },

                      icon: const Icon(Icons.shopping_cart_outlined),

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
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
