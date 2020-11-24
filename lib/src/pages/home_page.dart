import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 30.0),
                    Text('Datos del Usuario'),
                  ],
                ),
              ),
              textColor: Colors.white,
              color: Colors.deepPurple,
              onPressed: () {
                Navigator.pushNamed(context, 'datosUsuario');
              },
            ),
          ],
        ),
      ),
    );
  }
}
