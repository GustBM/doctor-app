import 'package:doctor247_doutor/src/blocs/auth/auth_bloc.dart';
import 'package:doctor247_doutor/src/ui/qr_reader/qr_code_reader_screen.dart';
import 'package:doctor247_doutor/src/ui/settings/settings_menu_screen.dart';
import 'package:doctor247_doutor/src/ui/terms/terms_and_conditions_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils.dart';
import '../../resources/constants/terms.dart';

class DoctorDrawer extends StatelessWidget {
  const DoctorDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white70,
      child: ListView(
        children: [
          const SizedBox(height: 20),
          ListTile(
            title: const Text(
              "Validação por QR code",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            leading: const Icon(
              Icons.qr_code_2,
              color: Colors.black87,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRCodeReaderScreen()),
              );
            },
          ),
          const Divider(thickness: .5, color: Colors.grey),
          ListTile(
            title: const Text(
              "Termos de Consentimento",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            leading: const Icon(
              Icons.file_copy,
              color: Colors.black87,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndConditionsScreen(
                          termTitle: 'Termos de Consentimento',
                          termsModel: consentTerm,
                        )),
              );
            },
          ),
          const Divider(thickness: .5, color: Colors.grey),
          ListTile(
            title: const Text(
              "Política de cancelamento",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            leading: const Icon(
              Icons.file_copy,
              color: Colors.black87,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndConditionsScreen(
                          termTitle: 'Termos de Cancelamento',
                          termsModel: cancelTerm,
                        )),
              );
            },
          ),
          const Divider(thickness: .5, color: Colors.grey),
          ListTile(
            title: const Text(
              "Configurações",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            leading: const Icon(
              Icons.settings_outlined,
              color: Colors.black87,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const Divider(thickness: .5, color: Colors.grey),
          ListTile(
            title: const Text(
              "Sair",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            onTap: () => showConfirmDialog(
              context: context,
              title: 'Sair da conta',
              text: 'Tem certeja que deseja sair?',
              confirmFunction: () => context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested()),
            ),
          ),
        ],
      ),
    );
  }
}
