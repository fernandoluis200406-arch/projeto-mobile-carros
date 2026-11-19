import 'package:flutter/material.dart';

import '../models/pedido.dart';
import '../services/api_service.dart';

class PedidoController extends ChangeNotifier {
  List<Pedido> pedidos = [];

  bool carregando = false;
  String? erro;

  Future<void> carregarPedidos() async {
    carregando = true;
    erro = null;
    notifyListeners();

    try {
      pedidos = await ApiService.listarPedidos();
    } catch (e) {
      erro = e.toString();
    }

    carregando = false;
    notifyListeners();
  }
}