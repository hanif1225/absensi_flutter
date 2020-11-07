import 'dart:convert';

import 'package:absensi_fix/Animation/FadeAnimation.dart';
import 'package:absensi_fix/home_screen.dart';
import 'package:flutter/material.dart';
//header api
import 'package:http/http.dart' as http;
//header untuk berbagi data
import 'package:shared_preferences/shared_preferences.dart';

class Login_Page extends StatefulWidget {
  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  // rumus untuk inputan
  TextEditingController _inputusername = TextEditingController();
  TextEditingController _inputpassword = TextEditingController();
  // fungsi login
  login() async {
    // untuk menampilkan pesan
    print('Login dieksekusi');
    // ip
    final response =
        await http.post('http://134.122.123.131:2030/loginUser', body: {
      'username': _inputusername.text,
      'password': _inputpassword.text,
    });
    // mengambil respon json, atau menerjemahkan
    var responses = jsonDecode(response.body);
    // mengambil respon data
    String data = responses['data'];
    print('Message : $data');
    // untuk menerjemahkan json ke variabel
    var mlogin = jsonDecode(data); //
    if (mlogin.length > 0) {
      // Map (objek) tipe data, dimulai dari array 0 untuk mengambil data array 0
      Map user = mlogin[0];
      var user2 = jsonEncode(user); // mengubah variabel ke bentuk json
      print(user2); // menampilkan data user 2 untuk di kirim ke homescreen
      final SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('user', user2); // session data, menyimpan data ke lokal

      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Homescreen();
        },
      ));
    }
    // print("responses : ${response.statusCode}");
    // print('login berakhir');
  }

  Widget background_atas() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeAnimation(
                5,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/light-1.png'))),
                )),
          ),
          Positioned(
            left: 140,
            width: 80,
            height: 150,
            child: FadeAnimation(
                5,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/light-2.png'))),
                )),
          ),
          Positioned(
            right: 40,
            width: 60,
            height: 150,
            child: FadeAnimation(
                5,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/clock.png'))),
                )),
          ),
          Positioned(
            child: FadeAnimation(
                5,
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget input_username() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[100]))),
      child: TextField(
        controller: _inputusername,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Username",
            hintStyle: TextStyle(color: Colors.green[400])),
      ),
    );
  }

  Widget input_password() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: _inputpassword,
        obscureText: true,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.green[400])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //scaffold
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              background_atas(),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      5,
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, 2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              input_username(),
                              input_password(),
                              SizedBox(
                                height: 30,
                              ),
                              FadeAnimation(
                                5,
                                RaisedButton(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  onPressed: () {
                                    login();
                                  },
                                  //  Navigator.push(context,
                                  //       MaterialPageRoute(builder: (context) {
                                  //     return Homescreen();
                                  //   }
                                  //   )
                                  //   );
                                  // },
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              FadeAnimation(
                                  5,
                                  Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(143, 148, 251, 1)),
                                  )),
                            ],
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
