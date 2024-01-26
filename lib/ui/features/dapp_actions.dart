import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DappActions extends StatefulWidget {

  static const String route = "dappActions";


  const DappActions({super.key});
  @override
  State<DappActions> createState() => _DappActionsState();
}

class _DappActionsState extends State<DappActions> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        Container(
        width: 450,
        child: Center(
          child: Text("Send Message",style: TextStyle(
              fontSize: 25,
              color: Colors.white
          ),),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15)
        ),
      ),
        Container(
          width: 450,
          child: Center(
            child: Text("Send Transaction",style: TextStyle(
                fontSize: 25,
                color: Colors.white
            ),),
          ),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15)
          ),
        ),
        Container(
          width: 450,
          child: Center(
            child: Text("Switch Chain",style: TextStyle(
                fontSize: 25,
                color: Colors.white
            ),),
          ),
          decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15)
          ),
        )
        ],
      ),
    )
    );
  }
}
