import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Scanabsen extends StatefulWidget {
  @override
  _ScanabsenState createState() => _ScanabsenState();
}

class _ScanabsenState extends State<Scanabsen> {
  String _counter, _value = "";
  String hasil = "";
  Future _incrementCounter() async {
    String cameraScanResult = await scanner.scan();
    scandata(cameraScanResult);
    setState(() {
      hasil = cameraScanResult;
    });
  }

//mengambil data user
  Map user = {'id': 0, 'username': '', 'password': ''};

//sebelum buat initstate buat override
  @override
  //menyimpan data ke variabel global
  void initState() {
    super.initState();
    getUser();
  }

  //menangkap data dari login dengan sharedpreferences
  getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var datauser = pref.getString('user');
    setState(() {
      //menerjemahkan data json
      user = jsonDecode(datauser);
    });
  }

//batas
  scandata(masuk) async {
    // untuk menampilkan pesan
    print('Login dieksekusi');
    // ip
    final response = await http.post(
        'http://134.122.123.131:2030/createIsidb_absensi',
        body: {'masuk': masuk, 'id': user['id'].toString()});
    // mengambil respon json, atau menerjemahkan
    var responses = jsonDecode(response.body);
    // mengambil respon data

    // print("responses : ${response.statusCode}");
    // print('login berakhir');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              hasil,
            ),
            Text(
              _value,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.settings_overscan),
      ),
    );
  }
}
