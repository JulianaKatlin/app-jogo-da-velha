import 'package:flutter/material.dart';

void main() {
  runApp(JogoDaVelha());
}

class JogoDaVelha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha Talento Tech',
      home: Tabuleiro(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Tabuleiro extends StatefulWidget {
  @override
  _TabuleiroState createState() => _TabuleiroState();
}

class _TabuleiroState extends State<Tabuleiro> {
  List<String> _board = List.filled(9, "");
  String _currentPlayer = "X";
  String? _winner;

  void _play(int index) {
    if (_board[index] == "" && _winner == null) {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWinner(_currentPlayer)) {
          _winner = _currentPlayer;
        } else if (!_board.contains("")) {
          _winner = "Empate";
        }
        _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      });
    }
  }

  bool _checkWinner(String player) {
    // Condições de vitória
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (_board[condition[0]] == player &&
          _board[condition[1]] == player &&
          _board[condition[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, "");
      _currentPlayer = "X";
      _winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jogo da Velha - Talento Tech PR')),
      body: Center(
        child: Container(
          width: 300, // Define uma largura fixa para o tabuleiro
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _play(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(
                          child: Text(
                            _board[index],
                            style: TextStyle(fontSize: 32), // Reduz o tamanho do texto
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              if (_winner != null)
                Text(
                  _winner == "Empate" ? "Empate!" : "Vencedor: $_winner",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              if (_winner == null)
                Text(
                  "Jogador Atual: $_currentPlayer",
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetGame,
                child: Text('Reiniciar Jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
