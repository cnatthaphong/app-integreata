import 'package:integreata2/component/list-component.dart';
import 'package:integreata2/service/api-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/login-model.dart';

class ListWork extends StatefulWidget {
  const ListWork({Key? key}) : super(key: key);

  @override
  State<ListWork> createState() => _ListWorkState();
}

class _ListWorkState extends State<ListWork> {
  APIService apiService = APIService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<dynamic> Disciplines = [
    {
      'ProjectName': 'Architctural Work',
      'IntDisciplineId': 1,
      'work': '/constructionPage'
    },
    {
      'ProjectName': 'Structural Work',
      'IntDisciplineId': 2,
      'work': '/StructurePage'
    },
    {'ProjectName': 'Exterior', 'IntDisciplineId': 9, 'work': '/ExteroirPage'},
    {
      'ProjectName': 'External Work',
      'IntDisciplineId': 10,
      'work': '/ExternalPage'
    },
    {'ProjectName': 'Deflect Work', 'IntDisciplineId': 1, 'work': '/DeflectPage'},
  ];
  bool isApiCallProcess = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                      tooltip: 'back',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(0, 40, 94, 187),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Descriptline',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(5),
                color: Colors.white70,
                child: ListView.builder(
                  itemCount: Disciplines.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: ListCard(
                            namePath: "",
                            title: Disciplines[index]['ProjectName'],
                            function: () {
                              click(index);
                            }));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> click(int index) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(
        'IntDisciplineId', Disciplines[index]['IntDisciplineId']);
    await Navigator.pushNamed(context, Disciplines[index]['work']);
  }
}
