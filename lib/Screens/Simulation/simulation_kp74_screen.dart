import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_kp74_result.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_result.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../../constants.dart';

class SimulationKp74Screen extends StatefulWidget {
  @override
  _SimulationKp74ScreenState createState() => _SimulationKp74ScreenState();
}

class _SimulationKp74ScreenState extends State<SimulationKp74Screen> {
  final formKey = GlobalKey<FormState>();
  String namaPensiun;
  String gajiPensiun;
  String tanggalLahir;
  String sukuBunga;
  String angsuran;
  var selectedJangkaWaktuType;
  List<String> _jangkaWaktu = <String>[
    '12',
    '24',
    '30',
  ];

  //Getting value from TextField widget.
  final namaPensiunController = TextEditingController();
  final gajiPensiunController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final sukuBungaController = MoneyMaskedTextController(
    decimalSeparator: '.',
  );
  final angsuranController = TextEditingController();

  getDataInputan() {
    namaPensiun = namaPensiunController.text;
    gajiPensiun = gajiPensiunController.text;
    tanggalLahir = tanggalLahirController.text;
    sukuBunga = sukuBungaController.text;
    angsuran = angsuranController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pensiunan Platinum',
          style: TextStyle(fontFamily: 'Montserrat Regular'),
        ),
      ),
      body: Container(
          padding:
              EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
          child: Form(
            key: formKey,
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                namaCalonDebitur(),
                gajiCalonDebitur(),
                tanggalLahirCalonDebitur(),
                sukuBungaDebitur(),
                angsuranCalonDebitur(),
                jangkaWaktuCalonDebitur(),
                calculationButton()
              ],
            ),
          )),
    );
  }

  Widget namaCalonDebitur() {
    return TextFormField(
      controller: namaPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Nama lengkap wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Nama Lengkap",
          hintStyle: TextStyle(fontFamily: 'Montserrat Regular'),
          labelText: "Nama Lengkap"),
      textCapitalization: TextCapitalization.characters,
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget gajiCalonDebitur() {
    return TextFormField(
      controller: gajiPensiunController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Gaji terakhir wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Gaji Terakhir",
          hintStyle: TextStyle(fontFamily: 'Montserrat Regular'),
          labelText: "Gaji Terakhir"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget tanggalLahirCalonDebitur() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
        controller: tanggalLahirController,
        validator: (DateTime dateTime) {
          if (dateTime == null) {
            return 'Tanggal lahir wajib diisi...';
          }
          return null;
        },
        decoration: InputDecoration(
            //Add th Hint text here.
            hintText: "Tanggal Lahir",
            hintStyle: TextStyle(fontFamily: 'Montserrat Regular'),
            labelText: "Tanggal Lahir"),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
        style: TextStyle(fontFamily: 'Montserrat Regular'),
      ),
    ]);
  }

  Widget sukuBungaDebitur() {
    return TextFormField(
      controller: sukuBungaController,
      validator: (value) {
        if (value.isEmpty) {
          return 'Suku Bunga wajib diisi...';
        }
        return null;
      },
      decoration: InputDecoration(
          //Add th Hint text here.
          hintText: "Suku Bunga",
          hintStyle: TextStyle(fontFamily: 'Montserrat Regular'),
          labelText: "Suku Bunga"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget angsuranCalonDebitur() {
    return TextFormField(
      controller: angsuranController,
      decoration: InputDecoration(
        labelText: 'Angsuran per Bulan',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      style: TextStyle(fontFamily: 'Montserrat Regular'),
    );
  }

  Widget jangkaWaktuCalonDebitur() {
    return DropdownButtonFormField(
      items: _jangkaWaktu
          .map((value) => DropdownMenuItem(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Montserrat Regular',
                  ),
                ),
                value: value,
              ))
          .toList(),
      onChanged: (selectedJangkaWaktu) {
        setState(() {
          selectedJangkaWaktuType = selectedJangkaWaktu;
        });
      },
      decoration: InputDecoration(
          labelText: 'Jangka Waktu (bulan)',
          contentPadding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          labelStyle: TextStyle(
            fontFamily: 'Montserrat Regular',
          )),
      value: selectedJangkaWaktuType,
      isExpanded: true,
    );
  }

  Widget calculationButton() {
    //MEMBUAT TOMBOL SUBMIT
    return SizedBox(
      width: double.infinity,
      child: FlatButton(
        color: kPrimaryColor, //MENGATUR WARNA TOMBOL
        onPressed: () {
          if (formKey.currentState.validate()) {
            setState(() {
              getDataInputan();
            });

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SimulationKp74Result(
                        namaPensiun,
                        gajiPensiun,
                        tanggalLahir,
                        sukuBunga,
                        angsuran,
                        selectedJangkaWaktuType))).then((result) {});
          }
        },
        child: Text(
          'Hitung',
          style:
              TextStyle(color: Colors.white, fontFamily: 'Montserrat Regular'),
        ),
      ),
    );
  }
}
