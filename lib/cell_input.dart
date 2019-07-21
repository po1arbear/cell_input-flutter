import 'package:cell_input/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef InputCompleteCallback(String content);

class CellInput extends StatefulWidget {
  int cellCount = 6;
  InputType inputType = InputType.number;
  InputCompleteCallback inputCompleteCallback;
  bool autofocus = true;

  CellInput({Key key,this.cellCount = 6,
    this.inputType,
    this.autofocus = true,
    this.inputCompleteCallback}) :super(key:key);

  @override
  State<StatefulWidget> createState() {
    print('createState:' + inputType.toString());
    return _CellInputState(
        cellCount, inputType, autofocus, inputCompleteCallback);
  }
}

enum InputType {
  password,
  number,
  text,
}

class _CellInputState extends State<CellInput> {
  String inputStr = "";
  int _cellCount = 6;
  InputType _inputType = InputType.number;
  InputCompleteCallback _inputCompleteCallback;
  bool _autofocus = true;

  _CellInputState(this._cellCount, this._inputType, this._autofocus,
      this._inputCompleteCallback);

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 48,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getCells(),
          ),
          Container(
            height: 48,
            width: double.infinity,
            child: TextField(
              keyboardType: _keyboardType(),
              inputFormatters: [LengthLimitingTextInputFormatter(_cellCount)],
              decoration: InputDecoration(border: InputBorder.none),
              cursorWidth: 0,
              style: TextStyle(color: Colors.transparent),
              controller: _controller,
              autofocus: _autofocus,
              onChanged: (v) {
                setState(() {
                  inputStr = v;
                  if (v.length == _cellCount) {
                    if (_inputCompleteCallback != null) {
                      _inputCompleteCallback(v);
                    }
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  String getIndexStr(int index) {
    if (inputStr == null || inputStr.isEmpty) return "";
    if (inputStr.length > index) {
      if (_inputType == InputType.password) {
        return "●";
      } else {
        return inputStr[index];
      }
    } else {
      return "";
    }
  }

  TextInputType _keyboardType() {
    if (_inputType == InputType.number) {
      return TextInputType.number;
    } else if (_inputType == InputType.password) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  List<Widget> getCells() {
    var cells = <Widget>[];
    for (var i = 0; i < _cellCount; i++) {
      cells.add(Expanded(
        flex: 1,
        child: Center(
          child: Container(
            width: 42,
            height: 42,
            margin: EdgeInsets.only(left: 6, right: 6),
            alignment: Alignment.center,
            child: Text(
              getIndexStr(i),
              style: TextStyle(
                  fontSize: 22,
                  color: Utils.hexToColor('#1B1B4E'),
                  fontWeight: FontWeight.w600),
            ),
            decoration: BoxDecoration(
                color: Utils.hexToColor('#F5F6FB'),
                border: Border.all(width: 1, color: getBoarderColor(i)),
                borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ));
    }

    return cells;
  }

  Color getBoarderColor(int index) {
    if (inputStr == null || inputStr.isEmpty) {
      if (index == 0) {
        return Utils.getMainBlue();
      } else {
        return Utils.hexToColor('#F5F6FB');
      }
    } else {
      if (index == inputStr.length) {
        return Utils.getMainBlue();
      } else {
        return Utils.hexToColor('#F5F6FB');
      }
    }
  }
}
