import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/custom_labels.dart';
import 'package:chat_app/widgets/custom_logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLogo(label: 'Registro',),
                _Form(),
                CustomLabels(
                  registerRoute: 'login',
                  mainText: '¿Ya tienes una cuenta?',
                  gestureDetectorText: 'Inicia Sesión',
                ),
                Text(
                  'Términos y condiciones de uso', 
                  style: TextStyle(color: Color(0xff212529), fontSize: 14, fontWeight: FontWeight.w200),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity_outlined,
            hintText: 'Name',
            textController: nameController,
            keyboardType: TextInputType.name,
          ),
          CustomInput(
            icon: Icons.email_outlined,
            hintText: 'Email',
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            hintText: 'Password',
            textController: passwordController,
            isPassword: true,
          ),
          CustomButton(
            buttonText: 'Registrarse',
            onPressed: () => print('Regisssss'),
          )
        ],
      ),
    );
  }
}