import 'package:flutter/material.dart';

import'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:rickandmortyapi/detail_perso.dart';
//import 'package:rickandmortyapi/model/character.dart';

import 'model/resultat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List <Resultat> listPersonnage = [];
  late var jsonResponse;
  String apiAdresse = "https://rickandmortyapi.com/api/character";

  Future init(String adresseUrl) async {
    Uri url = Uri.parse(adresseUrl);
    http.Response responseAdresse = await http.get(url);

    jsonResponse =
    convert.jsonDecode(responseAdresse.body) as Map <String, dynamic>;
    int index = 0;
    while (index < jsonResponse["results"].length) {
      setState(() {
        Resultat resultat = Resultat.json(
            jsonResponse["results"][index] as Map<String, dynamic>);
        listPersonnage.add(resultat);
      });
      index++;
    }
    if (jsonResponse ['info']['next'] != null) {
      init(jsonResponse['info']['next']);
    }
  }

  @override void initState() {
    // TODO: implement initState
    init(apiAdresse);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: bodyPage());
  }

  Widget bodyPage() {
    return GridView.builder(
        itemCount: listPersonnage.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child:
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(listPersonnage[index].image),
                        fit: BoxFit.fill
                    )
                ),
                child: Column(
                    children: [
                      Text(listPersonnage[index].name,
                          style: TextStyle(color: Colors.blue)),
                    ]
                )),

            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) {
                    return detailPerso(perso: listPersonnage[index]);
                  }
              ));
            },
          );
        }
    );
  }

}
