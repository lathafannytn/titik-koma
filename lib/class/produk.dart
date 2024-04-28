class Produk {
  final int id;
  final String nama;
  final int harga;
  final String deskripsi;

  Produk({required this.id, required this.nama, required this.harga, required this.deskripsi});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      deskripsi: json['deskripsi'] ?? '',
    );
  }
}
