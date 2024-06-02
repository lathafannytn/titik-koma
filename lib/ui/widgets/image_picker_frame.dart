import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePickerFrame extends StatelessWidget {
  final File? image;
  final String? hostedImage, hintText, imageWeb;
  final double? width, height, radius;

  ImagePickerFrame({
    Key? key,
    this.image,
    this.imageWeb,
    this.hostedImage,
    this.hintText,
    required this.width,
    @required this.height,
    @required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(this.radius ?? 20)),
      child: this.imageWeb != null
          ? Image.network(imageWeb!,
              fit: BoxFit.cover, width: this.width, height: this.height)
          : this.image != null
              ? Image.file(
                  image!,
                  fit: BoxFit.cover,
                  width: this.width,
                  height: this.height,
                )
              : this.hostedImage != null
                  ? Image(
                      loadingBuilder: (BuildContext? context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            height: this.height ?? null,
                            width: this.height ?? this.width,
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      },
            
                      image: NetworkImage(hostedImage!),
                      height: this.height ?? null,
                      fit: BoxFit.cover,
                      width: this.width)
                  : DottedBorder(
                      // color: Colors.grey[500],
                      dashPattern: [3, 8],
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(this.radius ?? 20)),
                        child: Container(
                          width: this.width,
                          height: this.height,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   FlutterIcons.upload_fea,
                              //   color: Colors.grey[500],
                              //   size: 26.0,
                              // ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  this.hintText ?? "Unggah Gambar",
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: const Text(
                                  "Maksimal ukuran file 2MB",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}
