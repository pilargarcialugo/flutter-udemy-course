import 'package:flutter/material.dart';
import 'package:forms_validation_app/ui/custom_input_decoration.dart';
import 'package:forms_validation_app/widgets/widgets.dart';

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
                    Text('Login', style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 30,),
                    const _LoginForm()
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              const Text('Create account'),
              const SizedBox(height: 50,),
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
    return Form(
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: CustomInputDecoration.authInputDecoration(
              hintText: 'jq@email.com',
              labelText: 'Email',
              icon: Icons.alternate_email_outlined
            )
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: CustomInputDecoration.authInputDecoration(
              hintText: '******',
              labelText: 'Password',
              icon: Icons.password
            )
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: () {},
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text('submit', style: TextStyle(color: Colors.white),),
            ),

          ),
        ],
      ),
    );
  }
}
