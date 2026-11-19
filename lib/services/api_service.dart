import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/carro.dart';
import '../models/pedido.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // =================================================
  // LISTAR VEÍCULOS
  // =================================================

  static Future<List<Carro>> listarCarros() async {
    final url = Uri.parse('$baseUrl/carros/');

    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final List<dynamic> dados =
      jsonDecode(utf8.decode(resposta.bodyBytes));

      return dados.map((item) => Carro.fromJson(item)).toList();
    } else {
      throw Exception(
        'Erro ao buscar veículos: ${resposta.statusCode}',
      );
    }
  }

  // =================================================
  // CADASTRAR VEÍCULO
  // =================================================

  static Future<Carro> criarCarro({
    required String nome,
    required double preco,
    required String imagem,
    required String descricao,
    required List<String> especificacoes,
  }) async {
    final url = Uri.parse('$baseUrl/carros/');

    final resposta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nome': nome,
        'preco': preco,
        'imagem': imagem,
        'descricao': descricao,
        'especificacoes': especificacoes,
      }),
    );

    if (resposta.statusCode == 200 ||
        resposta.statusCode == 201) {
      return Carro.fromJson(
        jsonDecode(utf8.decode(resposta.bodyBytes)),
      );
    } else {
      throw Exception(
        'Erro ao cadastrar veículo: '
            '${resposta.statusCode} - ${resposta.body}',
      );
    }
  }

  // =================================================
  // ATUALIZAR VEÍCULO
  // =================================================

  static Future<Carro> atualizarCarro({
    required int id,
    required String nome,
    required double preco,
    required String imagem,
    required String descricao,
    required List<String> especificacoes,
  }) async {
    final url = Uri.parse('$baseUrl/carros/$id');

    final resposta = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nome': nome,
        'preco': preco,
        'imagem': imagem,
        'descricao': descricao,
        'especificacoes': especificacoes,
      }),
    );

    if (resposta.statusCode == 200) {
      return Carro.fromJson(
        jsonDecode(utf8.decode(resposta.bodyBytes)),
      );
    } else {
      throw Exception(
        'Erro ao atualizar veículo: '
            '${resposta.statusCode} - ${resposta.body}',
      );
    }
  }

  // =================================================
  // EXCLUIR VEÍCULO
  // =================================================

  static Future<void> excluirCarro(int id) async {
    final url = Uri.parse('$baseUrl/carros/$id');

    final resposta = await http.delete(url);

    if (resposta.statusCode != 200 &&
        resposta.statusCode != 204) {
      throw Exception(
        'Erro ao excluir veículo: '
            '${resposta.statusCode} - ${resposta.body}',
      );
    }
  }



  // =================================================
  // LISTAR CLIENTES
  // =================================================

  static Future<List<Map<String, dynamic>>> listarClientes() async {
    final url = Uri.parse('$baseUrl/clientes/');

    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final List<dynamic> dados =
      jsonDecode(utf8.decode(resposta.bodyBytes));

      return dados.cast<Map<String, dynamic>>();
    } else {
      throw Exception(
        'Erro ao buscar clientes: ${resposta.statusCode}',
      );
    }
  }


  // =================================================
  // LISTAR PEDIDOS
  // =================================================

  static Future<List<Pedido>> listarPedidos() async {
    final url = Uri.parse('$baseUrl/pedidos/');

    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final List<dynamic> dados =
      jsonDecode(utf8.decode(resposta.bodyBytes));

      return dados.map((item) => Pedido.fromJson(item)).toList();
    } else {
      throw Exception(
        'Erro ao buscar pedidos: ${resposta.statusCode}',
      );
    }
  }

  // =================================================
  // CRIAR PEDIDO
  // =================================================

  static Future<Map<String, dynamic>> criarPedido({
    required String nomeCliente,
    required String cpf,
    required String telefone,
    required List<int> carrosIds,
  }) async {
    final url = Uri.parse('$baseUrl/pedidos/');

    final resposta = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nome_cliente': nomeCliente,
        'cpf': cpf,
        'telefone': telefone,
        'carros_ids': carrosIds,
      }),
    );

    if (resposta.statusCode == 201) {
      return jsonDecode(utf8.decode(resposta.bodyBytes))
      as Map<String, dynamic>;
    } else {
      throw Exception(
        'Erro ao criar pedido: '
            '${resposta.statusCode} - ${resposta.body}',
      );
    }
  }
}