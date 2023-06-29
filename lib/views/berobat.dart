import 'package:flutter/material.dart';

enum Gender { Male, Female }

class DataPasien {
  String nama;
  Gender jenisKelamin;
  String obat;
  String dokter;
  DateTime tanggalBerobat;
  String keluhan;
  String hasilDiagnosa;
  String penatalaksanaan;

  DataPasien({
    required this.nama,
    required this.jenisKelamin,
    required this.obat,
    required this.dokter,
    required this.tanggalBerobat,
    required this.keluhan,
    required this.hasilDiagnosa,
    required this.penatalaksanaan,
  });
}

class BerobatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Berobat',
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
  List<DataPasien> pasienList = [];
  List<String> genderList = ['Laki-laki', 'Perempuan'];
  Gender selectedGender = Gender.Male;
  List<String> dokterList = ['dr. Nando', 'dr. Irawan'];
  String selectedDokter = 'dr. Nando';
  DateTime tanggalBerobat = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Berobat'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: pasienList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pasienList[index].nama),
            subtitle: Text(
              'Jenis Kelamin: ${pasienList[index].jenisKelamin.toString().split('.').last}\nDokter: ${pasienList[index].dokter}\nTanggal Berobat: ${pasienList[index].tanggalBerobat.toString().split(' ')[0]}\nKeluhan: ${pasienList[index].keluhan}\nHasil Diagnosa: ${pasienList[index].hasilDiagnosa}\nPenatalaksanaan: ${pasienList[index].penatalaksanaan}',
            ),
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
        DateTime tanggalBerobat = DateTime.now();
        String obat = '';
        String keluhan = '';
        String hasilDiagnosa = '';
        String penatalaksanaan = '';

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
                    Text('Dokter'),
                    DropdownButton(
                      value: selectedDokter,
                      items: dokterList.map((dokter) {
                        return DropdownMenuItem(
                          value: dokter,
                          child: Text(dokter),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDokter = value.toString();
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text('Tanggal Berobat'),
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              tanggalBerobat = value;
                            });
                          }
                        });
                      },
                      child: Text(
                        'Pilih Tanggal',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Obat'),
                      onChanged: (value) {
                        obat = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Keluhan'),
                      onChanged: (value) {
                        keluhan = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Hasil Diagnosa'),
                      onChanged: (value) {
                        hasilDiagnosa = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Penatalaksanaan'),
                      onChanged: (value) {
                        penatalaksanaan = value;
                      },
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
                DataPasien pasien = DataPasien(
                  nama: nama,
                  jenisKelamin: selectedGender,
                  obat: obat,
                  dokter: selectedDokter,
                  tanggalBerobat: tanggalBerobat,
                  keluhan: keluhan,
                  hasilDiagnosa: hasilDiagnosa,
                  penatalaksanaan: penatalaksanaan,
                );
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
        selectedDokter = pasienList[index].dokter;
        tanggalBerobat = pasienList[index].tanggalBerobat;
        String obat = pasienList[index].obat;
        String keluhan = pasienList[index].keluhan;
        String hasilDiagnosa = pasienList[index].hasilDiagnosa;
        String penatalaksanaan = pasienList[index].penatalaksanaan;

        return AlertDialog(
          title: Text('Edit Pasien'),
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
                      controller: TextEditingController(text: nama),
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
                    Text('Dokter'),
                    DropdownButton(
                      value: selectedDokter,
                      items: dokterList.map((dokter) {
                        return DropdownMenuItem(
                          value: dokter,
                          child: Text(dokter),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDokter = value.toString();
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text('Tanggal Berobat'),
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: tanggalBerobat,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              tanggalBerobat = value;
                            });
                          }
                        });
                      },
                      child: Text(
                        'Pilih Tanggal',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Obat'),
                      onChanged: (value) {
                        obat = value;
                      },
                      controller: TextEditingController(text: obat),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Keluhan'),
                      onChanged: (value) {
                        keluhan = value;
                      },
                      controller: TextEditingController(text: keluhan),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Hasil Diagnosa'),
                      onChanged: (value) {
                        hasilDiagnosa = value;
                      },
                      controller: TextEditingController(text: hasilDiagnosa),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(labelText: 'Penatalaksanaan'),
                      onChanged: (value) {
                        penatalaksanaan = value;
                      },
                      controller: TextEditingController(text: penatalaksanaan),
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
                DataPasien pasien = DataPasien(
                  nama: nama,
                  jenisKelamin: selectedGender,
                  obat: obat,
                  dokter: selectedDokter,
                  tanggalBerobat: tanggalBerobat,
                  keluhan: keluhan,
                  hasilDiagnosa: hasilDiagnosa,
                  penatalaksanaan: penatalaksanaan,
                );
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
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

void main() {
  runApp(BerobatPage());
}
