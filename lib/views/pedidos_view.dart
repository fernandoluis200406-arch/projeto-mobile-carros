import 'package:flutter/material.dart';

import '../controllers/pedido_controller.dart';
import '../models/pedido.dart';

class PedidosView extends StatefulWidget {
  const PedidosView({super.key});

  @override
  State<PedidosView> createState() => _PedidosViewState();
}

class _PedidosViewState extends State<PedidosView> {
  late final PedidoController controller;

  @override
  void initState() {
    super.initState();

    controller = PedidoController();
    controller.carregarPedidos();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String formatarMoeda(double valor) {
    final partes = valor.toStringAsFixed(2).split('.');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos realizados'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (controller.carregando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.erro != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 45),
                  const SizedBox(height: 12),
                  Text(
                    'Erro ao carregar pedidos:\n${controller.erro}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.carregarPedidos,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          if (controller.pedidos.isEmpty) {
            return const Center(
              child: Text('Nenhum pedido encontrado.'),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.carregarPedidos,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.pedidos.length,
              itemBuilder: (context, index) {
                final Pedido pedido = controller.pedidos[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pedido #${pedido.id}',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text('Cliente: ${pedido.nomeCliente}'),
                        Text('Telefone: ${pedido.telefone}'),

                        const Divider(height: 24),

                        const Text(
                          'Veículos solicitados:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        ...pedido.itens.map(
                              (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.directions_car,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${item.nome}\n'
                                        '${formatarMoeda(item.preco)}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(height: 24),

                        Text(
                          'Total: ${formatarMoeda(pedido.total)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Status: ${pedido.status}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}