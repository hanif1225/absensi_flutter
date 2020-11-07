import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DataKehadiran extends StatefulWidget {
  @override
  _DataKehadiranState createState() => _DataKehadiranState();
}

class _DataKehadiranState extends State<DataKehadiran> {
  // Mengambil data dari logi dengan tipe object
  Map user = {'id': 0, 'masuk': ''};
  var total = '';
  @override
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

    kehadiran();
  }

  kehadiran() async {
    // untuk menampilkan pesan

    // ip
    final response = await http.post(
        'http://134.122.123.131:2030/datakehadiran',
        body: {'masuk': 'Hadir', 'id': user['id'].toString()});
    // mengambil respon json, atau menerjemahkan
    var responses = jsonDecode(response.body);
    print(responses.toString());
    setState(() {
      total = responses['data'];
    });
    // mengambil respon data

    // print("responses : ${response.statusCode}");
    // print('login berakhir');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/gambar4.png',
                    height: 200,
                  ),
                  Text(
                    total,
                    style:
                        TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
