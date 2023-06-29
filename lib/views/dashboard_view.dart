import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sismdlb/providers/dashboard_provider.dart';
import 'package:sismdlb/views/berita.dart';
import 'package:sismdlb/views/login_views.dart';
import 'package:provider/provider.dart';
import 'package:sismdlb/views/obat.dart';
import 'package:sismdlb/views/dokter.dart';
import 'package:sismdlb/views/pasien.dart';
import 'package:sismdlb/views/berobat.dart';

class Dashboardview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final panels = [DashboardPanel(), BerobatPage(), LoginView()];
    return Consumer<DashboardProvider>(builder: (context, provider, widget) {
      return Scaffold(
          bottomNavigationBar: navigatorbawah(),
          body: panels[provider.indexTombol]);
    });
  }
}

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/yellow.png'),
        informasi_pengguna(),
        SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 180),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  margin: EdgeInsets.zero,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Wrap(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => ObatPage()));
                              },
                              child: TombolMenu(
                                image: Image.asset(
                                  'assets/obat.png',
                                  width: 60,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => DokterPage()));
                              },
                              child: TombolMenu(
                                image: Image.asset(
                                  'assets/doctor.png',
                                  width: 60,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) => PasienPage()));
                              },
                              child: TombolMenu(
                                image: Image.asset(
                                  'assets/pasien.png',
                                  width: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )))
      ],
    );
  }
}

class TombolMenu extends StatelessWidget {
  final Image? image;
  const TombolMenu({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: image ?? SizedBox(),
      ),
    );
  }
}

class navigatorbawah extends StatelessWidget {
  const navigatorbawah({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return home();
  }
}

class informasi_pengguna extends StatelessWidget {
  const informasi_pengguna({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/user.png',
                width: 60,
              )),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hai, admin',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'admin@gmail.com',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class home extends StatelessWidget {
  const home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.read<DashboardProvider>();

    return BottomNavigationBar(
      currentIndex: p.indexTombol,
      onTap: (value) {
        if (value == 2) {
          // Jika tombol logout diklik
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
            (Route<dynamic> route) => false,
          );
        } else {
          p.saatdiklik(value);
        }
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.hospital), label: 'Berobat'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.gear), label: 'Logout')
      ],
    );
  }
}

void main() {
  runApp(Dashboardview());
}
