import 'package:flutter/material.dart';

class SquareMenuGrid extends StatelessWidget {
  const SquareMenuGrid({
    Key? key,
    required this.title,
    required this.icon,
    required this.function,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        //margin: const EdgeInsets.all(4.0),
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
