import 'package:flutter/material.dart';

class RegistroContable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Añadir registro',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
