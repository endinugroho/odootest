import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'editmode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Odoo System',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Odoo System Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var purchase;
  List<dynamic> purchase2 = [];

  @override
  void initState() {
    ambildata();
  }


  void ambildata() async {
    var headers = {
      'Content-Type': 'application/json'
      // 'Cookie': 'session_id=92d711170d6f90bcd847f8dd3bd336554cd6ce9b'
    };
    var request = http.Request('GET', Uri.parse('http://192.168.1.5:8070/web/test2'));
    request.body = json.encode({
      "params": {}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseString);

      setState(() {
        // purchase = jsonResponse;
        if (jsonResponse['result'] != null && jsonResponse['result']['data'] != null) {
          purchase2 = jsonResponse['result']['data'];
          print(purchase2);
        }
        // print(jsonResponse['result']['data']);
      });    }
    else {
    print(response.reasonPhrase);
    }

  }
  void _incrementCounter() {
    ambildata();
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void tampilkan() {
    print(purchase['result']['data']);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Lisit FRQ',
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return EditMode('1','2');
                    }),
                  );

                }, child:
              Image.asset(
                "assets/add.png",
                width: 30,
              ),
              ),


            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 600,
              child:
              ListView(
                padding: const EdgeInsets.all(8),
                children:
                // <Widget>[
                purchase2.map((aa)=>
                    Container(
                      height: 100,
                      // color: Colors.amber[600],
                      child: Column(
                        children: [
                          Center(child: Text("Reference : "+aa['kode_po']+", Vendor :"+aa['partner_vendor']+", buyer :"+aa['buyer']+", status po :"+aa['status_po']+", nominal po:"+aa['nominal_po'].toString())),
                          Row(
                            children: [
                              Image.asset(
                                "assets/edit.png",
                                width: 30,
                              ),
                              SizedBox(width: 5),
                              Image.asset(
                                "assets/delete.png",
                                width: 30,
                              ),
                            ],
                          ),

                        ],
                      ),
                    )
                ).toList(),
              // ]
              ),
            ),
          )
          // Expanded(
          //   child: purchase2.isEmpty
          //       ? Center(
          //     child: Text('No data available'),
          //   )
          //       : ListView.builder(
          //     padding: const EdgeInsets.all(8),
          //     itemCount: purchase2.length,
          //     itemBuilder: (context, index) {
          //       var item = purchase2[index];
          //       return Container(
          //         height: 50,
          //         child: Center(child: Text(item['kd_po'] ?? "")),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ambildata,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
