
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});

  @override
  State<HalamanPengaturan> createState() =>
      _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  late TextEditingController _namaController;

  @override
  void initState() {
    super.initState();

    _namaController = TextEditingController(
      text: PengaturanHelper.muatNama(),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    super.dispose();
  }

  // Menampilkan nama pelanggan yang sudah disimpan
  void lihatNama() {
    final String nama = PengaturanHelper.muatNama();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nama Pelanggan'),
          content: Text(
            nama.isEmpty ? 'Nama pelanggan belum diisi.' : nama,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = context.watch<ThemeCubit>();
    final gelap = tema.state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Mode Gelap'),
            subtitle: const Text(
              'Aktifkan atau nonaktifkan tema gelap',
            ),
            value: gelap,
            onChanged: tema.setGelap,
          ),

          const Divider(),

          const Text(
            'Nama Pelanggan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _namaController,
            decoration: const InputDecoration(
              labelText: 'Masukkan nama pelanggan',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          // Tombol simpan nama
          FilledButton(
            onPressed: () async {
              await PengaturanHelper.simpanNama(
                _namaController.text,
              );

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Nama pelanggan berhasil disimpan',
                  ),
                ),
              );
            },
            child: const Text('Simpan Nama'),
          ),

          const SizedBox(height: 8),

          // Tombol lihat nama
          OutlinedButton.icon(
            onPressed: lihatNama,
            label: const Text('Lihat Nama'),
          ),

          const SizedBox(height: 16),

          // Tombol reset pengaturan
          OutlinedButton(
            onPressed: () async {
              await tema.reset();
              _namaController.clear();

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Pengaturan berhasil direset',
                  ),
                ),
              );
            },
            child: const Text('Reset Pengaturan'),
          ),
        ],
      ),
    );
  }
}
