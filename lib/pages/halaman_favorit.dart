
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../helpers/hive_helper.dart';
import '../models/produk_favorit.dart';

class HalamanFavorit extends StatelessWidget {
  const HalamanFavorit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Favorit'),
      ),
      body: ValueListenableBuilder<Box<ProdukFavorit>>(
        valueListenable: boxFavorit.listenable(),
        builder: (context, box, _) {
          final daftarFavorit = box.values.toList();

          if (daftarFavorit.isEmpty) {
            return const Center(
              child: Text('Belum ada produk favorit'),
            );
          }

          return ListView.builder(
            itemCount: daftarFavorit.length,
            itemBuilder: (context, index) {
              final favorit = daftarFavorit[index];

              return ListTile(
                title: Text(favorit.nama),
                subtitle: Text(
                  'Rp ${favorit.harga}\n'
                  'Catatan: ${favorit.catatan.isEmpty ? '-' : favorit.catatan}',
                ),
                isThreeLine: true,
                onTap: () => _editCatatan(context, favorit),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  tooltip: 'Hapus favorit',
                  onPressed: () {
                    box.delete(favorit.idProduk);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> _editCatatan(
  BuildContext context,
  ProdukFavorit favorit,
) async {
  final hasil = await showDialog<String>(
    context: context,
    builder: (context) {
      final controller = TextEditingController(
        text: favorit.catatan,
      );

      return AlertDialog(
        title: const Text('Edit Catatan'),
        content: TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Catatan produk',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, controller.text);
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  );

  if (hasil == null || !favorit.isInBox) return;

  favorit.catatan = hasil;
  await favorit.save();
}
