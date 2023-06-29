import 'package:flutter/material.dart';

class Obat {
  String nama;
  String deskripsi;

  Obat({required this.nama, required this.deskripsi});
}

void main() {
  runApp(ObatPage());
}

class ObatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Obat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ObatListScreen(),
    );
  }
}

class ObatListScreen extends StatefulWidget {
  @override
  _ObatListScreenState createState() => _ObatListScreenState();
}

class _ObatListScreenState extends State<ObatListScreen> {
  List<Obat> obatList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Obat'),
      ),
      body: ListView.builder(
        itemCount: obatList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(obatList[index].nama),
            subtitle: Text(obatList[index].deskripsi),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _hapusObat(index);
              },
            ),
            onTap: () {
              _editObat(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _tambahObat,
      ),
    );
  }

  void _tambahObat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nama = '';
        String deskripsi = '';

        return AlertDialog(
          title: Text('Tambah Obat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Nama Obat'),
                onChanged: (value) {
                  nama = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Deskripsi Obat'),
                onChanged: (value) {
                  deskripsi = value;
                },
              ),
            ],
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
                Obat obat = Obat(nama: nama, deskripsi: deskripsi);
                setState(() {
                  obatList.add(obat);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editObat(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nama = obatList[index].nama;
        String deskripsi = obatList[index].deskripsi;

        return AlertDialog(
          title: Text('Edit Obat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Nama Obat'),
                onChanged: (value) {
                  nama = value;
                },
                controller: TextEditingController(text: obatList[index].nama),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Deskripsi Obat'),
                onChanged: (value) {
                  deskripsi = value;
                },
                controller:
                    TextEditingController(text: obatList[index].deskripsi),
              ),
            ],
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
                Obat obat = Obat(nama: nama, deskripsi: deskripsi);
                setState(() {
                  obatList[index] = obat;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _hapusObat(int index) {
    if (index >= 0 && index < obatList.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hapus Obat'),
            content: Text('Apakah Anda yakin ingin menghapus obat ini?'),
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
                    obatList.removeAt(index);
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
