import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List clientes = [];

  @override
  void initState() {
    super.initState();
    fetchClientes();
  }

  fetchClientes() async {
    final response =
        await http.get(Uri.parse('http://localhost/RUTAS_PHP-1/'));

    if (response.statusCode == 200) {
      setState(() {
        clientes = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load clients');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
      ),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                '${clientes[index]['nombres']} ${clientes[index]['apellidos']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Teléfono: ${clientes[index]['telefono']}'),
                Text('Correo: ${clientes[index]['correo']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
