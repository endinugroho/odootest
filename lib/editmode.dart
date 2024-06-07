import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'main.dart';

class EditMode extends StatelessWidget {
  String kd_contact;
  String dari;
  EditMode(this.kd_contact,this.dari);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(this.kd_contact,this.dari),
    );
  }
}


class Body extends StatefulWidget {
  String kd_contact;
  String dari;

  Body(this.kd_contact,this.dari);
  @override
  _Body createState() => _Body();
}

class _Body extends  State<Body>  {
  double _height=0;
  double _width=0; //lebar screen
  List<dynamic> product = [];
  List<dynamic> partner = [];
  List<dynamic> buyer = [];
  String selectproduct="";
  String selectpartner="";
  String selectbuyer="";
  String selectjumlah="1";
  String selectcurrency="IDR";
  TextEditingController vendorreference=TextEditingController();
  TextEditingController _dateController1 = TextEditingController();
  TextEditingController _dateController2 = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  List<Map<String, String>> listproduct = [];

  var currencies = [{"cur": "USD","value":0}, {"cur": "IDR","value":1}];
  var jumprod = [{"jum": "1","jumn":1},{"jum": "2","jumn":2},{"jum": "3","jumn":3},{"jum": "4","jumn":4},{"jum": "5","jumn":5} ];

  @override
  void initState() {
    ambildata();
  }

  void _addPProductFields() {
    setState(() {
      listproduct = List.generate(int.parse(selectjumlah), (index) => {"namaproduct": "", "jumlah": ""});
    });
  }


