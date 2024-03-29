import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_gp_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_image.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_kp74_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_pa_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_prapensiun_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_screen.dart';
import 'package:kreditpensiun_apps/Screens/Simulation/simulation_tht_screen.dart';
import 'package:kreditpensiun_apps/constants.dart';

class SimulationViewScreen extends StatefulWidget {
  String nik;
  SimulationViewScreen(this.nik);
  @override
  _SimulationViewScreenState createState() => _SimulationViewScreenState();
}

class _SimulationViewScreenState extends State<SimulationViewScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation1;
  Animation<double> _animation2;
  Animation<double> _animation3;
  Animation<double> _animation4;
  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this, value: 0.1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    _animation1 = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    _animation2 =
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);
    _animation3 = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation4 = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          'Simulasi',
          style: TextStyle(
            fontFamily: 'Montserrat Regular',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SimulationPegawaiAktifScreen(widget.nik)));
                },
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                    leading: ScaleTransition(
                      scale: _animation,
                      child: Image.asset(
                        'assets/images/pns_aktif.png',
                        height: 50,
                      ),
                    ),
                    title: Text(
                      'PNS Aktif',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.cyan[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'PNS aktif reguler',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SimulationGpScreen(widget.nik)));
                },
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                    leading: ScaleTransition(
                      scale: _animation1,
                      child: Image.asset(
                        'assets/images/prapen_5.png',
                        height: 50,
                      ),
                    ),
                    title: Text(
                      'Prapensiun',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Grace Period < 5 Tahun',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SimulationRegulerPrapensiunScreen(widget.nik)));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: ScaleTransition(
                        scale: _animation2,
                        child: Image.asset(
                          'assets/images/prapens_10.png',
                          height: 50,
                        ),
                      ),
                      title: Text(
                        'Prapensiun',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Combo < 10 Tahun',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ]),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SimulationScreen(widget.nik)));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: ScaleTransition(
                        scale: _animation3,
                        child: Image.asset(
                          'assets/images/pensiun.png',
                          height: 50,
                        ),
                      ),
                      title: Text(
                        'Pensiunan',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Pensiunan regular',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ]),
                )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SimulationKp74Screen()));
                  },
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    ListTile(
                      leading: ScaleTransition(
                        scale: _animation4,
                        child: Image.asset(
                          'assets/images/platinum.png',
                          height: 50,
                        ),
                      ),
                      title: Text(
                        'Pensiunan Platinum',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Pensiunan diatas 70 tahun sampai 80 tahun  ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
