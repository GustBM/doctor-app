import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'pacient_doc_screen.dart';
import 'package:flutter/material.dart';

import 'package:doctor247_doutor/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum PatientDocType { anamase, atestados, diagnostico, exame, receituario }

class PatientDocList extends StatelessWidget {
  PatientDocList({super.key, required this.docType});

  static Route<void> route({required PatientDocType patientDocType}) {
    return MaterialPageRoute<void>(
        builder: (_) => PatientDocList(
              docType: patientDocType,
            ));
  }

  final PatientDocType docType;

  final titles = [
    getRandomNumber().toString(),
    getRandomNumber().toString(),
    getRandomNumber().toString(),
    getRandomNumber().toString(),
  ];

  Text? getTitle() {
    switch (docType) {
      case PatientDocType.anamase:
        return const Text('ANAMASE');
      case PatientDocType.atestados:
        return const Text('ATESTADOS');
      case PatientDocType.diagnostico:
        return const Text('DIAGNÓSTICO');
      case PatientDocType.exame:
        return const Text('EXAMES');
      case PatientDocType.receituario:
        return const Text('RECEITUÁRIO');
      default:
        return null;
    }
  }

  Container? _createCard(int index) {
    switch (docType) {
      case PatientDocType.anamase:
        return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titles[index],
                style: const TextStyle(fontSize: 16),
              ),
              Text(dateFormat.format(DateTime.now()),
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF02959B))),
              const Icon(Icons.attach_file_outlined),
            ],
          ),
        );

      case PatientDocType.atestados:
        return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titles[index],
                style: const TextStyle(fontSize: 16),
              ),
              Text(dateFormat.format(DateTime.now()),
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF02959B))),
              const Icon(Icons.attach_file_outlined),
            ],
          ),
        );

      case PatientDocType.diagnostico:
        return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titles[index],
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.attach_file_outlined),
            ],
          ),
        );

      case PatientDocType.exame:
        return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titles[index],
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.attach_file_outlined),
            ],
          ),
        );

      case PatientDocType.receituario:
        return Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titles[index],
                style: const TextStyle(fontSize: 16),
              ),
              Text('Expedida em ${dateFormat.format(DateTime.now())}',
                  style:
                      const TextStyle(fontSize: 16, color: Color(0xFF02959B))),
              const Icon(Icons.attach_file_outlined),
            ],
          ),
        );

      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    var maskFormatter = MaskTextInputFormatter(
        mask: 'xx/xx/xxxx',
        filter: {"x": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(PatientDocScreen.route(patientDocType: docType));
                },
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _createCard(index),
                ),
              ),
            );
          }),
      floatingActionButton: docType == PatientDocType.exame
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return PatientNewExamForm(
                          formKey: formKey, maskFormatter: maskFormatter);
                    });
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

class PatientNewExamForm extends StatefulWidget {
  const PatientNewExamForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.maskFormatter,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final MaskTextInputFormatter maskFormatter;

  @override
  State<PatientNewExamForm> createState() => _PatientNewExamFormState();
}

class _PatientNewExamFormState extends State<PatientNewExamForm> {
  File? imageFile;

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Form(
            key: widget._formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextFormField(
                      inputFormatters: [widget.maskFormatter],
                      keyboardType: TextInputType.datetime,
                      decoration: const InputDecoration(
                          labelText: 'Data do Exame',
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.calendar_month)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo não pode estar vazio.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Título',
                          labelStyle: TextStyle(color: Colors.black),
                          icon: Icon(Icons.text_snippet)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo não pode estar vazio.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: GestureDetector(
                      onTap: _getFromGallery,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.cloud_upload_outlined),
                          title: imageFile == null
                              ? const Text('Anexar Imagem')
                              : SizedBox(
                                  child: Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fechar'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          child: const Text('Salvar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
