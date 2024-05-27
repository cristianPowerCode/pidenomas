import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_cliente_page.dart';
import 'registrar_cliente3_page.dart';
import 'registrar_cliente_4_page.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/background_widget.dart';
import '../ui/widgets/general_widgets.dart';

class RegistrarCliente2Page extends StatefulWidget {
  const RegistrarCliente2Page({super.key});

  @override
  State<RegistrarCliente2Page> createState() => _RegistrarCliente2PageState();
}

class _RegistrarCliente2PageState extends State<RegistrarCliente2Page> {
  final TextEditingController _celularController = TextEditingController();
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes =
        List.generate(4, (_) => FocusNode()); // Inicialización de FocusNode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    } // Liberar los FocusNode
    super.dispose();
  }

  String getPin() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGroundWidget(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Un código de activación será enviado"),
            divider12(),
            TextFormField(
              controller: _celularController,
              maxLength: 9,
              style: TextStyle(letterSpacing: 10.0),
              inputFormatters: 9 != null
                  ? [
                      FilteringTextInputFormatter(
                        RegExp(r'[0-9]'),
                        allow: true,
                      ),
                    ]
                  : [],
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                  color: kBrandPrimaryColor1,
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: kBrandPrimaryColor1,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: kBrandPrimaryColor1.withOpacity(0.42),
                        offset: const Offset(4, 4),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                border: OutlineInputBorder(),
                labelText: 'Celular',
                labelStyle: TextStyle(color: Color(0xffB1B1B1)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: const BorderSide(
                    color: kBrandPrimaryColor1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: const BorderSide(color: Color(0xffB1B1B1)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  borderSide: const BorderSide(
                    color: kErrorColor,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                errorStyle: const TextStyle(color: kErrorColor),
              ),
            ),
            divider12(),
            Text(
              "Enviamos un SMS con su CODIGO  de verificación al",
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.black12,
                ),
                child: Text("9******1")),
            divider30(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => BoxOtpForm(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                ), // Pasar el FocusNode correspondiente
              ),
            ),
            divider40(),
            ElevatedButton(
              onPressed: () {
                String pin = getPin();
                print("PIN: $pin");
                // Aquí puedes hacer lo que quieras con el PIN, como guardarlo en una variable global
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrarCliente3Page(),
                    ));
              },
              child: const Text("Guardar"),
            ),
            divider40(),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginClientePage(),
                    ));
              },
              child: const Text(
                "Registrarme más tarde",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoxOtpForm extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const BoxOtpForm({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          if (value.isEmpty) {
            // Si el campo está vacío, mueve el foco al campo anterior
            FocusScope.of(context).previousFocus();
          } else if (value.length == 1) {
            // Si se ingresa un solo carácter, mueve el foco al siguiente campo
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          hintText: "0",
          hintStyle: const TextStyle(
            color: Color(0xffB1B1B1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(
              color: kBrandPrimaryColor1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Color(0xffB1B1B1)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(
              color: kErrorColor,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          errorStyle: const TextStyle(color: kErrorColor),
        ),
        style: Theme.of(context).textTheme.headlineSmall,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
