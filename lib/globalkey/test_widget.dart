import 'package:cell_input/globalkey/button.dart';
import 'package:cell_input/globalkey/text.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<TestWidget> {
  int _count=0;
  GlobalKey<TextWidgetState> textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextWidget(textKey),
          SizedBox(height: 20,),

          Text(_count.toString(),style: TextStyle(fontSize: 20),), ///这个Text不会刷新，只会刷新上面的TextWidget
         SizedBox(height: 20,),
          ButtonWidget(
            onPressed: () {
              ///点击button，调用TextWidget的onPressed方法
              ///在TextWidget的onPressed中单独调用TextWidget的setState，
              _count++;
              textKey.currentState.onPressed(_count);
            },
          )
        ],
      ),
    );
  }
}
