import 'package:flutter/material.dart';

class Dokter {
  String nama;
  String jamPraktek;

  Dokter({required this.nama, required this.jamPraktek});
}

void main() {
  runApp(DokterPage());
}

class DokterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Dokter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DokterListScreen(),
    );
  }
}

class DokterListScreen extends StatefulWidget {
  @override
  _DokterListScreenState createState() => _DokterListScreenState();
}

class _DokterListScreenState extends State<DokterListScreen> {
  List<Dokter> dokterList = [];
  List<String> jamPraktekList = [
    '08:00 - 10:00',
    '10:00 - 12:00',
    '13:00 - 15:00',
    '15:00 - 17:00',
  ];
  String selectedJamPraktek = '08:00 - 10:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Dokter'),
      ),
      body: ListView.builder(
        itemCount: dokterList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(dokterList[index].nama),
            subtitle: Text(dokterList[index].jamPraktek),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _hapusDokter(index);
              },
            ),
            onTap: () {
              _editDokter(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _tambahDokter,
      ),
    );
  }

  void _tambahDokter() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nama = '';
        String jamPraktek = '';

        return AlertDialog(
          title: Text('Tambah Dokter'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Nama Dokter'),
                    onChanged: (value) {
                      nama = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text('Jam Praktek'),
                  DropdownButton(
                    value: selectedJamPraktek,
                    items: jamPraktekList.map((jamPraktek) {
                      return DropdownMenuItem(
                        value: jamPraktek,
                        child: Text(jamPraktek),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedJamPraktek = value.toString();
                        jamPraktek = value.toString();
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                Dokter dokter = Dokter(nama: nama, jamPraktek: jamPraktek);
                setState(() {
                  dokterList.add(dokter);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editDokter(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nama = dokterList[index].nama;
        selectedJamPraktek = dokterList[index].jamPraktek;

        return AlertDialog(
          title: Text('Edit Dokter'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Nama Dokter'),
                    onChanged: (value) {
                      nama = value;
                    },
                    controller:
                        TextEditingController(text: dokterList[index].nama),
                  ),
                  SizedBox(height: 16.0),
                  Text('Jam Praktek'),
                  DropdownButton(
                    value: selectedJamPraktek,
                    items: jamPraktekList.map((jamPraktek) {
                      return DropdownMenuItem(
                        value: jamPraktek,
                        child: Text(jamPraktek),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedJamPraktek = value.toString();
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () {
                Dokter dokter =
                    Dokter(nama: nama, jamPraktek: selectedJamPraktek);
                setState(() {
                  dokterList[index] = dokter;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _hapusDokter(int index) {
    if (index >= 0 && index < dokterList.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hapus Dokter'),
            content: Text('Apakah Anda yakin ingin menghapus dokter ini?'),
            actions: <Widget>[
              TextButton(
                child: Text('Batal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Hapus'),
                onPressed: () {
                  setState(() {
                    dokterList.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
