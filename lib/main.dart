import 'package:flutter/material.dart';
import 'package:projetomobilecarros/views/tela_inicial.dart';
import 'package:projetomobilecarros/views/pedidos_view.dart';

void main() {
  runApp(const LAMotorsApp());
}

class LAMotorsApp extends StatelessWidget {
  const LAMotorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TelaInicial(),
      routes: {
        '/pedidos': (context) => const PedidosView(),
      },
    );
  }
}