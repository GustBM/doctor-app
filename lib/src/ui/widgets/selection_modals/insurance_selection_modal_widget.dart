import 'package:flutter/material.dart';
import 'package:patient_repository/patient_repository.dart';

import '../../../../utils.dart';

class InsuranceModalSelection extends StatefulWidget {
  const InsuranceModalSelection({Key? key}) : super(key: key);

  @override
  State<InsuranceModalSelection> createState() =>
      _InsuranceModalSelectionState();
}

class _InsuranceModalSelectionState extends State<InsuranceModalSelection> {
  List<Insurance> _insuranceData = [];
  List<Insurance> _allInsuranceData = [];

  @override
  void initState() {
    super.initState();
    _allInsuranceData = [
      Insurance(
          fantasyName: 'fantasyName0',
          registration: 'registration',
          expiration: DateTime.now()),
      Insurance(
          fantasyName: 'fantasyName1',
          registration: 'registration',
          expiration: DateTime.now()),
      Insurance(
          fantasyName: 'fantasyName2',
          registration: 'registration',
          expiration: DateTime.now()),
      Insurance(
          fantasyName: 'fantasyName3',
          registration: 'registration',
          expiration: DateTime.now()),
      Insurance(
          fantasyName: 'fantasyName4',
          registration: 'registration',
          expiration: DateTime.now()),
    ];
    _insuranceData = _allInsuranceData;
  }

  void _runFilter(String enteredKeyword) {
    List<Insurance> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allInsuranceData;
    } else {
      results = _allInsuranceData
          .where((insurance) => insurance.fantasyName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _insuranceData = results;
    });
  }

  Widget _buildListTile(Insurance insurance) {
    return Column(
      children: [
        ListTile(
          title: Text(
            insurance.fantasyName,
            style: TextStyle(color: Colors.lightBlue.shade400),
          ),
          onTap: () async {
            Navigator.pop(context, insurance);
          },
        ),
        listDivider,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('CONVÊNIOS'),
      ),
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
                itemCount: _insuranceData.length,
                itemBuilder: (context, index) {
                  return _buildListTile(_insuranceData[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InsuranceSelectionButton extends StatefulWidget {
  final Function(Insurance?) setInsuranceFunction;
  const InsuranceSelectionButton({Key? key, required this.setInsuranceFunction})
      : super(key: key);

  @override
  State<InsuranceSelectionButton> createState() =>
      _InsuranceSelectionButtonState();
}

class _InsuranceSelectionButtonState extends State<InsuranceSelectionButton> {
  Insurance? chosenInsurance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () async {
          chosenInsurance = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const InsuranceModalSelection()),
          );
          if (!mounted) return;
          setState(() {});
          widget.setInsuranceFunction(chosenInsurance);
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
        ),
        child: Text(
          chosenInsurance == null ? 'CONVÊNIOS' : chosenInsurance!.fantasyName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
