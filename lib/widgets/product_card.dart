
import 'package:flutter/material.dart';
import '../models/produk.dart';

class ProductCard extends StatelessWidget {
  final Produk produk;
  final VoidCallback? onFavorit;
  final VoidCallback? onTambah;

  const ProductCard({
    super.key,
    required this.produk,
    this.onFavorit,
    this.onTambah,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.blueGrey.shade100,
        ),
      ),
      child: ListTile(
        title: Text(
          produk.nama,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text('Rp${produk.harga}'),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.teal,
                size: 20,
              ),
              tooltip: 'Simpan Favorit',
              onPressed: onFavorit,
            ),

            IconButton(
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.teal,
                size: 20,
              ),
              tooltip: 'Tambah Keranjang',
              onPressed: onTambah,
            ),
          ],
        ),
      ),
    );
  }
}
