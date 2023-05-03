import 'package:integreata2/component/list-component.dart';
import 'package:integreata2/service/api-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login-model.dart';

class ListProject extends StatefulWidget {
  const ListProject({Key? key}) : super(key: key);

  @override
  State<ListProject> createState() => _ListProjectState();
}

class _ListProjectState extends State<ListProject> {
  APIService apiService = APIService();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<dynamic> project = [];
  bool isApiCallProcess = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProjectbyMemberId();
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
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Project',
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
                  child: IconButton(
                    icon: const Icon(
                      Icons.logout_rounded,
                      size: 30,
                    ),
                    tooltip: 'logout',
                    onPressed: () async {
                      logout();
                    },
                  ),
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 40, 94, 187),
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
                itemCount: project.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: ListCard(
                          namePath: "",
                          title: project[index]['ProjectName'],
                          function: () async {
                            await click(index).then((value) => {
                                  if (value)
                                    {Navigator.pushNamed(context, '/listwork')}
                                });
                          }));
                },
              ),
            ),
          )
        ],
      ),
    ));
  }

  Future<bool> click(int index) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt('IntprojectId', project[index]['IntProjectId']);
    await prefs.setString('projectName', project[index]['ProjectName']);
    await prefs.setString('ProjectGuId', project[index]['ProjectGuId']);
    
    return true;
  }

  Future<void> getProjectbyMemberId() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      isApiCallProcess = true;
    });
    int IntMemberId = prefs.getInt('memberId') ?? -1;
    apiService.getListProject(IntMemberId).then((value) {
      if (value != null) {
        List<dynamic> _ListProject = value['projects'];
        setState(() {
          project = value['projects'];
          isApiCallProcess = false;
        });
      }
    });
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      isApiCallProcess = true;
    });
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
