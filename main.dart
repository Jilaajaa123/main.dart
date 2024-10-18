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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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
    current = WordPair.random();
    notifyListeners();
  }
}

//membuat layout pada halaman HomePage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); //widget menggunakan state MyAppState 
    //

    return Scaffold( //base (canvas) dari layout
      body: Column( //diatas scaffold, ada body. body-nya, diberi kolom
        children: [ //didalam kolom, diberi teks
          Text('A random idea:'),
          Text(appState.current.asLowerCase), //mengambil random teks dari AppState pada variabel WordPair  current, lalu diubah menjadi huruf kecil  semua, dan ditampilkan sebagi teks
          ElevatedButton( //membuat button timbul didalam body
            onPressed: () { //fungsi yg di eksekusi ketika button ditekan
              print('button pressed!'); //tampilkan teks 'button pressed' di terminal saat button ditekan
            },
            child: Text('Next'), //berikan teks 'Next' pada button (sebagai child) 
          ),
        ],
      ),
    );
  }
}