import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> myFormKey = GlobalKey();

    final Map<String, String> formValues = {
      'username'  : 'Tao',
      'email'     : 'tao@gmail.com',
      'password'  : 'tao123',
      'role'      : 'Admin'
    };

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Inputs & Forms'),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            
            key : myFormKey,

            child: Column(
              children: [
                CustomInputField(
                  labelText: 'Username', 
                  suffixIcon: Icons.group_outlined, 
                  formProperty: 'username', 
                  formValues: formValues,
                ),
                const SizedBox(height: 30,),
          
                CustomInputField(
                  labelText: 'Email', 
                  suffixIcon: Icons.email_outlined, 
                  keyboardType: TextInputType.emailAddress, 
                  formProperty: 'email', 
                  formValues: formValues,
                ),
                const SizedBox(height: 30,),
          
                CustomInputField(labelText: 'Password', 
                  suffixIcon: Icons.password_outlined, 
                  obscureText: true,
                  formProperty: 'password', 
                  formValues: formValues,
                ),
                const SizedBox(height: 30,),

                DropdownButtonFormField<String>(
                  items: const [
                    DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                    DropdownMenuItem(value: 'Developer', child: Text('Developer')),
                    DropdownMenuItem(value: 'QA', child: Text('QA')),
                  ], 
                  onChanged: (value) {
                    formValues['role'] = value ?? 'Admin';
                  }
                ),
          
                ElevatedButton(
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('Submit'))
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!myFormKey.currentState!.validate()) {
                      return;
                    }
                    print(formValues);
                  }
                )
              ],
            ),
          ),  
        ),
      )

    );
  }
}
