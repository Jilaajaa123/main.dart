//memasukkan package yang dibutuhkan oleh aplikasi
import 'package:english_words/english_words.dart'; //paket bahasa nggris
import 'package:flutter/material.dart'; //paket untuk tampilan UI (material UI)
import 'package:provider/provider.dart'; //paket interaksi


void main() {
  runApp(MyApp());
}

//membuat abstrak aplikasi dari statelessWidget (template aplikasi),aplikasinya bernama MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key}); //menunjukkan aplikasi bahwa aplikasi ini akan tetap, tidak berubah setelah di-build

  @override //mengganti nilai lama yg sudah ada di template, dengan nilai-nilai yg baru (replace / overwrite)
  Widget build(BuildContext context) { 
    //fungsi build adalah fungsi yg membangun UI (mengatur posisi widget, dst)
    //ChangeNotifierProvider mendengarkan/mendeteksi semua interaksi yg tejadi di aplikasi
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), //membuat satu state bernama MyAppState
      child: MaterialApp( //pada state ini, menggunakan style desain MaterialUI
        title: 'Namer App', //diberi judul Namer App
        theme: ThemeData( //data tema apliksi, diberi nama deepOrange
          useMaterial3: true, //versi materialUI yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 108, 196, 41)),
        ),
        home: MyHomePage(), //nama halaman "MyHomePage" yang menggunakan state "MyAppState"
      ),
    );
  }
}

//mendefinisikan MyAppState
class MyAppState extends ChangeNotifier {
  //state MyAppState diisi dengan 2 kata random yang digabung. kata random tsb disimpan di variable WordPair
  var current = WordPair.random();
    void getNext() {
    current = WordPair.random();//acak kata 
    notifyListeners();//kirim kata yang diacak ke listener untuk ditampilkan di layar
  }
  //membuat variable bertipe "list"/daftar bernama favorites untuk menyimpan daftar kata yang di-like
  var favorites = <WordPair>[];
  
   //fungsi untuk menambahkan kata ke dalam, atau menghapus kata dari list favorite
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);//menghapus list kata dari list favorite
    } else {
      favorites.add(current);//menambahkan kata ke list favorite
    }
    notifyListeners();//menempelkan fungsi ini ke button like supaya button like bisa mengetahui jika dirinya ditekan 
  }
}

//membuat layout pada halaman HomePage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); //widget menggunakan state MyAppState 
    var pair = appState.current;  

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold( //base (canvas) dari layout
      body: Center(
        child: Column( //diatas scaffold, ada body. body-nya, diberi kolom
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ //didalam kolom, diberi teks
            BigCard(pair: pair),  //mengambil random teks dari AppState pada variabel WordPair  current, lalu diubah menjadi huruf kecil  semua, dan ditampilkan sebagi teks
            SizedBox(height: 10),
            Row(//mengubah layout buttonmenjadi row/baris
              mainAxisAlignment: MainAxisAlignment.center, //memposisikan 
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text('Like'),
                ),
                ElevatedButton( //membuat button timbul didalam body
                  onPressed: () { //fungsi yg di eksekusi ketika button ditekan
                    print('button pressed!'); //tampilkan teks 'button pressed' di terminal saat button ditekan
                  },
                  child: Text('Next'), //berikan teks 'Next' pada button (sebagai child) 
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context); //menambahkan tema pada card
     //membuat styel untuk teks,diberi mama styel.styel warna mengikuti parrent

     final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card( //membungkus padding didalam widget card
     color: theme.colorScheme.primary, 

     child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase),
        //mengubah kata dalam pair menjadi huruf kecil
      ),
    );
  }
}
