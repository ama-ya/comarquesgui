import 'package:comarquesgui/screens/provincies_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controladorUsuario = TextEditingController();
  final TextEditingController _controladorPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      createRegisterNameFormField(),
                      const SizedBox(height: 16.0),
                      createPasswordFormField(),
                      const SizedBox(height: 16.0),
                      createSubmitButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controladorUsuario.text = "";
    _controladorPassword.text = "";
  }

  @override
  void dispose() {
    _controladorUsuario.dispose();
    _controladorPassword.dispose();
    super.dispose();
  }

  TextFormField createRegisterNameFormField() {
    return TextFormField(
      controller: _controladorUsuario,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'El campo no puede estar vacío';
        }
        final regexCorreu = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!regexCorreu.hasMatch(value ?? "")) {
          return 'La dirección de correo no es válida';
        }
        return null;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          icon: const Icon(Icons.email),
          labelText: "Correo electrónico"),
    );
  }

  TextFormField createPasswordFormField() {
    return TextFormField(
      controller: _controladorPassword,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'El campo no puede estar vacío';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          icon: const Icon(Icons.lock),
          labelText: "Contraseña"),
    );
  }

  Widget createSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Align(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            const String usuario = 'usuario@usuario.es';
            const String password = '1234';

            if (_formKey.currentState?.validate() ?? false) {
              if (_controladorUsuario.text == usuario &&
                  _controladorPassword.text == password) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProvinciesScreen()));
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'El usuario o la contraseña son incorrectas'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Volver'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _controladorUsuario.text = usuario;
                                _controladorPassword.text = password;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Rellenar usuario'),
                          ),
                        ],
                      );
                    });
              }
            }
          },
          child: const Text('Iniciar sesión'),
        ),
      ),
    );
  }
}
