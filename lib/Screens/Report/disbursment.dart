import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_view_screen.dart';
import 'package:kreditpensiun_apps/Screens/Report/report_disbursment_screen.dart';
import 'package:kreditpensiun_apps/Screens/provider/report_disbursment_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../constants.dart';
import 'filter_disbursment_screen.dart';

// ignore: must_be_immutable
class ReportDisbursmentScreen extends StatefulWidget {
  @override
  _ReportDisbursmentScreen createState() => _ReportDisbursmentScreen();

  String nik;
  String tglAwal;
  String tglAkhir;

  ReportDisbursmentScreen(this.nik, this.tglAwal, this.tglAkhir);
}

class _ReportDisbursmentScreen extends State<ReportDisbursmentScreen> {
  @override
  Widget build(BuildContext context) {
    String calonDebitur;
    String rencanaPinjaman;
    String alamat;
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1),
        fontWeight: FontWeight.bold);
    var cardTextStyleChild = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 13,
        color: Colors.red,
        fontWeight: FontWeight.bold);
    var cardTextStyleFooter1 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 12,
        color: Color.fromRGBO(63, 63, 63, 1));
    var cardTextStyleFooter2 = TextStyle(
        fontFamily: "Montserrat Regular",
        fontSize: 9,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        title: Text(
          'Laporan Pencairan',
          style: fontFamily,
        ),
        actions: <Widget>[
          // Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: () async {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => ReportDisbursmentPdfScreen()));
          //       },
          //       child: Icon(
          //         Icons.picture_as_pdf,
          //         size: 26.0,
          //       ),
          //     )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FilterDisbursmentScreen(widget.nik)));
                },
                child: Icon(Icons.filter_list),
              )),
        ],
      ),
      //ADAPUN UNTUK LOOPING DATA PEGAWAI, KITA GUNAKAN LISTVIEW BUILDER
      //KARENA WIDGET INI SUDAH DILENGKAPI DENGAN FITUR SCROLLING
      body: RefreshIndicator(
          onRefresh: () =>
              Provider.of<ReportDisbursmentProvider>(context, listen: false)
                  .getDisbursmentReport(ReportDisbursmentItem(
                      widget.nik, widget.tglAwal, widget.tglAkhir)),
          color: Colors.red,
          child: Container(
            margin: EdgeInsets.all(10),
            child: FutureBuilder(
              future:
                  Provider.of<ReportDisbursmentProvider>(context, listen: false)
                      .getDisbursmentReport(ReportDisbursmentItem(
                          widget.nik, widget.tglAwal, widget.tglAkhir)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                  );
                }
                return Consumer<ReportDisbursmentProvider>(
                  builder: (context, data, _) {
                    print(data.dataDisbursmentReport.length);
                    if (data.dataDisbursmentReport.length == 0) {
                      return Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(Icons.hourglass_empty_outlined,
                                        size: 70),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Pencairan Tidak Ditemukan!',
                                style: TextStyle(
                                    fontFamily: "Montserrat Regular",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                      );
                    } else {
                      return GridView.builder(
                          itemCount: data.dataDisbursmentReport.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, i) {
                            if (data.dataDisbursmentReport[i].debitur.length >
                                15) {
                              calonDebitur = data
                                  .dataDisbursmentReport[i].debitur
                                  .substring(0, 15);
                            } else {
                              calonDebitur =
                                  data.dataDisbursmentReport[i].debitur;
                            }

                            if (data.dataDisbursmentReport[i].plafond != '') {
                              if (data.dataDisbursmentReport[i].plafond.length >
                                  15) {
                                rencanaPinjaman = data
                                    .dataDisbursmentReport[i].plafond
                                    .substring(0, 15);
                              } else {
                                rencanaPinjaman =
                                    data.dataDisbursmentReport[i].plafond;
                              }
                            } else {
                              rencanaPinjaman = '';
                            }

                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          DisbursmentViewScreen(
                                              data.dataDisbursmentReport[i]
                                                  .debitur,
                                              data.dataDisbursmentReport[i]
                                                  .alamat,
                                              data.dataDisbursmentReport[i]
                                                  .telepon,
                                              data.dataDisbursmentReport[i]
                                                  .tanggalAkad,
                                              data.dataDisbursmentReport[i]
                                                  .nomorAkad,
                                              data.dataDisbursmentReport[i]
                                                  .noJanji,
                                              data.dataDisbursmentReport[i]
                                                  .plafond,
                                              data.dataDisbursmentReport[i]
                                                  .jenisPencairan,
                                              data.dataDisbursmentReport[i]
                                                  .jenisProduk,
                                              data.dataDisbursmentReport[i]
                                                  .cabang,
                                              data.dataDisbursmentReport[i]
                                                  .infoSales,
                                              data.dataDisbursmentReport[i]
                                                  .foto1,
                                              data.dataDisbursmentReport[i]
                                                  .foto2,
                                              data.dataDisbursmentReport[i]
                                                  .foto3,
                                              data.dataDisbursmentReport[i]
                                                  .tanggalPencairan,
                                              data.dataDisbursmentReport[i]
                                                  .jamPencairan,
                                              data.dataDisbursmentReport[i]
                                                  .namaTl,
                                              data.dataDisbursmentReport[i]
                                                  .jabatanTl,
                                              data.dataDisbursmentReport[i]
                                                  .teleponTl,
                                              data.dataDisbursmentReport[i]
                                                  .namaSales,
                                              data.dataDisbursmentReport[i]
                                                  .cabang,
                                              data.dataDisbursmentReport[i]
                                                  .infoSales,
                                              data.dataDisbursmentReport[i]
                                                  .statusPipeline,
                                              data.dataDisbursmentReport[i]
                                                  .statusKredit,
                                              data.dataDisbursmentReport[i]
                                                  .pengelolaPensiun,
                                              data.dataDisbursmentReport[i]
                                                  .bankTakeover,
                                              data.dataDisbursmentReport[i]
                                                  .tanggalPenyerahan,
                                              data.dataDisbursmentReport[i]
                                                  .namaPenerima,
                                              data.dataDisbursmentReport[i]
                                                  .teleponPenerima,
                                              data.dataDisbursmentReport[i]
                                                  .tanggalPipeline,
                                              data.dataDisbursmentReport[i]
                                                  .tempatLahir,
                                              data.dataDisbursmentReport[i]
                                                  .tanggalLahir,
                                              data.dataDisbursmentReport[i]
                                                  .jenisKelamin,
                                              data.dataDisbursmentReport[i]
                                                  .noKtp,
                                              data.dataDisbursmentReport[i]
                                                  .npwp,
                                              data.dataDisbursmentReport[i]
                                                  .kodeProduk)));
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: Image.network(
                                          'https://www.nabasa.co.id/marsit/${data.dataDisbursmentReport[i].foto1}',
                                          fit: BoxFit.contain,
                                        ),
                                        height: 100.0,
                                        width: double.infinity,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '$calonDebitur',
                                            style: cardTextStyle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${formatRupiah(rencanaPinjaman)}',
                                            style: cardTextStyleChild,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '${data.dataDisbursmentReport[i].tanggalPencairan}',
                                            style: cardTextStyleFooter1,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 5.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.location_on,
                                                  color: kPrimaryColor),
                                              Expanded(
                                                child: Text(
                                                  '${data.dataDisbursmentReport[i].cabang}',
                                                  style: cardTextStyleFooter2,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ]),
                              ),
                            );
                          });
                    }
                  },
                );
              },
            ),
          )),
    );
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
}
