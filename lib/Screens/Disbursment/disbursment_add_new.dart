import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_akad_screen.dart';
import 'package:kreditpensiun_apps/Screens/Disbursment/disbursment_screen.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page.dart';
import 'package:kreditpensiun_apps/Screens/Landing/landing_page_mr.dart';
import 'package:kreditpensiun_apps/Screens/models/image_upload_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:kreditpensiun_apps/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

// ignore: must_be_immutable
class DisbursmentAddNewScreen extends StatefulWidget {
  String username;
  String nik;
  String nama;
  String namaPensiun;
  String alamat;
  String telepon;
  String selectedJenisDebitur;
  String selectedJenisProduk;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String selectedJenisCabang;
  String plafond;
  String selectedJenisInfo;
  String selectedStatusKredit;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String selectedPengelolaPensiun;
  String idPipeline;

  DisbursmentAddNewScreen(
      this.username,
      this.nik,
      this.nama,
      this.namaPensiun,
      this.alamat,
      this.telepon,
      this.selectedJenisDebitur,
      this.selectedJenisProduk,
      this.tanggalAkad,
      this.nomorAplikasi,
      this.nomorPerjanjian,
      this.selectedJenisCabang,
      this.plafond,
      this.selectedJenisInfo,
      this.selectedStatusKredit,
      this.namaPetugasBank,
      this.jabatanPetugasBank,
      this.teleponPetugasBank,
      this.selectedPengelolaPensiun,
      this.idPipeline);
  @override
  _DisbursmentAddNewScreen createState() => _DisbursmentAddNewScreen();
}

