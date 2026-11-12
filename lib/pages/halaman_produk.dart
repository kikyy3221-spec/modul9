
import 'package:flutter/material.dart';

import '../models/produk.dart';
import '../models/produk_favorit.dart';
import '../widgets/product_card.dart';
import '../helpers/hive_helper.dart';

class HalamanProduk extends StatelessWidget {
  const HalamanProduk({super.key});

  final List<Produk> daftarProduk = const [
    Produk(
      id: 'P001',
      nama: 'Nasi Goreng',
      harga: 15000,
    ),
    Produk(
      id: 'P002',
      nama: 'Mie Ayam',
      harga: 12000,
    ),
    Produk(
      id: 'P003',
      nama: 'Es Teh',
      harga: 5000,
    ),
  ];

  Future<void> simpanFavorit(Produk produk) async {
    if (boxFavorit.containsKey(produk.id)) return;

    final favorit = ProdukFavorit(
      idProduk: produk.id,
      nama: produk.nama,
      harga: produk.harga,
    );

    await boxFavorit.put(produk.id, favorit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk Kantin'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarProduk.length,
        itemBuilder: (context, index) {
          final produk = daftarProduk[index];

          return ProductCard(
            produk: produk,
            onFavorit: () async {
              await simpanFavorit(produk);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Produk berhasil ditambahkan ke favorit',
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
