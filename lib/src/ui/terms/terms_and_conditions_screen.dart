// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:doctor247_doutor/src/models/terms.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  final String termTitle;
  final Widget? pathFoward;
  final TermsModel termsModel;

  const TermsAndConditionsScreen(
      {Key? key,
      required this.termTitle,
      this.pathFoward,
      required this.termsModel})
      : super(key: key);

  static Route<void> route(
      {required String termTitle,
      required TermsModel termsModel,
      Widget? pathFoward}) {
    return MaterialPageRoute<void>(
        builder: (_) => TermsAndConditionsScreen(
              termTitle: termTitle,
              termsModel: termsModel,
              pathFoward: pathFoward,
            ));
  }

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Theme.of(context).primaryColor;
      }
      return Theme.of(context).colorScheme.tertiary;
    }

    List<Widget> _termsText() {
      List<Widget> result = [];
      for (var term in widget.termsModel.termParagraphs) {
        result.add(
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  term.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  term.content,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        );
      }
      return result;
    }

    _redirect(Widget path) {
      Future.delayed(Duration.zero, () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => path),
        );
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.termTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.pathFoward == null
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      const Text('Aceito os Termos'),
                    ],
                  ),
            widget.pathFoward == null
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: isChecked
                        ? () {
                            _redirect(widget.pathFoward!);
                          }
                        : null,
                    child: const Text(
                      'IR PARA VIDEO-CHAMADA',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                widget.termsModel.header,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
            Column(
              children: _termsText(),
            )
          ],
        ),
      ),
    );
  }
}
