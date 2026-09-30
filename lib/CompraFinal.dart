import 'package:flutter/material.dart';

import 'CarrinhoService.dart';

class CompraFinal extends StatefulWidget {
  const CompraFinal({super.key});

  @override
  State<CompraFinal> createState() => _CompraFinalState();
}

class _CompraFinalState extends State<CompraFinal> {
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  // =========================================================
  // FORMATAÇÃO DO VALOR
  // =========================================================

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

  // =========================================================
  // CONFIRMAR COMPRA
  // =========================================================

  void confirmarCompra() {
    if (nomeController.text.trim().isEmpty ||
        cpfController.text.trim().isEmpty ||
        telefoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos para continuar.'),
        ),
      );

      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CompraSucesso()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = CarrinhoService.calcularTotal();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),

            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // =================================================
                  // TOPO
                  // =================================================

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
                        'Finalizar compra',

                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // =================================================
                  // TÍTULO
                  // =================================================
                  const Text(
                    'Dados do comprador',

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  // =================================================
                  // NOME
                  // =================================================
                  TextField(
                    controller: nomeController,

                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      labelText: 'Nome completo',
                      prefixIcon: const Icon(Icons.person_outline),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =================================================
                  // CPF
                  // =================================================
                  TextField(
                    controller: cpfController,

                    keyboardType: TextInputType.number,

                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      labelText: 'CPF',

                      prefixIcon: const Icon(Icons.badge_outlined),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =================================================
                  // TELEFONE
                  // =================================================
                  TextField(
                    controller: telefoneController,

                    keyboardType: TextInputType.phone,

                    decoration: InputDecoration(
                      labelText: 'Telefone',

                      prefixIcon: const Icon(Icons.phone_outlined),

                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),

                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =================================================
                  // RESUMO
                  // =================================================
                  const Text(
                    'Resumo do pedido',

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),

                          blurRadius: 10,

                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        ...CarrinhoService.itens.map(
                          (carro) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),

                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),

                                  child: Image.asset(
                                    carro.imagem,

                                    width: 70,
                                    height: 55,

                                    fit: BoxFit.cover,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Text(
                                    carro.nome,

                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                Text(
                                  carro.preco,

                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(),

                        const SizedBox(height: 10),

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
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // =================================================
                  // AVISO
                  // =================================================
                  Container(
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.black,

                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.white, size: 20),

                        SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            'Após a confirmação, nossa equipe '
                            'entrará em contato para finalizar '
                            'a negociação.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
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
                      onPressed: confirmarCompra,

                      icon: const Icon(Icons.check_circle_outline),

                      label: const Text(
                        'Confirmar compra',

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

// =============================================================
// TELA DE SUCESSO
// =============================================================

class CompraSucesso extends StatelessWidget {
  const CompraSucesso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 390),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // =================================================
                  // ÍCONE
                  // =================================================

                  Container(
                    width: 90,
                    height: 90,

                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =================================================
                  // TÍTULO
                  // =================================================
                  const Text(
                    'Compra solicitada!',

                    textAlign: TextAlign.center,

                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Recebemos sua solicitação com sucesso.',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'A equipe da LA Motors entrará em '
                    'contato para confirmar os detalhes '
                    'da negociação.',

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // =================================================
                  // BOTÃO
                  // =================================================
                  SizedBox(
                    width: double.infinity,
                    height: 52,

                    child: ElevatedButton(
                      onPressed: () {
                        CarrinhoService.itens.clear();

                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
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
                        'Voltar para o início',

                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
    );
  }
}