class _DisbursmentAddNewScreen extends State<DisbursmentAddNewScreen> {
  var personalData = new List(34);
  String image1;
  String base64Image1;
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print(widget.selectedPengelolaPensiun);
      images.add("Add Image");
    });
  }

  String namaPensiun;
  String alamat;
  String telepon;
  String selectedJenisDebitur;
  String selectedJenisProduk;
  String tanggalAkad;
  String nomorAplikasi;
  String nomorPerjanjian;
  String selectedJenisCabang;
  String plafond;
  String selectedJenisInfo;
  String selectedStatusKredit;
  String namaPetugasBank;
  String jabatanPetugasBank;
  String teleponPetugasBank;
  String selectedPengelolaPensiun;
  String tanggalPencairan;
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool visible = false;

  final tanggalPencairanController = TextEditingController();

  Future userLogin() async {
    //getting value from controller
    String username = widget.username;
    String password = widget.nik;

    //server login api
    var url = 'https://www.nabasa.co.id/api_marsit_v1/index.php/getLogin';

    //starting web api call
    var response = await http
        .post(url, body: {'username': username, 'password': password});

    if (username == '' || password == '') {
    } else {
      //if the response message is matched
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Daftar_Login'];
        print(message);
        if (message['message'].toString() == 'Login Success') {
          if (message['status_account'] == 'SUSPEND') {
          } else {
            setState(() {
              personalData[0] = message['nik'];
              personalData[1] = message['full_name'];
              personalData[2] = message['marital_status'];
              personalData[3] = message['date_of_birth'];
              personalData[4] = message['place_of_birth'];
              personalData[5] = message['no_ktp'];
              personalData[6] = message['gender'];
              personalData[7] = message['religion'];
              personalData[8] = message['email_address'];
              personalData[9] = message['phone_number'];
              personalData[10] = message['education'];
              personalData[11] = message['alamat'];
              personalData[12] = message['kelurahan'];
              personalData[13] = message['kecamatan'];
              personalData[14] = message['kabupaten'];
              personalData[15] = message['kode_pos'];
              personalData[16] = message['propinsi'];
              personalData[17] = message['no_rekening'];
              personalData[18] = message['nama_bank'];
              personalData[19] = message['nama_rekening'];
              personalData[20] = message['divisi_karyawan'];
              personalData[21] = message['jabatan_karyawan'];
              personalData[22] = message['wilayah_karyawan'];
              personalData[23] = message['branch'];
              personalData[24] = message['status_karyawan'];
              personalData[25] = message['grade_karyawan'];
              personalData[26] = message['gaji_pokok'];
              personalData[27] = message['tunjangan_tkd'];
              personalData[28] = message['tunjangan_jabatan'];
              personalData[29] = message['tunjangan_perumahan'];
              personalData[30] = message['tunjangan_telepon'];
              personalData[31] = message['tunjangan_kinerja'];
              personalData[32] = message['nik_marsit'];
              personalData[33] = message['diamond'];
            });
            if (message['hak_akses'] == '5') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingScreen(
                      widget.username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LandingMrScreen(
                      widget.username,
                      message['nik_marsit'],
                      message['income'],
                      message['pict'],
                      message['divisi'],
                      message['greeting'],
                      message['hak_akses'],
                      personalData,
                      message['tarif'],
                      message['diamond'])));
            }
          }
        } else {}
      } else {
        print('error');
      }
    }
  }

  Future saveDisbursment() async {
    //showing CircularProgressIndicator
    setState(() {
      visible = true;
    });

    //getting value from controller
    tanggalPencairan = tanggalPencairanController.text;
    //server save api
    var url =
        'https://www.nabasa.co.id/api_marsit_v1/index.php/saveDisbursmentNew';

    //starting web api call
    var response = await http.post(url, body: {
      'nama_pensiun': widget.namaPensiun,
      'alamat': widget.alamat,
      'telepon': widget.telepon,
      'jenis_debitur': widget.selectedJenisDebitur,
      'jenis_produk': widget.selectedJenisProduk,
      'tanggal_akad': widget.tanggalAkad,
      'nomor_aplikasi': widget.nomorAplikasi,
      'nomor_perjanjian': widget.nomorPerjanjian,
      'jenis_cabang': widget.selectedJenisCabang,
      'plafond': widget.plafond,
      'jenis_info': widget.selectedJenisInfo,
      'niksales': widget.nik,
      'file_name': 'disbursment',
      'image1': base64Image1,
      'name1': image1,
      'status_kredit': widget.selectedStatusKredit,
      'nama_petugas_bank': widget.namaPetugasBank,
      'jabatan_petugas_bank': widget.jabatanPetugasBank,
      'telepon_petugas_bank': widget.teleponPetugasBank,
      'pengelola_pensiun': widget.selectedPengelolaPensiun,
      'tanggal_pencairan': tanggalPencairan,
      'id_pipeline': widget.idPipeline
    });

    if (response.statusCode == 200) {
      var message = jsonDecode(response.body)['Save_Disbursment'];
      if (message.toString() == 'Save Success') {
        setState(() {
          visible = false;
          tanggalPencairanController.clear();
          image1 = null;
        });
        userLogin();
        Toast.show(
          'Sukses menambahkan data pencairan kredit...',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      } else if (message.toString() == 'Nomor Aplikasi') {
        setState(() {
          visible = false;
        });
        Toast.show(
          'Maaf, nomor aplikasi sudah terdaftar, mohon masukkan nomor aplikasi yang lain...',
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
          'Gagal menambahkan data pencairan kredit...',
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          visible
              ? showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                        'Mohon menunggu, sedang proses penyimpanan pencairan kredit...'),
                    //content: Text('We hate to see you leave...'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                )
              : Navigator.of(context).pop();
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Pencairan',
              style: TextStyle(fontFamily: 'Montserrat Regular'),
            ),
            actions: <Widget>[
              FlatButton(
                  color: Colors.white,
                  //LAKUKAN PENGECEKAN, JIKA _ISLOADING TRUE MAKA TAMPILKAN LOADING
                  //JIKA FALSE, MAKA TAMPILKAN ICON SAVE
                  child: visible
                      ? CircularProgressIndicator(
                          //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.teal),
                        )
                      : Text(
                          'Simpan',
                          style: TextStyle(
                              fontFamily: 'Montserrat Regular',
                              color: Colors.teal,
                              fontWeight: FontWeight.bold),
                        ),
                  onPressed: () {
                    print(image1);
                    if (formKey.currentState.validate()) {
                      if (image1 == null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Mohon pilih foto bukti dana cair...'),
                          duration: Duration(seconds: 3),
                        ));
                      } else {
                        saveDisbursment();
                      }
                    }
                  })
            ],
          ),
          body: Container(
              color: Colors.grey[200],
              child: Form(
                key: formKey,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Informasi Akad',
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              fieldDebitur(
                                  'Tanggal Akad', widget.tanggalAkad, 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur(
                                  'Nomor Aplikasi', widget.nomorAplikasi, 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Nomor Perjanjian',
                                  widget.nomorPerjanjian, 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur(
                                  'Plafond', formatRupiah(widget.plafond), 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Jenis Produk',
                                  widget.selectedJenisProduk, 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur('Informasi Sales',
                                  widget.selectedJenisInfo, 120),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Informasi Petugas Bank',
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              fieldDebitur('Nama', widget.namaPetugasBank, 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur(
                                  'Jabatan', widget.jabatanPetugasBank, 120),
                              SizedBox(
                                height: 10,
                              ),
                              fieldDebitur(
                                  'Telepon', widget.teleponPetugasBank, 120),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Data Pencairan',
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          fieldTanggalPencairan(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Dokumen Pencairan',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      //color: Colors.white,
                      child: Row(
                        children: <Widget>[Expanded(child: buildGridView())],
                      ),
                    ),
                  ],
                ),
              )),
        ));
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

  Widget fieldDebitur(title, value, double size) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          decoration: new BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Montserrat Regular', color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Montserrat Regular',
            color: Colors.black,
          ),
        )
      ],
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        child: PhotoView(
                          imageProvider: FileImage(uploadModel.imageFile),
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                    );
                  },
                  child: Image.file(
                    uploadModel.imageFile,
                    width: 300,
                    height: 300,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          String titled;
          Color colored;
          if (index == 0) {
            titled = 'Foto Bukti Dana Cair';
            colored = Colors.teal;
          }
          return Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: colored, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titled,
                    style: TextStyle(
                        fontSize: 8.0, fontFamily: 'Montserrat Regular'),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _onAddImageClick(index);
                    },
                  ),
                ],
              ));
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    //    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        if (file == null) {
        } else {
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = file;
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
          String base64Image =
              base64Encode(imageUpload.imageFile.readAsBytesSync());
          String fileName = imageUpload.imageFile.path.split('/').last;
          //String base64Image = imageUpload.imageFile.re
          if (index == 0) {
            image1 = fileName;
            base64Image1 = base64Image;
          }
        }
      });
    });
  }

  Widget fieldTanggalPencairan() {
    final format = DateFormat("yyyy-MM-dd");
    return Column(children: <Widget>[
      DateTimeField(
          controller: tanggalPencairanController,
          validator: (DateTime dateTime) {
            if (dateTime == null) {
              return 'Tanggal pencairan wajib diisi...';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Tanggal Pencairan'),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
          style: TextStyle(fontFamily: 'Montserrat Regular')),
    ]);
  }
}
