
import 'package:flutter/material.dart';
import '../helpers/pengaturan_helper.dart';

class HalamanNama extends StatefulWidget {
  const HalamanNama({super.key});

  @override
  State<HalamanNama> createState() => _HalamanNamaState();
}

class _HalamanNamaState extends State<HalamanNama> {
  late TextEditingController controllerNama;

  @override
  void initState() {
    super.initState();

    controllerNama = TextEditingController(
      text: PengaturanHelper.muatNama(),
    );
  }

  @override
  void dispose() {
    controllerNama.dispose();
    super.dispose();
  }

  Future<void> simpanNama() async {
    await PengaturanHelper.simpanNama(controllerNama.text);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nama pelanggan berhasil disimpan'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nama Pelanggan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controllerNama,
              decoration: const InputDecoration(
                labelText: 'Nama pelanggan',
                hintText: 'Masukkan nama pelanggan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: simpanNama,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
