import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:products_app/ui/custom_input_decoration.dart';
import 'package:products_app/providers/providers.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Iniciar sesión', style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 30,),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, 'register', (route) => false), 
                child: const Text('Crear cuenta', style: TextStyle(fontSize: 15, color: Color(0xffe76f51)),),
              ),
              const SizedBox(height: 30,),
            ],
          ),
        )
      )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formStateKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: CustomInputDecoration.authInputDecoration(
                hintText: 'jq@email.com',
                labelText: 'Correo',
                icon: Icons.alternate_email_outlined),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '') ? null : 'No es un correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: CustomInputDecoration.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                icon: Icons.password),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe ser de al menos 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: loginForm.isLoading ? null : () async {
              FocusScope.of(context).unfocus();
              if (!loginForm.isValidForm()) return;
              loginForm.isLoading = true;

              final authService = Provider.of<AuthService>(context, listen: false);
              final String? response = await authService.loginUser(loginForm.email, loginForm.password);
              if (response == null) {
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                AlertService.displaySnackBar(response);
                loginForm.isLoading = false;
              }
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: const Color(0xffe76f51),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                loginForm.isLoading ? 'Enviando...' : 'Enviar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
