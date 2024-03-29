import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_add.dart';
import 'package:kreditpensiun_apps/Screens/Interaction/interaction_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_add_screen.dart';
import 'package:kreditpensiun_apps/Screens/Planning/planning_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/planning_interaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:toast/toast.dart';

import '../../constants.dart';

// ignore: must_be_immutable
class PlanningInteractionScreen extends StatefulWidget {
  @override
  _PlanningInteractionScreen createState() => _PlanningInteractionScreen();

  String username;
  String nik;
  String hakAkses;

  PlanningInteractionScreen(this.username, this.nik, this.hakAkses);
}

class _PlanningInteractionScreen extends State<PlanningInteractionScreen> {
  bool visible = false;
  bool _isLoading = false;
  final String apiUrl =
      'https://www.nabasa.co.id/api_marsit_v1/index.php/getPlanningInteraction';
  List<dynamic> _users = [];

  void fetchUsers() async {
    setState(() {
      _isLoading = true;
    });
    var result = await http.post(apiUrl, body: {'nik_sales': widget.nik});
    if (result.statusCode == 200) {
      setState(() {
        if (json.decode(result.body)['Daftar_Planning'] == '') {
          _isLoading = false;
        } else {
          _users = json.decode(result.body)['Daftar_Planning'];
          _isLoading = false;
        }
      });
    }
  }

  String _id(dynamic user) {
    return user['id'];
  }

  String _nopen(dynamic user) {
    return user['nopen'];
  }

  String _nama(dynamic user) {
    return user['namapensiunan'];
  }

  String _tglLahir(dynamic user) {
    return user['tgl_lahir_pensiunan'];
  }

  String _gajiPokok(dynamic user) {
    return user['penpok'];
  }

  String _alamat(dynamic user) {
    return user['alm_peserta'];
  }

  String _kelurahan(dynamic user) {
    return user['kelurahan'];
  }

  String _kecamatan(dynamic user) {
    return user['kecamatan'];
  }

  String _kabupaten(dynamic user) {
    return user['kota_kab'];
  }

  String _provinsi(dynamic user) {
    return user['provinsi'];
  }

  String _kodepos(dynamic user) {
    return user['kodepos'];
  }

  String _namaKantor(dynamic user) {
    return user['nmkanbyr'];
  }

  String _tmtPensiun(dynamic user) {
    return user['tmtpensiun'];
  }

  String _penerbitSkep(dynamic user) {
    return user['penerbit_skep'];
  }

  String _telepon(dynamic user) {
    return user['telepon'];
  }

