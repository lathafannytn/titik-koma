import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tikom/data/repository/transaction_repository.dart';
import 'package:tikom/main.dart';
import 'package:tikom/ui/widgets/dialog.dart';
import 'package:tikom/ui/widgets/image_picker_frame.dart';
import 'package:tikom/ui/widgets/loading_dialog.dart';
import 'package:tikom/utils/extentions.dart' as AppExt;

class PaymentPage extends StatefulWidget {
  final String uuid;

  const PaymentPage({Key? key, required this.uuid}) : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _fileName;
  File? _image;
  final picker = ImagePicker();

  _pickImageFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    AppExt.popScreen(context);
  }

  _pickImageFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });

    AppExt.popScreen(context);
  }

  void handlePayment() async {
    LoadingDialog.show(context, barrierColor: const Color(0xFF777C7E));
    try {
      final TransactionRepository transactionRepository =
          TransactionRepository();
      final response = await transactionRepository.payment(
          uuidOrder: widget.uuid, imagePayment: _image!.path);
      print(response);
      if (response.status == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        DialogTemp().Informasi(
            context: context,
            onYes: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            tabIndex: 2,
                          )));
            },
            onYesText: 'Lanjut',
            title: 'Pembayaran Berhasil Harap Tunggu Konfirmasi Admin');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        DialogTemp().Informasi(
            context: context,
            onYes: () {
              Navigator.pop(context);
            },
            onYesText: 'Oke',
            title: 'Pembayaran Gagal');
      }
    } catch (error) {
      print(error.toString());
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      DialogTemp().Informasi(
          context: context,
          onYes: () {
            Navigator.pop(context);
          },
          onYesText: 'Oke',
          title: 'Pembayaran Gagal');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset('assets/images/qris.jpg'),
              SizedBox(height: 20),
              InkWell(
                onTap: () => showSheetImage(context),
                child: ImagePickerFrame(
                  hostedImage: null,
                  hintText: "Upload Bukti Pembayaran",
                  image: _image,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  radius: 20,
                ),
              ),
              const SizedBox(height: 20),
              // const Spacer(),
              ElevatedButton(
                onPressed: () {
                  print(_image?.path);
                  handlePayment();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Payment'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future showSheetImage(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 130,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_sharp,
                        size: 50,
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          "Galeri",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _pickImageFromCamera();
                  },
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 50,
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Text(
                          "Kamera",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
