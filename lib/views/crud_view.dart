import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum JenisSurat {
  sktm,
  suratUsaha,
}

enum JenisKelamin {
  lakiLaki,
  perempuan,
}

enum StatusPerkawinan {
  kawin,
  belumKawin,
}

enum Agama {
  islam,
  protestan,
  katolik,
  buddha,
  hindu,
  konghucu,
}

class DataModel {
  JenisSurat jenisSurat;
  String nama;
  String nik;
  DateTime tanggalLahir;
  JenisKelamin jenisKelamin;
  StatusPerkawinan statusPerkawinan;
  String pekerjaan;
  Agama agama;
  String alamat;

  DataModel({
    required this.jenisSurat,
    required this.nama,
    required this.nik,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.statusPerkawinan,
    required this.pekerjaan,
    required this.agama,
    required this.alamat,
  });
}

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  JenisSurat selectedJenisSurat = JenisSurat.sktm;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  DateTime selectedTanggalLahir = DateTime.now();
  JenisKelamin selectedJenisKelamin = JenisKelamin.lakiLaki;
  StatusPerkawinan selectedStatusPerkawinan = StatusPerkawinan.kawin;
  TextEditingController _pekerjaanController = TextEditingController();
  Agama selectedAgama = Agama.islam;
  TextEditingController _alamatController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTanggalLahir,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedTanggalLahir) {
      setState(() {
        selectedTanggalLahir = picked;
      });
    }
  }

  void _addData(BuildContext context) {
    String nama = _namaController.text;
    String nik = _nikController.text;
    String pekerjaan = _pekerjaanController.text;
    String alamat = _alamatController.text;

    DataModel newData = DataModel(
      jenisSurat: selectedJenisSurat,
      nama: nama,
      nik: nik,
      tanggalLahir: selectedTanggalLahir,
      jenisKelamin: selectedJenisKelamin,
      statusPerkawinan: selectedStatusPerkawinan,
      pekerjaan: pekerjaan,
      agama: selectedAgama,
      alamat: alamat,
    );

    Navigator.pop(context, newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<JenisSurat>(
                value: selectedJenisSurat,
                onChanged: (JenisSurat? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedJenisSurat = newValue;
                    });
                  }
                },
                items: JenisSurat.values.map((JenisSurat jenisSurat) {
                  return DropdownMenuItem<JenisSurat>(
                    value: jenisSurat,
                    child: Text(jenisSurat.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Jenis Surat',
                ),
              ),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: _nikController,
                decoration: InputDecoration(
                  labelText: 'NIK',
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Tanggal Lahir'),
                subtitle: Text(
                  DateFormat('dd MMMM yyyy').format(selectedTanggalLahir),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              DropdownButtonFormField<JenisKelamin>(
                value: selectedJenisKelamin,
                onChanged: (JenisKelamin? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedJenisKelamin = newValue;
                    });
                  }
                },
                items: JenisKelamin.values.map((JenisKelamin jenisKelamin) {
                  return DropdownMenuItem<JenisKelamin>(
                    value: jenisKelamin,
                    child: Text(jenisKelamin.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                ),
              ),
              DropdownButtonFormField<StatusPerkawinan>(
                value: selectedStatusPerkawinan,
                onChanged: (StatusPerkawinan? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedStatusPerkawinan = newValue;
                    });
                  }
                },
                items: StatusPerkawinan.values
                    .map((StatusPerkawinan statusPerkawinan) {
                  return DropdownMenuItem<StatusPerkawinan>(
                    value: statusPerkawinan,
                    child: Text(statusPerkawinan.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Status Perkawinan',
                ),
              ),
              TextField(
                controller: _pekerjaanController,
                decoration: InputDecoration(
                  labelText: 'Pekerjaan',
                ),
              ),
              DropdownButtonFormField<Agama>(
                value: selectedAgama,
                onChanged: (Agama? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAgama = newValue;
                    });
                  }
                },
                items: Agama.values.map((Agama agama) {
                  return DropdownMenuItem<Agama>(
                    value: agama,
                    child: Text(agama.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Agama',
                ),
              ),
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Tambah'),
                onPressed: () {
                  _addData(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DataModel> dataList = [];

  void _addData(DataModel newData) {
    setState(() {
      dataList.add(newData);
    });
  }

  void _goToAddDataPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataPage()),
    );

    if (result != null) {
      _addData(result);
    }
  }

  void _editData(DataModel data) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataPage(data: data)),
    );

    if (result != null) {
      _updateData(result);
    }
  }

  void _deleteData(DataModel data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                setState(() {
                  dataList.remove(data);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _updateData(DataModel updatedData) {
    setState(() {
      int index = dataList.indexWhere((data) => data.nik == updatedData.nik);
      if (index != -1) {
        dataList[index] = updatedData;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistem Informasi Surat Menyurat'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          DataModel data = dataList[index];
          return ListTile(
            title: Text(
                'Jenis Surat: ${data.jenisSurat.toString().split('.').last}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama: ${data.nama}'),
                Text('NIK: ${data.nik}'),
                Text(
                    'Tanggal Lahir: ${DateFormat('dd MMMM yyyy').format(data.tanggalLahir)}'),
                Text(
                    'Jenis Kelamin: ${data.jenisKelamin.toString().split('.').last}'),
                Text(
                    'Status Perkawinan: ${data.statusPerkawinan.toString().split('.').last}'),
                Text('Pekerjaan: ${data.pekerjaan}'),
                Text('Agama: ${data.agama.toString().split('.').last}'),
                Text('Alamat: ${data.alamat}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editData(data);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteData(data);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _goToAddDataPage(context);
        },
      ),
    );
  }
}

class EditDataPage extends StatefulWidget {
  final DataModel data;

  EditDataPage({required this.data});

  @override
  _EditDataPageState createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  JenisSurat selectedJenisSurat = JenisSurat.sktm;
  TextEditingController _namaController = TextEditingController();
  TextEditingController _nikController = TextEditingController();
  DateTime selectedTanggalLahir = DateTime.now();
  JenisKelamin selectedJenisKelamin = JenisKelamin.lakiLaki;
  StatusPerkawinan selectedStatusPerkawinan = StatusPerkawinan.kawin;
  TextEditingController _pekerjaanController = TextEditingController();
  Agama selectedAgama = Agama.islam;
  TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedJenisSurat = widget.data.jenisSurat;
    _namaController.text = widget.data.nama;
    _nikController.text = widget.data.nik;
    selectedTanggalLahir = widget.data.tanggalLahir;
    selectedJenisKelamin = widget.data.jenisKelamin;
    selectedStatusPerkawinan = widget.data.statusPerkawinan;
    _pekerjaanController.text = widget.data.pekerjaan;
    selectedAgama = widget.data.agama;
    _alamatController.text = widget.data.alamat;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedTanggalLahir,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedTanggalLahir) {
      setState(() {
        selectedTanggalLahir = picked;
      });
    }
  }

  void _editData(BuildContext context) {
    String nama = _namaController.text;
    String nik = _nikController.text;
    String pekerjaan = _pekerjaanController.text;
    String alamat = _alamatController.text;

    DataModel updatedData = DataModel(
      jenisSurat: selectedJenisSurat,
      nama: nama,
      nik: nik,
      tanggalLahir: selectedTanggalLahir,
      jenisKelamin: selectedJenisKelamin,
      statusPerkawinan: selectedStatusPerkawinan,
      pekerjaan: pekerjaan,
      agama: selectedAgama,
      alamat: alamat,
    );

    Navigator.pop(context, updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<JenisSurat>(
                value: selectedJenisSurat,
                onChanged: (JenisSurat? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedJenisSurat = newValue;
                    });
                  }
                },
                items: JenisSurat.values.map((JenisSurat jenisSurat) {
                  return DropdownMenuItem<JenisSurat>(
                    value: jenisSurat,
                    child: Text(jenisSurat.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Jenis Surat',
                ),
              ),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: _nikController,
                decoration: InputDecoration(
                  labelText: 'NIK',
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Tanggal Lahir'),
                subtitle: Text(
                  DateFormat('dd MMMM yyyy').format(selectedTanggalLahir),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              DropdownButtonFormField<JenisKelamin>(
                value: selectedJenisKelamin,
                onChanged: (JenisKelamin? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedJenisKelamin = newValue;
                    });
                  }
                },
                items: JenisKelamin.values.map((JenisKelamin jenisKelamin) {
                  return DropdownMenuItem<JenisKelamin>(
                    value: jenisKelamin,
                    child: Text(jenisKelamin.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                ),
              ),
              DropdownButtonFormField<StatusPerkawinan>(
                value: selectedStatusPerkawinan,
                onChanged: (StatusPerkawinan? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedStatusPerkawinan = newValue;
                    });
                  }
                },
                items: StatusPerkawinan.values
                    .map((StatusPerkawinan statusPerkawinan) {
                  return DropdownMenuItem<StatusPerkawinan>(
                    value: statusPerkawinan,
                    child: Text(statusPerkawinan.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Status Perkawinan',
                ),
              ),
              TextField(
                controller: _pekerjaanController,
                decoration: InputDecoration(
                  labelText: 'Pekerjaan',
                ),
              ),
              DropdownButtonFormField<Agama>(
                value: selectedAgama,
                onChanged: (Agama? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedAgama = newValue;
                    });
                  }
                },
                items: Agama.values.map((Agama agama) {
                  return DropdownMenuItem<Agama>(
                    value: agama,
                    child: Text(agama.toString().split('.').last),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Agama',
                ),
              ),
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Simpan'),
                onPressed: () {
                  _editData(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}
