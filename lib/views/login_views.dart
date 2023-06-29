import 'package:flutter/material.dart';
import 'package:sismdlb/views/dashboard_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        // Ganti Column dengan ListView
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 135, bottom: 50),
            child: Text(
              'Aplikasi\nKlinik Anggrek',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Stack(
            children: [
              Container(
                height: 600,
                child: Card(
                  margin:
                      EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
                  color: Color.fromARGB(255, 110, 12, 223),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.grey[50],
                              filled: true),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              fillColor: Colors.grey[50],
                              filled: true),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (bc) {
                            return Dashboardview();
                          }));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text('Login'),
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            primary: Colors.red),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/login.png',
                  width: 150,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
