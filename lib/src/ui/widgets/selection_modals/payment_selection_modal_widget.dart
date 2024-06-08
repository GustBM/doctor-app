import 'package:flutter/material.dart';

import 'package:doctor247_doutor/utils.dart';

class PaymentModalSelection extends StatefulWidget {
  const PaymentModalSelection({Key? key}) : super(key: key);

  @override
  State<PaymentModalSelection> createState() => _PaymentModalSelectionState();
}

class _PaymentModalSelectionState extends State<PaymentModalSelection> {
  List<String> _payments = [];
  List<String> _allPayments = [];

  @override
  void initState() {
    super.initState();
    _allPayments = [
      'PAGAMENTO 1',
      'PAGAMENTO 2',
      'PAGAMENTO 3',
      'PAGAMENTO 4',
      'PAGAMENTO 5',
    ];
    _payments = _allPayments;
  }

  void _runFilter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allPayments;
    } else {
      results = _allPayments
          .where((payment) =>
              payment.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _allPayments = results;
    });
  }

  Widget _buildListTile(String payment) {
    return Column(
      children: [
        ListTile(
          title: Text(
            payment,
            style: TextStyle(color: Colors.lightBlue.shade400),
          ),
          onTap: () async {
            Navigator.pop(context, payment);
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
        title: const Text('PAGAMENTOS'),
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
                itemCount: _payments.length,
                itemBuilder: (context, index) {
                  return _buildListTile(_payments[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentSelectionButton extends StatefulWidget {
  final Function(String?) setPaymentFunction;

  const PaymentSelectionButton({Key? key, required this.setPaymentFunction})
      : super(key: key);

  @override
  State<PaymentSelectionButton> createState() => _PaymentSelectionButtonState();
}

class _PaymentSelectionButtonState extends State<PaymentSelectionButton> {
  String? chosenPayment;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: () async {
        chosenPayment = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PaymentModalSelection()),
        );
        if (!mounted) return;
        setState(() {});
        widget.setPaymentFunction(chosenPayment);
      },
      child: Text(
        chosenPayment == null ? 'SELECIONE A PAGAMENTO' : chosenPayment!,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
