import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

class GeneralPage extends StatefulWidget {
  const GeneralPage({Key? key}) : super(key: key);

  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  FirebaseFunctions functions = FirebaseFunctions.instance;
  String message = 'Loading...';

  Future<void> getMessage() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('sayHello');
    final results = await callable();
    setState(() {
      message = results.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 150),
      color: Colors.orange,
      child: Text(
        message,
      ),
    );
  }
}
