import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../utils.dart' show dateFormat;
import 'patient_doc_list.dart';

class PatientDocScreen extends StatelessWidget {
  const PatientDocScreen({super.key, required this.docType});

  static Route<void> route({required PatientDocType patientDocType}) {
    return MaterialPageRoute<void>(
        builder: (_) => PatientDocScreen(
              docType: patientDocType,
            ));
  }

  final PatientDocType docType;

  Text? getTitle() {
    switch (docType) {
      case PatientDocType.anamase:
        return const Text('ANAMASE');
      case PatientDocType.atestados:
        return const Text('ATESTADOS');
      case PatientDocType.diagnostico:
        return const Text('DIAGNÓSTICOS');
      case PatientDocType.exame:
        return const Text('EXAME COMPLEMENTAR');
      case PatientDocType.receituario:
        return const Text('RECEITUÁRIO');
      default:
        return null;
    }
  }

  Widget? _getPageContent() {
    switch (docType) {
      case PatientDocType.anamase:
        return Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.account_circle,
                  size: 60,
                ),
                SizedBox(width: 10),
                Text(
                  'Paciente Teste',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ],
            ),
            const Text(
                'Lorem ipsum dolor sit amet. Aut suscipit rerum aut harum laudantium aut impedit modi vel natus deleniti et sint officia sit quaerat cupiditate qui facilis inventore. Aut quasi itaque nam voluptatum vero sit enim omnis ut dolores commodi ut perferendis blanditiis.'),
          ],
        );

      case PatientDocType.atestados:
        return Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                ),
                const SizedBox(width: 10),
                Text(dateFormat.format(DateTime.now())),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'Paciente: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
                Text('Paciente Teste'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'CID: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
                Text('123456'),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Abrir'),
            )
          ],
        );

      case PatientDocType.diagnostico:
        return Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                ),
                const SizedBox(width: 10),
                Text(dateFormat.format(DateTime.now())),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'Paciente: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
                Text('Paciente Teste'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'CID: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
                Text('123456'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'Doença: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
                Text('Unha Encravada'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'Descrição: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
                Text('Melhor amputar'),
              ],
            ),
          ],
        );

      case PatientDocType.exame:
        return Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                ),
                const SizedBox(width: 10),
                Text(dateFormat.format(DateTime.now())),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'Paciente: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
                Text('Paciente Teste'),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'Discriminator: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  'Título: ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        );
      case PatientDocType.receituario:
        return SfPdfViewer.network(
          'https://araucariageneticabovina.com.br/arquivos/servico/pdfServico_57952bf8ca7af_24-07-2016_17-58-32.pdf',
        );

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _getPageContent(),
      ),
    );
  }
}
