
import 'package:flutter/material.dart';

import '../controllers/carro_controller.dart';
import '../models/carro.dart';
import 'carro_detalhes.dart';
import 'carrinho.dart';

class SegundaTela extends StatefulWidget {
  final String usuario;

  const SegundaTela({
    super.key,
    required this.usuario,
  });

  @override
  State<SegundaTela> createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  late final CarroController controller;

  @override
  void initState() {
    super.initState();

    controller = CarroController();
    controller.carregarCarros();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

                    // TOPO
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
                              widget.usuario,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        IconButton(
                          onPressed: abrirCarrinho,

                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 28,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

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

                    // CONTEÚDO DINÂMICO DA API
                    Expanded(
                      child: AnimatedBuilder(
                        animation: controller,

                        builder: (context, child) {

                          if (controller.carregando) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            );
                          }

                          if (controller.erro != null) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  const Icon(
                                    Icons.cloud_off_outlined,
                                    size: 55,
                                    color: Colors.grey,
                                  ),

                                  const SizedBox(height: 12),

                                  Text(
                                    controller.erro!,
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 12),

                                  ElevatedButton(
                                    onPressed: controller.carregarCarros,

                                    child: const Text('Tentar novamente'),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (controller.carros.isEmpty) {
                            return const Center(
                              child: Text(
                                'Nenhum veículo disponível.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            );
                          }

                          return GridView.builder(
                            itemCount: controller.carros.length,

                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              mainAxisExtent: 220,
                            ),

                            itemBuilder: (context, index) {
                              final carro = controller.carros[index];

                              return cardCarro(carro);
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // BOTÃO CARRINHO
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton.icon(
                        onPressed: abrirCarrinho,

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
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    // SAIR
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

  // CARD DO VEÍCULO
  Widget cardCarro(Carro carro) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) => CarroDetalhes(
              id: carro.id,
              imagem: carro.imagem,
              nome: carro.nome,
              preco: carro.precoFormatado,
              descricao: carro.descricao,
              especificacoes: carro.especificacoes,
            ),
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

            ClipRRect(
              borderRadius: BorderRadius.circular(13),

              child: Image.asset(
                carro.imagem,
                width: double.infinity,
                height: 115,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 115,
                    color: Colors.grey.shade200,

                    child: const Icon(
                      Icons.directions_car,
                      size: 45,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 44,

              child: Text(
                carro.nome,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 2),

            Text(
              carro.precoFormatado,

              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void abrirCarrinho() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const Carrinho(),
      ),
    );
  }
}
