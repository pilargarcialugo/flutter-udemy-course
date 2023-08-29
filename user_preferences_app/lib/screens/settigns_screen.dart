import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_preferences_app/preferences/preferences.dart';
import 'package:user_preferences_app/providers/providers.dart';
import 'package:user_preferences_app/widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {

  static const String routerName = 'Settigns';
   
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Settings', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
              const Divider(),
              SwitchListTile.adaptive(
                value: Preferences.isDarkModeenabled, 
                title: const Text('DarkMode'),
                onChanged: (value) {
                  Preferences.isDarkModeEnabled = value;
                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  value ? themeProvider.setDarkMode() : themeProvider.setLightMode();
                  setState(() {});
                }
              ),
              const Divider(),
              createRadioList(1, 'Female'),
              const Divider(),
              createRadioList(2, 'Male'),
              const Divider(),
              createRadioList(3, 'Non binarie'),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  initialValue: Preferences.name,
                  onChanged: (value) {
                    Preferences.name = value;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    helperText: 'Username'
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  RadioListTile<int> createRadioList(int defaultValue, String title) {
    return RadioListTile<int>(
      value: defaultValue, 
      groupValue: Preferences.gender, 
      title: Text(title),
      onChanged: (value) {
        Preferences.gender = value ?? defaultValue;
        setState(() {});
      }
    );
  }
}