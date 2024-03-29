import 'package:flutter/material.dart';
import 'package:kreditpensiun_apps/Screens/Profile/address_data_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/bank_account_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/employee_data_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/income_data_screen.dart';
import 'package:kreditpensiun_apps/Screens/Profile/personal_data_screen.dart';

class ProfileScreen extends StatefulWidget {
  List personalData;
  ProfileScreen(this.personalData);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profil',
            style: TextStyle(fontFamily: 'Montserrat Regular'),
          ),
        ),
        body: Container(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 0.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PersonalDataScreen(widget.personalData)));
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.person, color: Colors.black54),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Pribadi',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 16.0,
                                        color: Colors.black54),
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
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 0.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddressDataScreen(widget.personalData)));
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.home,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Alamat',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 16.0,
                                        color: Colors.black54),
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
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 0.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BankAccountDataScreen(widget.personalData)));
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.credit_card,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Rekening',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 16.0,
                                        color: Colors.black54),
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
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 0.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EmployeeDataScreen(widget.personalData)));
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person_outline,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Karyawan',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 16.0,
                                        color: Colors.black54),
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
                    ),
                  )),
              Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.black12,
                  ))),
                  child: FlatButton(
                    padding: EdgeInsets.only(left: 0.0),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  IncomeDataScreen(widget.personalData)));
                    },
                    child: Stack(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    'Pendapatan',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat Regular',
                                        fontSize: 16.0,
                                        color: Colors.black54),
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
                    ),
                  )),
            ],
          ),
        ));
  }
}
