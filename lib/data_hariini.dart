import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataHariini extends StatefulWidget {
  @override
  _DataHariiniState createState() => _DataHariiniState();
}

class _DataHariiniState extends State<DataHariini> {
  // Mengambil data dari logi dengan tipe object
  Map user = {'masuk': '', 'nama': ''};
  //melakukan looping data
  List kehadiran = [];
  Widget list(item) {
    return new Container(
      padding: new EdgeInsets.all(10.0),
      child: new Card(
          child: new Column(
        children: <Widget>[
          new Icon(
            Icons.verified_user_sharp,
            size: 50.0,
            color: Colors.orange,
          ),
          new Text(
            item['nama'] + ' : ' + item['masuk'],
            style: new TextStyle(fontSize: 20.0),
          )
        ],
      )),
    );
  }

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

    kehadiranhariini();
  }

  kehadiranhariini() async {
    // untuk menampilkan pesan

    // ip
    final response = await http.post(
        'http://134.122.123.131:2030/hariini_absensi',
        body: {'masuk': 'Hadir'});
    // mengambil respon json, atau menerjemahkan
    var responses = jsonDecode(response.body);
    setState(() {
      kehadiran = jsonDecode(responses['data']);
    });

    // mengambil respon data
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Hari Ini"),
      ),
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: kehadiran.map((item) => list(item)).toList(),
        ),
      ),
    );
  }
}
