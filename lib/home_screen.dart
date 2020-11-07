import 'dart:convert';

import 'package:absensi_fix/data_hariini.dart';
import 'package:absensi_fix/data_kehadiran.dart';
import 'package:absensi_fix/login_page.dart';
import 'package:absensi_fix/scan_absen.dart';
import 'package:flutter/material.dart';
//header untuk berbagi data
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
//variabel global
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // Mengambil data dari logi dengan tipe object
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

  Widget iconavatar() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(
                  'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png'),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: 16,
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  //menampilkan data
                  user['username'],
                  style: TextStyle(
                      fontFamily: 'Montserrat Medium',
                      color: Colors.white,
                      fontSize: 20),
                ),
                Text(
                  '1706133',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: "Montserrat Regular"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // to get size
    var size = MediaQuery.of(context).size;
    // style
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return new WillPopScope(
      onWillPop: () async => false,
      //scaffold
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/top_header.png')),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    //iconavatar
                    iconavatar(),
                    Expanded(
                      child: GridView.count(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          primary: false,
                          //card
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Scanabsen();
                                  },
                                ));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/gambar1.png',
                                      height: 100,
                                    ),
                                    Text(
                                      'Scan Absen QR',
                                      style: cardTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //data kehadiran
                            InkWell(
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DataKehadiran();
                                  },
                                ));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/gambar2.png',
                                      height: 120,
                                    ),
                                    Text(
                                      'Data Kehadiran',
                                      style: cardTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DataHariini();
                                  },
                                ));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/gambar3.png',
                                      height: 100,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'List Kehadiran',
                                          style: cardTextStyle,
                                        ),
                                        Text(
                                          'Hari Ini',
                                          style: cardTextStyle,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setString('user', '');
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login_Page()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                elevation: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.launch,
                                      size: 80,
                                    ),
                                    Text(
                                      'Logout',
                                      style: cardTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            )

                            // Card(
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8)),
                            //   elevation: 4,
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: <Widget>[
                            //       SvgPicture.network(
                            //         'https://image.flaticon.com/icons/svg/1904/1904425.svg',
                            //         height: 128,
                            //       ),
                            //       Text(
                            //         'Personal Data',
                            //         style: cardTextStyle,
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                          crossAxisCount: 2),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
