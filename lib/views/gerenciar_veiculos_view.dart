import 'package:flutter/material.dart';
import '../models/carro.dart';
import '../services/api_service.dart';

class GerenciarVeiculosView extends StatefulWidget {
  const GerenciarVeiculosView({super.key});

  @override
  State<GerenciarVeiculosView> createState() =>
      _GerenciarVeiculosViewState();
}

class _GerenciarVeiculosViewState
    extends State<GerenciarVeiculosView> {
  List<Carro> carros = [];

  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarCarros();
  }

  Future<void> carregarCarros() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final resultado = await ApiService.listarCarros();

      if (!mounted) return;

      setState(() {
        carros = resultado;
        carregando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = 'Não foi possível carregar os veículos.';
        carregando = false;
      });
    }
  }

  Widget construirCardCarro(Carro carro) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                carro.imagem,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.directions_car,
                      size: 60,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            Text(
              carro.nome,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              carro.precoFormatado,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    abrirFormularioEdicao(carro);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),

                const SizedBox(width: 10),

                OutlinedButton.icon(
                  onPressed: () {
                    confirmarExclusao(carro);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Excluir',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> abrirFormularioCadastro() async {
    final nomeController = TextEditingController();
    final precoController = TextEditingController();
    final imagemController = TextEditingController();
    final descricaoController = TextEditingController();
    final especificacoesController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastrar veículo'),
          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do veículo',
                      ),
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe o nome.'
                          : null,
                    ),
                    TextFormField(
                      controller: precoController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Preço (ex.: 250000.00)',
                      ),
                      validator: (valor) {
                        final preco = double.tryParse(
                          (valor ?? '').replaceAll(',', '.'),
                        );
                        if (preco == null || preco <= 0) {
                          return 'Informe um preço válido.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: imagemController,
                      decoration: const InputDecoration(
                        labelText: 'Caminho da imagem',
                        hintText: 'assets/carro2.jpg',
                      ),
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe o caminho da imagem.'
                          : null,
                    ),
                    TextFormField(
                      controller: descricaoController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                      ),
                      maxLines: 3,
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe a descrição.'
                          : null,
                    ),
                    TextFormField(
                      controller: especificacoesController,
                      decoration: const InputDecoration(
                        labelText: 'Especificações técnicas',
                        hintText: 'Uma especificação por linha',
                      ),
                      maxLines: 5,
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe as especificações.'
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Cadastrar'),
            ),
          ],
        );
      },
    );

    if (resultado == true) {
      try {
        final preco = double.parse(
          precoController.text.replaceAll(',', '.'),
        );

        await ApiService.criarCarro(
          nome: nomeController.text.trim(),
          preco: preco,
          imagem: imagemController.text.trim(),
          descricao: descricaoController.text.trim(),
          especificacoes: especificacoesController.text
              .split('\n')
              .map((item) => item.trim())
              .where((item) => item.isNotEmpty)
              .toList(),
        );

        if (!mounted) return;

        await carregarCarros();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veículo cadastrado com sucesso!'),
          ),
        );
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cadastrar veículo: $e'),
          ),
        );
      }
    }

    nomeController.dispose();
    precoController.dispose();
    imagemController.dispose();
    descricaoController.dispose();
    especificacoesController.dispose();
  }

  Future<void> abrirFormularioEdicao(Carro carro) async {
    final nomeController = TextEditingController(text: carro.nome);
    final precoController = TextEditingController(
      text: carro.preco.toStringAsFixed(2),
    );
    final imagemController = TextEditingController(text: carro.imagem);
    final descricaoController = TextEditingController(
      text: carro.descricao,
    );
    final especificacoesController = TextEditingController(
      text: carro.especificacoes.join('\n'),
    );

    final formKey = GlobalKey<FormState>();

    final resultado = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar veículo'),
          content: SizedBox(
            width: 450,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do veículo',
                      ),
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe o nome.'
                          : null,
                    ),
                    TextFormField(
                      controller: precoController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Preço',
                      ),
                      validator: (valor) {
                        final preco = double.tryParse(
                          (valor ?? '').replaceAll(',', '.'),
                        );

                        if (preco == null || preco <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      controller: imagemController,
                      decoration: const InputDecoration(
                        labelText: 'Caminho da imagem',
                      ),
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe a imagem.'
                          : null,
                    ),
                    TextFormField(
                      controller: descricaoController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                      ),
                      maxLines: 3,
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe a descrição.'
                          : null,
                    ),
                    TextFormField(
                      controller: especificacoesController,
                      decoration: const InputDecoration(
                        labelText: 'Especificações técnicas',
                        hintText: 'Uma especificação por linha',
                      ),
                      maxLines: 5,
                      validator: (valor) =>
                      valor == null || valor.trim().isEmpty
                          ? 'Informe as especificações.'
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Salvar alterações'),
            ),
          ],
        );
      },
    );

    if (resultado == true) {
      try {
        final preco = double.parse(
          precoController.text.replaceAll(',', '.'),
        );

        await ApiService.atualizarCarro(
          id: carro.id,
          nome: nomeController.text.trim(),
          preco: preco,
          imagem: imagemController.text.trim(),
          descricao: descricaoController.text.trim(),
          especificacoes: especificacoesController.text
              .split('\n')
              .map((item) => item.trim())
              .where((item) => item.isNotEmpty)
              .toList(),
        );

        if (!mounted) return;

        await carregarCarros();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veículo atualizado com sucesso!'),
          ),
        );
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar veículo: $e'),
          ),
        );
      }
    }

    nomeController.dispose();
    precoController.dispose();
    imagemController.dispose();
    descricaoController.dispose();
    especificacoesController.dispose();
  }

  Future<void> confirmarExclusao(Carro carro) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir veículo'),
          content: Text(
            'Tem certeza de que deseja excluir o veículo ${carro.nome}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) return;

    try {
      await ApiService.excluirCarro(carro.id);

      await carregarCarros();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veículo excluído com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir veículo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      appBar: AppBar(
        title: const Text('Gerenciar veículos'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: carregarCarros,
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar veículos',
          ),
        ],
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: carregando
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : erro != null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(erro!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: carregarCarros,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            )
                : carros.isEmpty
                ? const Center(
              child: Text(
                'Nenhum veículo cadastrado.',
              ),
            )
                : RefreshIndicator(
              onRefresh: carregarCarros,
              child: ListView(
                children: [
                  const Text(
                    'Veículos cadastrados',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '${carros.length} veículo(s) encontrado(s)',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: abrirFormularioCadastro,
                      icon: const Icon(Icons.add),
                      label: const Text('Cadastrar novo veículo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ...carros.map(construirCardCarro),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}