import 'package:flutter/material.dart';
import 'package:projetomobilecarros/SegundaTela.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usuarioController =
    TextEditingController();

    final TextEditingController senhaController =
    TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 390,
            ),

            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [

                  const SizedBox(height: 15),

                  // TÍTULO
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // LOGO + CAMPOS
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // LOGO
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),

                          child: Image.asset(
                            'assets/lamotorslogo.jpeg',
                            height: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // CAMPOS
                      Expanded(
                        child: Column(
                          children: [

                            TextField(
                              controller: usuarioController,

                              decoration: InputDecoration(
                                hintText: 'Usuário',

                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  size: 20,
                                ),

                                filled: true,
                                fillColor: Colors.white,

                                contentPadding:
                                const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),

                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),

                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            TextField(
                              controller: senhaController,

                              obscureText: true,

                              decoration: InputDecoration(
                                hintText: 'Senha',

                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  size: 20,
                                ),

                                filled: true,
                                fillColor: Colors.white,

                                contentPadding:
                                const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),

                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),

                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // BOTÃO LOGIN
                  SizedBox(
                    width: double.infinity,
                    height: 50,

                    child: ElevatedButton(
                      onPressed: () {
                        final usuario =
                        usuarioController.text.trim();

                        if (usuario.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Digite seu usuário.',
                              ),
                            ),
                          );

                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SegundaTela(
                              usuario: usuario,
                            ),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                      ),

                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // SOBRE A EMPRESA
                  const Text(
                    'Sobre a empresa',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'A LA Motors é uma garagem especializada '
                        'em veículos selecionados, oferecendo '
                        'qualidade, confiança e excelentes opções '
                        'para você encontrar seu próximo carro.',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // IMAGEM DA EMPRESA
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: Image.asset(
                      'assets/lamotorslogo.jpeg',
                      width: double.infinity,
                      height: 170,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}