import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:worktopuser/view/home/home.dart';
import 'package:worktopuser/view/home/navbar.dart';
import 'package:worktopuser/controller/facilitiescontroller.dart';
import 'package:worktopuser/api/api.dart';
import 'package:worktopuser/model/facilitiesmodel.dart';
import 'package:worktopuser/model/locationmodel.dart';
import 'package:worktopuser/api/secure_storage.dart';
import 'package:worktopuser/model/ordermodel.dart';
import 'package:g_json/g_json.dart';

class Home1 extends StatefulWidget {
  List<FacilitiesModel> sfacilities = [];
  List<Locationmodel> slocation = [];
  String FacilityId;

  Home1(this.sfacilities, this.slocation, this.FacilityId, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<Home1> {
  int currentindex = 0;
  late Future facilities;
  late Future sample;
  late Future orders;
  List<FacilitiesController> myList = [];
  List<OrderModel> orderList = [];
  String sName = '';
  String sAddress = '';
  String sDescription = '';
  String sArea = '';
  String sCity = '';
  String sCoverImagePath = '';
  final _token = TextEditingController();
  // final Future<String> loadData = Future<String>.delayed(
  //   const Duration(seconds: 0),
  //   () => 'Data Loaded',
  // );

  @override
  void initState() {
    myList = [];
    orderList = [];
    facilities = getFacility();
    orders = getOrders();
    super.initState();

    init();
    getOrderslist();
  }

  Future init() async {
    final token = await UserSecureStorage.gettoken() ?? '';

    setState(() {
      _token.text = token;
    });
  }

  Future<List<FacilitiesController>> getFacility() async {
    final response = await http.get(Uri.parse(ApiCon.baseurl + '/places'));
    var jsondata = json.decode(response.body);
    for (var u in jsondata) {
      String name = '',
          address = '',
          description = '',
          area = '',
          city = '',
          coverImagePath = '';

      if (u['name'] != null) {
        name = u['name'];
      } else {
        name = '';
      }
      if (u['address'] != null) {
        address = u['address'];
      } else {
        address = '';
      }
      if (u['description'] != null) {
        description = u['description'];
      } else {
        description = '';
      }
      if (u['area'] != null) {
        area = u['area'];
      } else {
        area = '';
      }
      if (u['city'] != null) {
        city = u['city'];
      } else {
        city = '';
      }
      if (u['coverImagePath'] != null) {
        try {
          coverImagePath = u['coverImagePath'];
        } catch (e) {
          coverImagePath = 'assets/images/icon_a.png';
        }
      } else {
        coverImagePath = 'assets/images/icon_a.png';
      }

      try {
        FacilitiesController nd = FacilitiesController(
            name, address, description, area, city, coverImagePath);

        myList.add(nd);
      } catch (e) {
        print("api error");
      }
    }
    return myList;
  }

  Future<List<FacilitiesController>> getUser() async {
    final response = await http.get(Uri.parse(ApiCon.baseurl + '/places'));
    var jsondata = json.decode(response.body);

    for (var u in jsondata) {
      String name = '',
          address = '',
          description = '',
          area = '',
          city = '',
          coverImagePath = '';

      if (u['name'] != null) {
        name = u['name'];
      } else {
        name = '';
      }
      if (u['address'] != null) {
        address = u['address'];
      } else {
        address = '';
      }
      if (u['description'] != null) {
        description = u['description'];
      } else {
        description = '';
      }
      if (u['area'] != null) {
        area = u['area'];
      } else {
        area = '';
      }
      if (u['city'] != null) {
        city = u['city'];
      } else {
        city = '';
      }
      if (u['coverImagePath'] != null) {
        try {
          coverImagePath = u['coverImagePath'];
        } catch (e) {
          coverImagePath = 'assets/images/icon_a.png';
        }
      } else {
        coverImagePath = 'assets/images/icon_a.png';
      }

      try {
        FacilitiesController nd = FacilitiesController(
            name, address, description, area, city, coverImagePath);

        myList.add(nd);
      } catch (e) {
        print("api error");
      }
    }
    return myList;
  }

  Future<List<FacilitiesController>> getOrderslist() async {
    var token = await UserSecureStorage.gettoken();
    final response = await http.get(
      Uri.parse(ApiCon.baseurl +
          '/places/' +
          widget.FacilityId.toString() +
          '/Orders/  '),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token.toString()
      },
    );
    var jsondata = json.decode(response.body);
    // dynamic jsondata = JSON.parse(response.body);
    for (var u in jsondata) {
      int id, quantity, orderNumber;
      String name;

      if (u['id'] != null) {
        id = u['id'];
      } else {
        id = 0;
      }

      // if (u['items'][0]['quantity'] != null) {
      //   quantity = u['items'][0]['quantity'];
      // } else {
      //   quantity = 0;
      // }
      // if (u['orderNumber'] != null) {
      //   orderNumber = u['orderNumber'];
      // } else {
      //   orderNumber = 0;
      // }
      // if (u['items'][0]['name'] != null) {
      //   name = u['items'][0]['name'];
      // } else {
      //   name = '';
      // }
    }
    return myList;
  }

  @override
  Widget build(BuildContext context) => initWidget();

  String bname = 'Click';
  int currentindex1 = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            child: const Icon(
              Icons.table_bar,
              size: 50.0,
              color: Color(0xffF5591F),
            ),
          ),
          const Text(
            'Table Ready',
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 18,
              color: Color(0xff0a0a0a),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView(
              shrinkWrap: true,
              // scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 100,
                  // color: Colors.purple[600],
                  child: const Center(
                      child: Text(
                    // _token.text,
                    'Item 1',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
                Container(
                  height: 100,
                  // color: Colors.purple[500],
                  child: const Center(
                      child: Text(
                    'Item 2',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
                Container(
                  height: 100,
                  // color: Colors.purple[400],
                  child: const Center(
                      child: Text(
                    'Item 3',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
                Container(
                  height: 100,
                  // color: Colors.purple[300],
                  child: const Center(
                      child: Text(
                    'Item 4',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
      // 'ADVERTISEMENTS',
      // style: optionStyle,
    ),
    Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: 100,
            width: 100,
            child: const Icon(
              Icons.pending,
              size: 50.0,
              color: Color(0xffF5591F),
            ),
          ),
          const Text(
            'Pending',
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 18,
              color: Color(0xff0a0a0a),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          FutureBuilder(
              future: getOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Map<String, dynamic>> data =
                      snapshot.data as List<Map<String, dynamic>>;
                  return Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text((data[index] as Map<String, dynamic>)
                              .keys
                              .single
                              .toString()),
                          subtitle: Text((data[index] as Map<String, dynamic>)
                              .values
                              .single
                              .toString()),
                          leading: CircleAvatar(
                              child: Text((data[index] as Map<String, dynamic>)
                                  .keys
                                  .single[0]
                                  .toString())),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ],
      ),
    ),
    Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            child: const Icon(
              Icons.run_circle,
              size: 50.0,
              color: Color(0xffF5591F),
            ),
          ),
          const Text(
            'Bar Ready',
            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 18,
              color: Color(0xff0a0a0a),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                  height: 100,
                  // color: Colors.purple[600],
                  child: const Center(
                      child: Text(
                    // _token.text,
                    'Item 1',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
                Container(
                  height: 100,
                  // color: Colors.purple[500],
                  child: const Center(
                      child: Text(
                    'Item 2',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
                Container(
                  height: 100,
                  // color: Colors.purple[400],
                  child: const Center(
                      child: Text(
                    'Item 3',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
                Container(
                  height: 100,
                  // color: Colors.purple[300],
                  child: const Center(
                      child: Text(
                    'Item 4',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget initWidget() {
    return WillPopScope(
        onWillPop: () async {
          /* Do something here if you want */
          return false;
        },
        child: Scaffold(
          drawer: const NavDrawer(),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 49, 52, 90),
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: Color.fromARGB(255, 49, 52, 90),
                  ),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(ApiCon.baseurl +
                                  widget.sfacilities[0].coverImagePath),
                              fit: BoxFit.cover,
                            ),
                            //border: Border.all(width: 1.0, color: const Color(0xff707070)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                widget.sfacilities[0].name,
                                textScaleFactor: 1.2,
                                softWrap: true,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                widget.sfacilities[0].address,
                                softWrap: true,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                bodyw(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.table_bar),
                label: 'Table Ready',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pending),
                label: 'Pending',
                backgroundColor: Color.fromARGB(255, 49, 52, 90),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.run_circle),
                label: 'Bar Ready',
                backgroundColor: Color.fromARGB(255, 49, 52, 90),
              ),
            ],
            currentIndex: currentindex,
            onTap: (int index) {
              setState(() {
                currentindex = index;
              });
            },
            backgroundColor: const Color.fromARGB(255, 49, 52, 90),
          ),
        ));
  }

  bodyw() {
    return _widgetOptions.elementAt(currentindex);
  }

  bodywidget() {
    return Container(
      height: 500,
      // padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: ListView(
        // This next line does the trick.

        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            // width: 160.0,
            // color: Colors.red,
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                child: Stack(
                  children: [
                    Container(
                      height: 450,
                      width: MediaQuery.of(context).size.width / 1.3,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 0.75))
                          ],
                          borderRadius: BorderRadius.circular(13.0),
                          color: const Color(0xffffffff),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: Container(
                                child: const Icon(
                                  Icons.table_bar,
                                  size: 50.0,
                                  color: Color(0xffF5591F),
                                ),
                                // decoration: BoxDecoration(
                                //   image: DecorationImage(
                                //     image: NetworkImage(ApiCon.baseurl +
                                //         widget.facilities[0].coverImagePath),
                                //     fit: BoxFit.cover,
                                //   ),
                                //   //border: Border.all(width: 1.0, color: const Color(0xff707070)),
                                // ),
                              ),
                            ),
                            const Text(
                              'Table Ready',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 18,
                                color: Color(0xff0a0a0a),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              height: 250,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[600],
                                    child: const Center(
                                        child: Text(
                                      // _token.text,
                                      'Item 1',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[500],
                                    child: const Center(
                                        child: Text(
                                      'Item 2',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[400],
                                    child: const Center(
                                        child: Text(
                                      'Item 3',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[300],
                                    child: const Center(
                                        child: Text(
                                      'Item 4',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            // color: Colors.blue,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                child: Stack(
                  children: [
                    Container(
                      height: 450,
                      width: MediaQuery.of(context).size.width / 1.3,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 0.75))
                          ],
                          borderRadius: BorderRadius.circular(13.0),
                          color: const Color(0xffffffff),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: const Icon(
                                Icons.pending,
                                size: 50.0,
                                color: Color(0xffF5591F),
                              ),
                            ),
                            const Text(
                              'Pending',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 18,
                                color: Color(0xff0a0a0a),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              height: 250,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[600],
                                    child: const Center(
                                        child: Text(
                                      'Item 1',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[500],
                                    child: const Center(
                                        child: Text(
                                      'Item 2',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[400],
                                    child: const Center(
                                        child: Text(
                                      'Item 3',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[300],
                                    child: const Center(
                                        child: Text(
                                      'Item 4',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.green,
            child: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                child: Stack(
                  children: [
                    Container(
                      height: 450,
                      width: MediaQuery.of(context).size.width / 1.3,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                        decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 15.0,
                                offset: Offset(0.0, 0.75))
                          ],
                          borderRadius: BorderRadius.circular(13.0),
                          color: const Color(0xffffffff),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: const Icon(
                                Icons.run_circle,
                                size: 50.0,
                                color: Color(0xffF5591F),
                              ),
                            ),
                            const Text(
                              'Bar Ready',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 18,
                                color: Color(0xff0a0a0a),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              height: 250,
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[600],
                                    child: const Center(
                                        child: Text(
                                      'Item 1',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[500],
                                    child: const Center(
                                        child: Text(
                                      'Item 2',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[400],
                                    child: const Center(
                                        child: Text(
                                      'Item 3',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                  Container(
                                    height: 100,
                                    // color: Colors.purple[300],
                                    child: const Center(
                                        child: Text(
                                      'Item 4',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> getOrders() async {
  var token = await UserSecureStorage.gettoken();
  final response = await http.get(
    Uri.parse(ApiCon.baseurl + '/places/' + '1' + '/Orders/  '),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + token.toString()
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseJson = json.decode(response.body);
    // print(responseJson.runtimeType);
    List<Map<String, dynamic>> list = [];
    var cd = responseJson.forEach((key, value) {
      Map<String, dynamic> value2 = Map.of({key: value});
      list.add(value2);
    });
    print(list);
    return list;
  } else {
    throw Exception('Unexpected Error Occured!');
  }
}
