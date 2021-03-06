import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../TextConverter.dart';

class Buttons extends StatefulWidget {
  final userTextController;
  final textConvertedController;
  final formKey;
  final Function apagarTextoHandler;
  Buttons({
    @required this.userTextController,
    @required this.textConvertedController,
    @required this.formKey,
    @required this.apagarTextoHandler
  });
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  String dropdownValue = 'Selecione';
  convertText(String str) {
    switch (dropdownValue) {
      case 'Reverso':
        return TextConverter.textReversed(str);
        break;
      case 'MAÍUSCULAS':
        return TextConverter.textToUpper(str);
        break;
      case 'minúsculas':
        return TextConverter.textToLower(str);
        break;
    }
  }

  static const List<String> opcoes = [
    'Selecione',
    'Reverso',
    'MAÍUSCULAS',
    'minúsculas',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 140,
            height: 43,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration.collapsed(hintText: ''),
                    validator: (value) =>
                        value == 'Selecione' ? 'Selecione um valor.' : null,
                    value: this.dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        this.dropdownValue = newValue;
                      });
                    },
                    items: opcoes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState.validate()) {
                    setState(() {
                      widget.textConvertedController.text =
                          convertText(widget.userTextController.text);
                    });
                  }
                },
                child: Icon(
                  Icons.sync,
                  color: Colors.white,
                  size: 26,
                  semanticLabel: 'Converter',
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Texto apagado.'),
                    ));
                    // widget.
                    widget.apagarTextoHandler();
                  }
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 26,
                  semanticLabel: 'Apagar',
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState.validate()) {
                    Clipboard.setData(
                      ClipboardData(text: widget.userTextController.text),
                    );
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Texto copiado.'),
                    ));
                  }
                },
                child: Icon(
                  Icons.content_copy,
                  color: Colors.white,
                  size: 26,
                  semanticLabel: 'Copiar',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
