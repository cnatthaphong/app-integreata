// import 'package:basicflutter/screens/list-project.dart';
import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../ProgressHUD.dart';
import '../model/daily-model.dart';

class FormPageTwo extends StatefulWidget {
  const FormPageTwo({Key? key}) : super(key: key);

  @override
  State<FormPageTwo> createState() => _FormPageTwoState();
}

class _FormPageTwoState extends State<FormPageTwo> {
  List<dynamic> optionList = [
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
    {'text': 'test', 'isCheck': false, 'isCheck2': false, 'isCheck3': false},
  ];
  final _formkey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  final ImagePicker imgpicker = ImagePicker();
  fromDailyTaskModel formModel = fromDailyTaskModel();
  List<DropdownMenuItem<String>> disciplines = [
    DropdownMenuItem(child: Text("No choose"), value: '-1'),
  ];
  List<DropdownMenuItem<String>> locationType = [
    DropdownMenuItem(child: Text("No choose"), value: ''),
    DropdownMenuItem(child: Text("Room"), value: "1"),
    DropdownMenuItem(child: Text("Area"), value: "2"),
    DropdownMenuItem(child: Text("Zone"), value: "3"),
  ];
  List<DropdownMenuItem<String>> locationName = [
    DropdownMenuItem(child: Text("No choose"), value: '-1'),
  ];
  bool isApiCallProcess = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String projectName = '';
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        setState(() {
          formModel.listImages.addAll(pickedfiles);
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  deleteImages(XFile image) async {
    setState(() {
      formModel.listImages.remove(image);
    });
  }

  Future<Null> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<Null> getProjectName() async {
    try {
      final SharedPreferences prefs = await _prefs;
      String _projectName = await prefs.getString('projectName') ?? "";
      setState(() {
        projectName = _projectName;
      });
    } catch (e) {}
  }

  Widget dropdownCustom(List<DropdownMenuItem<String>> options, String newValue,
      Function changeValue) {
    return Row(
      children: [
        Expanded(
            flex: 10,
            child: SizedBox(
              height: 50,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fillColor: Colors.grey[100],
                ),
                validator: (value) => value == null ? "Select a country" : null,
                dropdownColor: Colors.grey[100],
                value: newValue,
                onChanged: (newValue) {
                  changeValue(newValue);
                },
                items: options,
              ),
            ))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getProjectName();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(inAsyncCall: isApiCallProcess, child: _uiSetup(context));
  }

  Widget _uiSetup(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFEEEEEE),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF7D7D7D),
                shape: BoxShape.rectangle,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                ),
                                tooltip: 'Increase volume by 10',
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
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                color: Color(0x00EEEEEE),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'PROGRESS UPDATE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'Construction Loop',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
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
                        Container(
                          width: double.infinity,
                          // height: MediaQuery.of(context).size.height * 0.10,
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 166, 166, 166),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  color: Color(0x00EEEEEE),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 5, 0, 10),
                                      child: Text(
                                        'Building Name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: dropdownCustom(disciplines,
                                          formModel.IntBuildingId.toString(),
                                          (newValue) {
                                        setState(() {
                                          formModel.setIntBuildingId(
                                              int.parse(newValue));
                                        });
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0x00EEEEEE),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 5, 0, 10),
                                      child: Text(
                                        'Area',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: dropdownCustom(disciplines,
                                          formModel.IntFloorId.toString(),
                                          (newValue) {
                                        setState(() {
                                          formModel.setIntBuildingId(
                                              int.parse(newValue));
                                        });
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: double.infinity,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 5, 0, 0),
                                        child: Text(
                                          'Task',
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: Text(
                                          'Status',
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
                                  color: Colors.white,
                                  width: double.infinity,
                                  height: (MediaQuery.of(context).size.height *
                                      0.18),
                                  child: Scrollbar(
                                    child: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      child: Column(
                                        children: <Widget>[
                                          ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: optionList.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Text(
                                                            optionList[index]
                                                                ['text']),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      getColor),
                                                          value:
                                                              optionList[index]
                                                                  ['isCheck'],
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              optionList[index][
                                                                      'isCheck'] =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      getColor),
                                                          value:
                                                              optionList[index]
                                                                  ['isCheck2'],
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              optionList[index][
                                                                      'isCheck2'] =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Checkbox(
                                                          checkColor:
                                                              Colors.white,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      getColor),
                                                          value:
                                                              optionList[index]
                                                                  ['isCheck3'],
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              optionList[index][
                                                                      'isCheck3'] =
                                                                  value!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: double.infinity,
                          child: Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            onChanged: (String? input) {
                              formModel.setTaskDescription(input!);
                            },
                            onSaved: (String? input) {
                              formModel.setTaskDescription(input!);
                            },
                            maxLines: 4,
                            minLines: 4,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.all(
                                      new Radius.circular(0.0))),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        if (formModel.listImages != [])
                          Wrap(
                            children: formModel.listImages.map((imageone) {
                              return Container(
                                  child: Card(
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(imageone.path),
                                        height:
                                            MediaQuery.of(context).size.width /
                                                3.6,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.6,
                                      ),
                                      Positioned(
                                        right: 5.0,
                                        child: InkWell(
                                          child: Icon(Icons.remove_circle,
                                              size: 30, color: Colors.red),
                                          onTap: () {
                                            deleteImages(imageone);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                            }).toList(),
                          )
                        else
                          Container(),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: 180,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Poppins',
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35.0)),
                              padding: EdgeInsets.all(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
