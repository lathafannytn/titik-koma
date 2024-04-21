import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VoucherScreen extends StatefulWidget {
  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  String _searchKode = '';

  Future<List<VoucherData>> fetchvoucherByTitle() async {
    final response = await http.post(
      Uri.parse("https://localhost/"),

    );

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);

      if (jsonData['result'] == 'success') {
        //List<dynamic> voucherList = jsonData['voucher'];

        List<VoucherData> voucherDataList =
            voucherList.map((json) => VoucherData.fromJson(json)).toList();

        return voucherDataList;
      } else {
        print('Failed to fetch . ${jsonData['message']}');
        throw Exception('Failed to load  data');
      }
    } else {
      print('Failed to fetch . Status code: ${response.statusCode}');
      throw Exception('Failed to load  data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Voucher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari berdasarkan kode',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchVoucher();
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchKode = value;
                });
              },
            ),
            SizedBox(height: 16),
            FutureBuilder<List<VoucherData>>(
              future: fetchvoucherByTitle(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<VoucherData> voucherDataList = snapshot.data!;

                  if (voucherDataList.isEmpty) {
                    return Center(
                      child: Text('Tidak ada voucher yang tersedia.'),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: voucherDataList.length,
                      itemBuilder: (context, index) {
                        final VoucherData voucherData = voucherDataList[index];
                        return CardVoucher(
                          id: voucherData.id,
                          title: voucherData.title,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _searchVoucher() {
    setState(() {
      _searchKode = '';
    });
  }
}
