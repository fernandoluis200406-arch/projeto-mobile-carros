
import 'package:flutter/material.dart';

import '../models/carro.dart';
import '../services/api_service.dart';

class CarroController extends ChangeNotifier {

  List<Carro> carros = [];

  bool carregando = false;

  String? erro;

  Future<void> carregarCarros() async {

    carregando = true;
    erro = null;

    notifyListeners();

    try {

      carros = await ApiService.listarCarros();

    } catch (e) {

      erro = 'Nao foi possivel carregar os veiculos.';

      debugPrint('Erro na API: $e');

    } finally {

      carregando = false;

      notifyListeners();
    }
  }
}
