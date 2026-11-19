
import 'package:flutter/material.dart';

import 'pedidos_view.dart';
import '../services/api_service.dart';
import '../models/carro.dart';
import '../models/pedido.dart';
import 'gerenciar_veiculos_view.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int totalCarros = 0;
  int totalPedidos = 0;
  int totalClientes = 0;

  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    if (!mounted) return;

    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      // Buscar os dados diretamente do banco através da API.
      final List<Carro> carros = await ApiService.listarCarros();
      final List<Pedido> pedidos = await ApiService.listarPedidos();
      final List<Map<String, dynamic>> clientes =
      await ApiService.listarClientes();

      if (!mounted) return;

      setState(() {
        totalCarros = carros.length;
        totalPedidos = pedidos.length;
        totalClientes = clientes.length;
        carregando = false;
      });
    } catch (e) {
      debugPrint('Erro ao carregar dashboard: $e');

      if (!mounted) return;

      setState(() {
        erro = 'Não foi possível carregar os dados.';
        carregando = false;
      });
    }
  }

  Widget construirIndicador(
      String titulo,
      int quantidade,
      IconData icone,
      ) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icone,
              size: 35,
              color: Colors.blueGrey,
            ),
            const SizedBox(height: 12),
            Text(
              quantidade.toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              titulo,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LA Motors - Administração'),
        actions: [
          IconButton(
            onPressed: carregarDados,
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar dados',
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: carregando
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : erro != null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(erro!),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: carregarDados,
                  child: const Text('Tentar novamente'),
                ),
              ],
            )
                : ListView(
              children: [
                const Text(
                  'Painel Administrativo',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Visão geral do sistema LA Motors.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 25),

                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                  children: [
                    construirIndicador(
                      'Veículos',
                      totalCarros,
                      Icons.directions_car,
                    ),
                    construirIndicador(
                      'Clientes cadastrados',
                      totalClientes,
                      Icons.people,
                    ),
                    construirIndicador(
                      'Pedidos',
                      totalPedidos,
                      Icons.shopping_bag,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  'Gerenciamento',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_bag,
                    ),
                    title: const Text(
                      'Consultar pedidos',
                    ),
                    subtitle: const Text(
                      'Visualizar as solicitações de compra.',
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const PedidosView(),
                        ),
                      );
                    },
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.directions_car,
                    ),
                    title: const Text(
                      'Gerenciar veículos',
                    ),
                    subtitle: const Text(
                      'Adicionar, editar e excluir veículos.',
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                          const GerenciarVeiculosView(),
                        ),
                      );

                      if (mounted) {
                        carregarDados();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
