import 'package:flutter/material.dart';

void showCongratulationsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Задача выполнена!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Ты молодец, так держать!'),
            Image.network(
              'https://media.tenor.com/lCKwsD2OW1kAAAAj/happy-cat-happy-happy-cat.gif',
              fit: BoxFit.cover,
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Закрыть'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
