import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rickandmortyapi/model/resultat.dart';

class detailPerso extends StatefulWidget{
  Resultat perso;
  detailPerso({required Resultat this.perso});
  @override
    State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailPersoState();
  }
}

class detailPersoState extends State<detailPerso> {
  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.perso.name),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/4,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image:  NetworkImage(widget.perso.image), fit:BoxFit.fill
            )
          ),
        ),
        Text(widget.perso.status),
        Text(widget.perso.species),
        (widget.perso.gender=='Male')? const Icon(Icons.male,size:30) : const Icon(Icons.female,size:30),
        Text(widget.perso.type),
      ],
    );
  }
}