  String _visitStatus(dynamic user) {
    return user['visit_status'];
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();

    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Rencana Interaksi',
          style: fontFamily,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InteractionScreen(
                            widget.username, widget.nik, widget.hakAkses)));
              },
              child: Tooltip(
                message: 'Daftar Interaksi Periode $bulan $tahun',
                child: Icon(Icons.directions_walk),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: _buildList(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah rencana interaksi hari ini',
        backgroundColor: kPrimaryColor,
        child: Text('+',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PlanningAddScreen(widget.username, widget.nik)));
        },
      ),
    );
  }

  Widget _buildList() {
    var date = new DateTime.now();
    String bulan = namaBulan(date.month.toString());
    String tahun = date.year.toString();
    String hari = date.day.toString();
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    if (_isLoading == true) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (_users.length > 0) {
        return RefreshIndicator(
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.date_range, size: 50),
                    title: Text(
                      'Jadwal Interaksi Hari ini $hari-$bulan-$tahun',
                      style: cardTextStyle,
                    ),
                    subtitle: Text('Selamat bekerja, sukses selalu'),
                  ),
                ]),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (_visitStatus(_users[index]) == null ||
                              _visitStatus(_users[index]) == '') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InteractionAddScreen(
                                        widget.username,
                                        widget.nik,
                                        _nama(_users[index]),
                                        _alamat(_users[index]),
                                        '',
                                        _telepon(_users[index]),
                                        'Database ',
                                        _kelurahan(_users[index]),
                                        _kecamatan(_users[index]),
                                        _provinsi(_users[index]),
                                        _kabupaten(_users[index]),
                                        _nopen(_users[index]))));
                          } else {
                            Toast.show(
                              'Maaf, nasabah sudah di interaksi...',
                              context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              _nama(_users[index]),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat Regular'),
                            ),
                            subtitle: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'Notas',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Regular',
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _nopen(_users[index]),
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Regular'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          'Status',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Regular',
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      messageStatus(
                                        _visitStatus(_users[index]),
                                      ),
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Regular'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Wrap(
                              spacing: 12,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (_visitStatus(_users[index]) == null ||
                                        _visitStatus(_users[index]) == '') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(
                                              'Apakah data ini tidak valid ?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Tidak'),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                updatedRencanaInteraksi(
                                                    _id(_users[index]),
                                                    _nopen(_users[index]),
                                                    widget.nik);
                                              },
                                              child: Text('Ya'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      Toast.show(
                                        'Maaf, nasabah sudah di interaksi...',
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.not_interested_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_visitStatus(_users[index]) == null ||
                                        _visitStatus(_users[index]) == '') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Text(
                                              'Apakah Anda ingin menghapus rencana interaksi ini ?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Tidak'),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                deleteRencanaInteraksi(
                                                    _id(_users[index]),
                                                    _nopen(_users[index]));
                                              },
                                              child: Text('Ya'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      Toast.show(
                                        'Maaf, nasabah sudah di interaksi...',
                                        context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          onRefresh: _getData,
        );
      } else {
        return Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.person_add_outlined, size: 70),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Rencanain Interaksi Kamu Yuk!',
              style: TextStyle(
                  fontFamily: "Montserrat Regular",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Dapatkan kemudahan di setiap tempat favoritmu.',
              style: TextStyle(
                fontFamily: "Montserrat Regular",
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlanningScreen(widget.username, widget.nik)));
              },
              child: Text(
                'Lihat Database',
                style: TextStyle(
                  fontFamily: "Montserrat Regular",
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        );
      }
    }
  }

  messageStatus(String status) {
    if (status == '' || status == null) {
      return 'Belum di interaksi';
    } else if (status == 'valid') {
      return 'Sudah di interaksi';
    } else if (status == 'not_valid') {
      return 'Data tidak valid';
    }
  }

  iconStatus(String status) {
    if (status == '' || status == 'null') {
      return Icons.info;
    } else if (status == 'valid') {
      return Icons.check;
    } else if (status == 'not_valid') {
      return Icons.cancel;
    }
  }

  colorStatus(String status) {
    if (status == '' || status == 'null') {
      return Colors.blue;
    } else if (status == 'valid') {
      return Colors.green;
    } else if (status == 'not_valid') {
      return Colors.red;
    }
  }

  namaBulan(String bulan) {
    switch (bulan) {
      case '1':
        return 'Januari';
        break;
      case '2':
        return 'Februari';
        break;
      case '3':
        return 'Maret';
        break;
      case '4':
        return 'April';
        break;
      case '5':
        return 'Mei';
        break;
      case '6':
        return 'Juni';
        break;
      case '7':
        return 'Juli';
        break;
      case '8':
        return 'Agustus';
        break;
      case '9':
        return 'September';
        break;
      case '10':
        return 'Oktober';
        break;
      case '11':
        return 'November';
        break;
      case '12':
        return 'Desember';
        break;
    }
  }

  formatRupiah(String a) {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: double.parse(a),
        settings: MoneyFormatterSettings(
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
    return 'IDR ' + fmf.output.withoutFractionDigits;
  }

  Future deleteRencanaInteraksi(String id, String notas) async {
    //showing CircularProgressIndicator
    print(id);
    setState(() {
      visible = true;
    });
    //server save api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/deleteRencanaInteraksi';
    var response = await http.post(url, body: {'id': id, 'notas': notas});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Delete_Rencana_Interaksi'];
      if (message.toString() == 'Delete Success') {
        setState(() {
          visible = false;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PlanningInteractionScreen(
                widget.username, widget.nik, widget.hakAkses)));
        Toast.show(
          'Sukses delete rencana interaksi...',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal delete rencana interaksi...',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future updatedRencanaInteraksi(
      String id, String notas, String niksales) async {
    //showing CircularProgressIndicator
    print(id);
    setState(() {
      visible = true;
    });
    //server save api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/updatedRencanaInteraksi';
    var response = await http
        .post(url, body: {'id': id, 'notas': notas, 'niksales': niksales});

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Update_Rencana_Interaksi'];
      if (message.toString() == 'Update Success') {
        setState(() {
          visible = false;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PlanningInteractionScreen(
                widget.username, widget.nik, widget.hakAkses)));
        Toast.show(
          'Sukses update not valid rencana interaksi...',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Gagal update not valid rencana interaksi...',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }
}
