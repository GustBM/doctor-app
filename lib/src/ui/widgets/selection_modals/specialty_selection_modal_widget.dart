import 'package:doctor247_doutor/utils.dart';
import 'package:flutter/material.dart';
import 'package:medic_repository/medic_repository.dart';

class SpecialtyModalSelection extends StatefulWidget {
  const SpecialtyModalSelection({Key? key}) : super(key: key);

  @override
  State<SpecialtyModalSelection> createState() =>
      _SpecialtyModalSelectionState();
}

class _SpecialtyModalSelectionState extends State<SpecialtyModalSelection> {
  List<Specialty> _specialtiesData = [];
  List<Specialty> _allSpecialtiesData = [];

  @override
  void initState() {
    super.initState();
    _allSpecialtiesData = const [
      Specialty(id: '1', name: 'Specialty 1'),
      Specialty(id: '1', name: 'Specialty 1'),
      Specialty(id: '1', name: 'Specialty 1'),
      Specialty(id: '1', name: 'Specialty 1'),
    ];
    _specialtiesData = _allSpecialtiesData;
  }

  void _runFilter(String enteredKeyword) {
    List<Specialty> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allSpecialtiesData;
    } else {
      results = _allSpecialtiesData
          .where((specialty) => specialty.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _specialtiesData = results;
    });
  }

  Widget _buildListTile(Specialty specialty) {
    return Column(
      children: [
        ListTile(
          title: Text(
            specialty.name,
            style: TextStyle(color: Colors.lightBlue.shade400),
          ),
          onTap: () async {
            Navigator.pop(context, specialty);
          },
        ),
        listDivider,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESPECIALIDADES'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: 'Buscar',
                labelStyle: const TextStyle(color: Colors.black54),
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                filled: true,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _specialtiesData.length,
                itemBuilder: (context, index) {
                  return _buildListTile(_specialtiesData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecialtySelectionButton extends StatefulWidget {
  final Function(Specialty?) setSpecialtyFunction;

  const SpecialtySelectionButton({Key? key, required this.setSpecialtyFunction})
      : super(key: key);

  @override
  State<SpecialtySelectionButton> createState() =>
      _SpecialtySelectionButtonState();
}

class _SpecialtySelectionButtonState extends State<SpecialtySelectionButton> {
  Specialty? chosenSpecialty;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      onPressed: () async {
        chosenSpecialty = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SpecialtyModalSelection()),
        );
        if (!mounted) return;
        setState(() {});
        widget.setSpecialtyFunction(chosenSpecialty);
      },
      child: Text(
        chosenSpecialty == null
            ? 'SELECIONE A ESPECIALIDADE'
            : chosenSpecialty!.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
