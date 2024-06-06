import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  var _resultText = "Vamos Jogar!";
  var _placarJogador = 0;
  var _placarApp = 0;
  var _imgJogador = 0;
  var _imgApp = 2;
  var _colorResult = 0xFF448AFF;
  var _textStart = "Faça sua escolha!";
  var _alinhamento = Alignment.center;

  int gameLogic(int playerNum, int appNum) {
    if (playerNum == appNum) {
      return -1;
    } else {
      switch (playerNum) {
        case 0:
          if (appNum == 1)
            return 0;
          else
            return 1;
        case 1:
          if (appNum == 0)
            return 1;
          else
            return 0;
        case 2:
          if (appNum == 0)
            return 0;
          else
            return 1;
      }
    }
    return -1;
  }

  void _gameResult(int playerChoice) {
    final appChoice = Random().nextInt(3);
    setState(() {
      _imgJogador = playerChoice;
      _imgApp = appChoice;
    });
    var result = gameLogic(playerChoice, appChoice);
    if (result == -1) {
      setState(() {
        _resultText = "Rodada Empatada";
        _colorResult = 0xFF0000FF;
        _alinhamento = Alignment.center;
      });
    } else if (result == 0) {
      setState(() {
        _resultText = "App Ganhou!";
        _placarApp++;
        _colorResult = 0xFFFF0000;
        _alinhamento = Alignment.centerRight;
      });
    } else if (result == 1) {
      setState(() {
        _resultText = "Você Ganhou!";
        _placarJogador++;
        _colorResult = 0xFF00FF00;
        _textStart = "Jogue novamente!";
        _alinhamento = Alignment.centerLeft;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "JoKenPo",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          color: Color(0xFF00004B),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Você $_placarJogador x $_placarApp App",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 200,
                        alignment: this._alinhamento,
                        child: Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 50,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image(
                              image: AssetImage("images/${_imgJogador}.png"),
                              width: 150,
                            ),
                            Text(
                              "Você",
                              style: TextStyle(color: Colors.lightBlueAccent),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image(
                              image: AssetImage("images/${_imgApp}.png"),
                              width: 150,
                            ),
                            Text(
                              "App",
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "$_resultText",
                    style: TextStyle(
                      color: Color(_colorResult),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$_textStart",
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => _gameResult(0),
                    child: Image(
                      image: AssetImage("images/0.png"),
                      width: 75,
                    ),
                  ),
                  InkWell(
                    onTap: () => _gameResult(1),
                    child: Image(
                      image: AssetImage("images/1.png"),
                      width: 75,
                    ),
                  ),
                  InkWell(
                      onTap: () => _gameResult(2),
                      child: Image(
                        image: AssetImage("images/2.png"),
                        width: 75,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
