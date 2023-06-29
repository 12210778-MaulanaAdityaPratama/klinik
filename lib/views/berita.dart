import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Berita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berobat'),
      ),
      body: Consumer(builder: (context, prov, w) {
        return ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('title'),
                Image.network('image' ?? '',
                    errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/doctor.png');
                }),
                Text('description')
              ],
            )
          ],
        );
      }),
    );
  }
}
