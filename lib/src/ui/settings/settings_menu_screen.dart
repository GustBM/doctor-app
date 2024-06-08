import 'package:doctor247_doutor/src/ui/account/account_change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Aplicativo'),
            tiles: [
              SettingsTile(
                title: const Text('Língua'),
                description: const Text('Português'),
                leading: const Icon(Icons.language_outlined),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: const Text('Usar Tema do Sistema'),
                leading: const Icon(Icons.phone_android_outlined),
                initialValue: isSwitched,
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Conta'),
            tiles: [
              SettingsTile(
                title: const Text('Trocar Senha'),
                leading: const Icon(Icons.password_outlined),
                onPressed: (BuildContext context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountChangePasswordScreen(
                        goBack: true,
                      ),
                    ),
                  );
                },
              ),
              SettingsTile(
                title: const Text('Sair da Conta'),
                leading: const Icon(Icons.exit_to_app_outlined),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          // SettingsSection(
          //   titlePadding: EdgeInsets.all(20),
          //   title: 'Section 2',
          //   tiles: [
          //     SettingsTile(
          //       title: 'Security',
          //       subtitle: 'Fingerprint',
          //       leading: Icon(Icons.lock),
          //       onPressed: (BuildContext context) {},
          //     ),
          //     SettingsTile.switchTile(
          //       title: 'Use fingerprint',
          //       leading: Icon(Icons.fingerprint),
          //       switchValue: true,
          //       onToggle: (value) {},
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
