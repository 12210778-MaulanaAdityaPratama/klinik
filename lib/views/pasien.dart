import 'package:flutter/material.dart';

enum Gender { Male, Female }

class Pasien {
  String nama;
  Gender jenisKelamin;
  int umur;

  Pasien({required this.nama, required this.jenisKelamin, required this.umur});
}

void main() {
  runApp(PasienPage());
}

class PasienPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Pasien',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PasienListScreen(),
    );
  }
}

class PasienListScreen extends StatefulWidget {
  @override
  _PasienListScreenState createState() => _PasienListScreenState();
}

class _PasienListScreenState extends State<PasienListScreen> {
  List<Pasien> pasienList = [];
  List<String> genderList = ['Laki-laki', 'Perempuan'];
  Gender selectedGender = Gender.Male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pasien'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: pasienList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pasienList[index].nama),
            subtitle: Text(
                'Jenis Kelamin: ${pasienList[index].jenisKelamin.toString().split('.').last}\nUmur: ${pasienList[index].umur}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _hapusPasien(index);
              },
            ),
            onTap: () {
              _editPasien(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _tambahPasien,
      ),
    );
  }

  void _tambahPasien() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nama = '';
        int umur = 0;

        return AlertDialog(
          title: Text('Tambah Pasien'),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Nama Pasien'),
                      onChanged: (value) {
                        nama = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text('Jenis Kelamin'),
                    DropdownButton(
                      value: selectedGender,
                      items: genderList.map((gender) {
                        return DropdownMenuItem(
                          value: gender == 'Laki-laki'
                              ? Gender.Male
                              : Gender.Female,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value as Gender;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Umur'),
                      onChanged: (value) {
                        umur = int.tryParse(value) ?? 0;
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ],
                );
              },
            ),
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
                Pasien pasien = Pasien(
                    nama: nama, jenisKelamin: selectedGender, umur: umur);
                setState(() {
                  pasienList.add(pasien);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editPasien(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nama = pasienList[index].nama;
        selectedGender = pasienList[index].jenisKelamin;
        int umur = pasienList[index].umur;

        return AlertDialog(
          title: Text('Edit Pasien'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Nama Pasien'),
                    onChanged: (value) {
                      nama = value;
                    },
                    controller:
                        TextEditingController(text: pasienList[index].nama),
                  ),
                  SizedBox(height: 16.0),
                  Text('Jenis Kelamin'),
                  DropdownButton(
                    value: selectedGender,
                    items: genderList.map((gender) {
                      return DropdownMenuItem(
                        value:
                            gender == 'Laki-laki' ? Gender.Male : Gender.Female,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value as Gender;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'Umur'),
                    onChanged: (value) {
                      umur = int.tryParse(value) ?? 0;
                    },
                    controller: TextEditingController(
                        text: pasienList[index].umur.toString()),
                    keyboardType: TextInputType.number,
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
                Pasien pasien = Pasien(
                    nama: nama, jenisKelamin: selectedGender, umur: umur);
                setState(() {
                  pasienList[index] = pasien;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _hapusPasien(int index) {
    if (index >= 0 && index < pasienList.length) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hapus Pasien'),
            content: Text('Apakah Anda yakin ingin menghapus pasien ini?'),
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
                    pasienList.removeAt(index);
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