  void ambildata() async {

    var headers = {
      'Content-Type': 'application/json'
      // 'Cookie': 'session_id=92d711170d6f90bcd847f8dd3bd336554cd6ce9b'
    };
    var request = http.Request('GET', Uri.parse('http://192.168.1.5:8070/web/testprod'));
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
          product = jsonResponse['result']['data'];
          selectproduct = product[0]['id'].toString();
          print(product);
        }
        // print(jsonResponse['result']['data']);
      });    }
    else {
      print(response.reasonPhrase);
    }

    var request2 = http.Request('GET', Uri.parse('http://192.168.1.5:8070/web/testpartner'));
    request2.body = json.encode({
      "params": {}
    });
    request2.headers.addAll(headers);

    http.StreamedResponse response2 = await request2.send();

    if (response2.statusCode == 200) {
      var responseString2 = await response2.stream.bytesToString();
      var jsonResponse2 = jsonDecode(responseString2);

      setState(() {
        // purchase = jsonResponse;
        if (jsonResponse2['result'] != null && jsonResponse2['result']['data'] != null) {
          partner = jsonResponse2['result']['data'];
          selectpartner = partner[0]['id'].toString();
          print(partner);
        }
        // print(jsonResponse['result']['data']);
      });    }
    else {
      print(response.reasonPhrase);
    }

    var request3 = http.Request('GET', Uri.parse('http://192.168.1.5:8070/web/testbuyer'));
    request3.body = json.encode({
      "params": {}
    });
    request3.headers.addAll(headers);

    http.StreamedResponse response3 = await request3.send();

    if (response3.statusCode == 200) {
      var responseString3 = await response3.stream.bytesToString();
      var jsonResponse3 = jsonDecode(responseString3);

      setState(() {
        // purchase = jsonResponse;
        if (jsonResponse3['result'] != null && jsonResponse3['result']['data'] != null) {
          buyer = jsonResponse3['result']['data'];
          selectbuyer = buyer[0]['id'].toString();
          // print(partner);
        }
        // print(jsonResponse['result']['data']);
      });    }
    else {
      print(response3.reasonPhrase);
    }


  }

  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1930),
        lastDate: DateTime(2100));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController1.text = DateFormat("dd/MM/yyyy").format(selectedDate);
      });
  }

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1930),
        lastDate: DateTime(2100));
    if (picked != null)
      setState(() {
        selectedDate2 = picked;
        _dateController2.text = DateFormat("dd/MM/yyyy").format(selectedDate2);
      });
  }

  final rowSpacer=TableRow(
      children: [
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 15,
        )
      ]);
  final rowSpacer2=TableRow(
      children: [
        SizedBox(
          height: 10,
        )
      ]);



  void save() async {
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                // Image.asset(
                //   "assets/images/028b card form masuk LEADS2.png",
                //   // width: 50,
                // ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 30, right: 40),
                    child:
                    Table(
                        children: [
                          TableRow(
                              children: [
                                Text("Vendor",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(
                                            158, 191, 224, 1),
                                        fontStyle: FontStyle.italic))

                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: _width * .9,
                                  child:
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.0),
                                      // border: Border.all(
                                      //     color: Color.fromRGBO(41, 170, 184, 1), style: BorderStyle.solid, width: 1.00),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              125, 163, 201, 1),
                                          style: BorderStyle.solid,
                                          width: 1.00),
                                    ), child:

                                  // Text("")
                                  // hobi=="0" || hobi==null ? Text(""):
                                  DropdownButton<String>(
                                    value: selectpartner,
                                    onChanged: (String? value) async {
                                      setState(() {
                                        selectpartner = value!;
                                      });
                                    },
                                    items: partner.map((aa) {
                                      return DropdownMenuItem<String>(
                                        child: Text(aa['name'],
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  51, 102, 153, 1),
                                            )),
                                        value: aa['id'].toString(),
                                      );
                                    }).toList(),
                                  ),

                                  ),
                                ),


                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                TextField(
                                  // obscureText: true,
                                  controller: vendorreference,
                                  // onChanged: (value) {
                                  //   address = value;
                                  // },
                                  decoration: InputDecoration(
                                    // border: OutlineInputBorder(),
                                    labelText: 'Vendor Reference',
                                    labelStyle: TextStyle(
                                      color: Color.fromRGBO(
                                          156, 190, 224, 1),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),





                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                Text("Order Daeadline",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(
                                            158, 191, 224, 1),
                                        fontStyle: FontStyle.italic))





                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [

                                SizedBox(
                                  height: 30,
                                  width: _width*.25,
                                  child:


                                  InkWell(
                                    onTap: () {
                                      _selectDate1(context);
                                      FocusScope.of(context).unfocus();
                                      new TextEditingController().clear();
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      // margin: EdgeInsets.only(top: 30),
                                      // alignment: Alignment.center,
                                      // decoration: BoxDecoration(color: Colors.grey[200]),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.left,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _dateController1,
                                        // onSaved: (String val) {
                                        //   _setDate1 = val;
                                        // },
                                        decoration: InputDecoration(
                                          disabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),borderSide: BorderSide(
                                            color: Color.fromRGBO(125, 163, 201, 1),
                                            width: 1.0,
                                          ),),

                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.orange,width: 5),

                                          ) ,                        // border: const OutlineInputBorder(),
                                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0)),

                                          // labelText: 'Begin Date',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),




                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                Text("Expected Arrival",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(
                                            158, 191, 224, 1),
                                        fontStyle: FontStyle.italic))





                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [

                                SizedBox(
                                  height: 30,
                                  width: _width*.25,
                                  child:


                                  InkWell(
                                    onTap: () {
                                      _selectDate2(context);
                                      FocusScope.of(context).unfocus();
                                      new TextEditingController().clear();
                                    },
                                    child: Container(
                                      width: 150,
                                      height: 40,
                                      // margin: EdgeInsets.only(top: 30),
                                      // alignment: Alignment.center,
                                      // decoration: BoxDecoration(color: Colors.grey[200]),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.left,
                                        enabled: false,
                                        keyboardType: TextInputType.text,
                                        controller: _dateController2,
                                        // onSaved: (String val) {
                                        //   _setDate1 = val;
                                        // },
                                        decoration: InputDecoration(
                                          disabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0),borderSide: BorderSide(
                                            color: Color.fromRGBO(125, 163, 201, 1),
                                            width: 1.0,
                                          ),),

                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.orange,width: 5),

                                          ) ,                        // border: const OutlineInputBorder(),
                                          border: OutlineInputBorder(borderRadius:BorderRadius.circular(10.0)),

                                          // labelText: 'Begin Date',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),




                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                Text("Buyer",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(
                                            158, 191, 224, 1),
                                        fontStyle: FontStyle.italic))

                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: _width * .9,
                                  child:
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.0),
                                      // border: Border.all(
                                      //     color: Color.fromRGBO(41, 170, 184, 1), style: BorderStyle.solid, width: 1.00),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              125, 163, 201, 1),
                                          style: BorderStyle.solid,
                                          width: 1.00),
                                    ), child:

                                  // Text("")
                                  // hobi=="0" || hobi==null ? Text(""):
                                  DropdownButton<String>(
                                    value: selectbuyer,
                                    onChanged: (String? value) async {
                                      setState(() {
                                        selectbuyer = value!;
                                      });
                                    },
                                    items: buyer.map((aa) {
                                      return DropdownMenuItem<String>(
                                        child: Text(aa['name'],
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  51, 102, 153, 1),
                                            )),
                                        value: aa['id'].toString(),
                                      );
                                    }).toList(),
                                  ),

                                  ),
                                ),


                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                Text("Currency",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(
                                            158, 191, 224, 1),
                                        fontStyle: FontStyle.italic))

                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: _width * .9,
                                  child:
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.0),
                                      // border: Border.all(
                                      //     color: Color.fromRGBO(41, 170, 184, 1), style: BorderStyle.solid, width: 1.00),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              125, 163, 201, 1),
                                          style: BorderStyle.solid,
                                          width: 1.00),
                                    ), child:

                                  // Text("")
                                  // hobi=="0" || hobi==null ? Text(""):
                                  DropdownButton<String>(
                                    value: selectcurrency,
                                    onChanged: (String? value) async {
                                      setState(() {
                                        selectcurrency = value!;
                                      });
                                    },
                                    items: currencies.map((aa) {
                                      return DropdownMenuItem<String>(
                                        child: Text(aa['cur'].toString(),
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  51, 102, 153, 1),
                                            )),
                                        value: aa['cur'].toString(),
                                      );
                                    }).toList(),
                                  ),

                                  ),
                                ),


                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                Text("Jumlah Produk",
                                    style: const TextStyle(
                                        color: Color.fromRGBO(
                                            158, 191, 224, 1),
                                        fontStyle: FontStyle.italic))

                              ]),
                          rowSpacer2,
                          TableRow(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: _width * .9,
                                  child:
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.0),
                                      // border: Border.all(
                                      //     color: Color.fromRGBO(41, 170, 184, 1), style: BorderStyle.solid, width: 1.00),
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              125, 163, 201, 1),
                                          style: BorderStyle.solid,
                                          width: 1.00),
                                    ), child:

                                  // Text("")
                                  // hobi=="0" || hobi==null ? Text(""):
                                  DropdownButton<String>(
                                    value: selectjumlah,
                                    onChanged: (String? value) async {
                                      setState(() {
                                        selectjumlah = value!;
                                        _addPProductFields();
                                      });
                                    },
                                    items: jumprod.map((aa) {
                                      return DropdownMenuItem<String>(
                                        child: Text(aa['jum'].toString(),
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  51, 102, 153, 1),
                                            )),
                                        value: aa['jum'].toString(),
                                      );
                                    }).toList(),
                                  ),

                                  ),
                                ),


                              ]),

                        ],
                      ),
              ),
                ...listproduct.asMap().entries.map((entry) {
                  int idx = entry.key;
                  return Padding(
                  padding: EdgeInsets.only(
                  top: 500+idx*150, left: 30, right: 40),
                    child: Column(
                      children: [
                    Table(
                    children: [
                    TableRow(
                    children: [
                        Text("Nama Produk",
                        style: const TextStyle(
                            color: Color.fromRGBO(
                                158, 191, 224, 1),
                            fontStyle: FontStyle.italic))

                      ]),
                    rowSpacer2,
                    TableRow(
                        children: [
                          SizedBox(
                            height: 30,
                            width: _width * .9,
                            child:
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10.0),
                                // border: Border.all(
                                //     color: Color.fromRGBO(41, 170, 184, 1), style: BorderStyle.solid, width: 1.00),
                                border: Border.all(
                                    color: Color.fromRGBO(
                                        125, 163, 201, 1),
                                    style: BorderStyle.solid,
                                    width: 1.00),
                              ), child:

                            // Text("")
                            // hobi=="0" || hobi==null ? Text(""):
                            DropdownButton<String>(
                              value: listproduct[idx]['name'],
                              onChanged: (String? value) async {
                                setState(() {
                                  listproduct[idx]['name'] = value!;
                                  // _addPProductFields();
                                });
                              },
                              items: product.map((aa) {
                                return DropdownMenuItem<String>(
                                  child: Text(aa['product_name'].toString(),
                                      style: const TextStyle(
                                        color: Color.fromRGBO(
                                            51, 102, 153, 1),
                                      )),
                                  value: aa['id'].toString(),
                                );
                              }).toList(),
                            ),

                            ),
                          ),


                        ]),
                      TableRow(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Jumlah'),
                              onSaved: (value) {
                                listproduct[idx]['jumlah'] = value!=null?value:"";
                              },
                              validator: (value) {
                                if (value=="") {
                                  return 'Jumlah harus diisi';
                                }
                                return null;
                              },
                            ),

                          ]),
                      rowSpacer2,
                    ]
                  ),
                        // TextFormField(
                        //   decoration: InputDecoration(labelText: 'Nama Peserta ${idx + 1}'),
                        //   onSaved: (value) {
                        //     listproduct[idx]['name'] = value!=null?value:"";
                        //   },
                        //   validator: (value) {
                        //     if (value=="") {
                        //       return 'Nama harus diisi';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // TextFormField(
                        //   decoration: InputDecoration(labelText: 'Alamat Peserta ${idx + 1}'),
                        //   onSaved: (value) {
                        //     listproduct[idx]['address'] = value!=null?value:"";
                        //   },
                        //   validator: (value) {
                        //     if (value=="") {
                        //       return 'Alamat harus diisi';
                        //     }
                        //     return null;
                        //   },
                        // ),


                      ],
                    ),
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 800.0, left: 130, right: 0),
                  child:
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) {
                          return MyApp();
                        }),
                      );

                    }, child:
                  Image.asset(
                    "assets/SAVE.png",
                    width: 100,
                  ),
                  ),
                ),

          ],
        ),
        ]
      ),
      )
    );
  }
}
