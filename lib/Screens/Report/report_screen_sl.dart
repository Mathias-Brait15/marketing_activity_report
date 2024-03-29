import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Report/interaction.dart';
import 'package:kreditpensiun_apps/Screens/Report/disbursment.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_disbursment_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_interaction_sl_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_marketing_sl_screen.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class ReportScreenSl extends StatefulWidget {
  @override
  _ReportScreenSl createState() => _ReportScreenSl();

  String username;
  String nik;

  ReportScreenSl(this.username, this.nik);
}

class _ReportScreenSl extends State<ReportScreenSl> {
  @override
  Widget build(BuildContext context) {
    var date = new DateTime.now();
    String bulan = date.month.toString();
    if (bulan.length == 1) {
      bulan = '0' + bulan.toString();
    } else {
      bulan = bulan.toString();
    }
    print(bulan);
    String tgl1 = date.year.toString() + '-' + bulan + '-' + '01';
    String tgl2 = date.year.toString() + '-' + bulan + '-' + '31';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Laporan',
          style: fontFamily,
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black12,
                ))),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 0.0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReportInteractionSlScreen(
                                            widget.nik, tgl1, tgl2)));
                          },
                          child: Stack(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.report_outlined,
                                          color: Colors.black54),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Laporan Interaksi',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Regular',
                                              color: Colors.black54,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black12,
                ))),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 0.0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReportDisbursmentSlScreen(
                                            widget.nik, tgl1, tgl2)));
                          },
                          child: Stack(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.report_outlined,
                                          color: Colors.black54),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Laporan Pencairan',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Regular',
                                              color: Colors.black54,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black12,
                ))),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                          color: Colors.white,
                          padding: EdgeInsets.only(left: 0.0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ReportMarketingSlScreen(widget.nik)));
                          },
                          child: Stack(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.person_outline,
                                          color: Colors.black54),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Tim Marketing',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Regular',
                                              color: Colors.black54,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
