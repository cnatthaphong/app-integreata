// import 'package:basicflutter/screens/list-project.dart';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../ProgressHUD.dart';
import '../model/daily-model.dart';
import '../service/api-service.dart';

class ExteroirPage extends StatefulWidget {
  const ExteroirPage({Key? key}) : super(key: key);

  @override
  State<ExteroirPage> createState() => _ExteroirPageState();
}

class _ExteroirPageState extends State<ExteroirPage> {
  DateTime date = DateTime.now();
  final ImagePicker imgpicker = ImagePicker();
  ExteriorTaskModel formModel = ExteriorTaskModel();
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String projectName = '';
  APIService apiService = APIService();
  final _formkey = GlobalKey<FormState>();
  bool isEdit = false;
  List<dynamic> fileNames = [];
  String projectGuId = '';
  int projectId = 0;
  int TaskId = 0;

  List<DropdownMenuItem<String>> TasksOption = [
    DropdownMenuItem(child: Text("No choose"), value: '-1'),
  ];
  List<DropdownMenuItem<String>> optionStatus = [
    DropdownMenuItem(child: Text("progress"), value: "0"),
    DropdownMenuItem(child: Text("Finish"), value: "3"),
    DropdownMenuItem(child: Text("Hold"), value: "1"),
  ];


  List<DropdownMenuItem<String>> HoldsOption = [
    DropdownMenuItem(child: Text("No choose"), value: "0"),
  ];

  List<DropdownMenuItem<String>> disciplines = [
    DropdownMenuItem(child: Text("No choose"), value: '-1'),
  ];

  List<DropdownMenuItem<String>> LoopsOption = [
    DropdownMenuItem(child: Text("No choose"), value: '-1'),
  ];

  List<DropdownMenuItem<String>> buildingsOption = [
    DropdownMenuItem(child: Text("No choose"), value: '-1'),
  ];

  @override
  void initState() {
    super.initState();
    getProjectName();
    getBuildings();
    getHolds();
   
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

    ScrollController _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
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
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: ScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(0, 40, 94, 187),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00EEEEEE),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: const [
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
                                          'Exterior',
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
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: const BoxDecoration(
                                      color: Color(0x00EEEEEE),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                constraints: const BoxConstraints(
                                  maxWidth: double.infinity,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFF300),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        color: Color(0x00EEEEEE),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
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
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(10, 0, 10, 10),
                                            child: dropdownCustom(
                                                buildingsOption,
                                                formModel.IntBuildingId
                                                    .toString(), (newValue) {
                                              setState(() {
                                                formModel.setIntBuildingId(
                                                    int.parse(newValue));
                                              });

                                              getCategorys(
                                                  formModel.IntBuildingId);
                                            }, false),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxWidth: double.infinity,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[400]),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15, 5, 0, 10),
                                                child: Text(
                                                  'Category',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 10, 5),
                                                child: dropdownCustom(
                                                    LoopsOption,
                                                    formModel.LoopNo.toString(),
                                                    (newValue) {
                                                  setState(() {
                                                    formModel.setLoopNo(
                                                        int.parse(newValue));
                                                  });
                                                  getTasks(
                                                      formModel.IntBuildingId,
                                                      formModel.IntFloorId,
                                                      formModel.LoopNo);
                                                }, false),
                                              ),
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            DateTime? newDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: date,
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime.now());
                                            if (newDate == null) return;
                                            setState(() {
                                              date = newDate;
                                            });
                                            if (formModel.IntLoopId != -1) {
                                              getTaskByDate(formModel, date);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0)),
                                              backgroundColor:
                                                  Colors.grey.shade700,
                                              padding: EdgeInsets.all(10)),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: const Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                              Text(
                                                '${date.day}-${date.month}-${date.year} ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Color(0x00EEEEEE),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(15, 5, 0, 10),
                                                child: Text(
                                                  'Task',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 10, 15),
                                                child: dropdownCustom(
                                                    TasksOption,
                                                    formModel.IntLoopId
                                                        .toString(),
                                                    (newValue) {
                                                  setState(() {
                                                    formModel.setIntLoopId(
                                                        int.parse(newValue));
                                                  });

                                                  getTaskByDate(
                                                      formModel, date);
                                                }, true),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                        height: 65,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 15),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Percent",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  initialValue: "0",
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      if (newValue != "") {
                                                        if (int.parse(
                                                                newValue) >=
                                                            100) {
                                                          formModel
                                                              .setTaskStatusId(
                                                                  3);
                                                          formModel
                                                              .setTaskCompleted(
                                                                  100);
                                                        } else {
                                                          formModel
                                                              .setTaskCompleted(
                                                                  int.parse(
                                                                      newValue));
                                                        }
                                                      } else {
                                                        formModel
                                                            .setTaskCompleted(
                                                                0);
                                                      }
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                new Radius
                                                                        .circular(
                                                                    5.0))),
                                                  ),
                                                )
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "status",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                child: dropdownCustom(
                                                    optionStatus,
                                                    formModel.TaskStatusId
                                                        .toString(),
                                                    (newValue) {
                                                  setState(() {
                                                    formModel.setTaskStatusId(
                                                        int.parse(newValue));
                                                  });
                                                  if (formModel.TaskStatusId !=
                                                      1) {
                                                    formModel
                                                        .setHoldStatusId(0);
                                                  }
                                                }, true),
                                              ),
                                            ),
                                          ],
                                        )),
                                    if (formModel.TaskStatusId == 1)
                                      Container(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 15),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Type Hold",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 15),
                                                  child: dropdownCustom(
                                                      HoldsOption,
                                                      formModel.HoldStatusId
                                                          .toString(),
                                                      (newValue) {
                                                    setState(() {
                                                      formModel.setHoldStatusId(
                                                          int.parse(newValue));
                                                    });
                                                  }, true),
                                                ),
                                              ),
                                            ],
                                          )),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                width: double.infinity,
                                child: const Text(
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
                                  controller: TextEditingController(
                                      text: formModel.TaskDescription),
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
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.all(
                                            new Radius.circular(0.0))),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              if (formModel.listImages != [])
                                Wrap(
                                  children:
                                      formModel.listImages.map((imageone) {
                                    return Container(
                                        child: Card(
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(imageone.path),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.6,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.6,
                                            ),
                                            Positioned(
                                              right: 5.0,
                                              child: InkWell(
                                                child: Icon(Icons.remove_circle,
                                                    size: 30,
                                                    color: Colors.red),
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
                              if (fileNames.length > 0)
                                Wrap(
                                  children: fileNames.map((name) {
                                    String path = 'https://m.integreata.com/uploads/project/'+projectGuId+'/Task/'+TaskId.toString()+'/'+name['FileName'];
                                    return Container(
                                        child: Card(
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              path,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.6,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.6,
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                                  }).toList(),
                                )
                              else
                                Container(),
                              if (!isEdit &&
                                  date.difference(DateTime.now()).inDays == 0)
                                ElevatedButton(
                                  onPressed: () {
                                    openImages();
                                    // Navigator.pushNamed(context, '/Gallery');
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(), //<-- SEE HERE
                                    padding: EdgeInsets.all(20),
                                  ),
                                ),
                              if (!isEdit &&
                                  date.difference(DateTime.now()).inDays == 0)
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  width: 180,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      submitTask(formModel);
                                    },
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
                                          borderRadius:
                                              BorderRadius.circular(35.0)),
                                      padding: EdgeInsets.all(15),
                                    ),
                                  ),
                                )
                              else if (date.difference(DateTime.now()).inDays ==
                                  0)
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  width: 180,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formModel.isHaveData()) {
                                        updateTask(formModel, date);
                                      } else {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Update'),
                                            content:
                                                Text('fail please try again'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'OK');
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(35.0)),
                                      padding: EdgeInsets.all(15),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------------------component--------------------------------------------------------------
  Widget dropdownCustom(List<DropdownMenuItem<String>> options, String newValue,
      Function changeValue, bool filled) {
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
                  filled: filled,
                ),
                // validator: (value) => value == null ? "Select a country" : null,
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

  //-----------------------------------------------------service-------------------------------------------------------------

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
      int _projectId = await prefs.getInt('IntprojectId') ?? -1;
      String _projectGuId = await prefs.getString('ProjectGuId') ?? '';
      setState(() {
        projectName = _projectName;
        projectGuId = _projectGuId;
        projectId = _projectId;
      });
    } catch (e) {}
  }

  Future<Null> getBuildings() async {
    try {
      setState(() {
        isApiCallProcess = true;
      });
      apiService.getBuildings().then((value) {
        if (value != null) {
          setState(() {
            for (var building in value['buildings']) {
              buildingsOption.add(DropdownMenuItem(
                  child: Text(building['BuildingName']),
                  value: building['IntBuildingId'].toString()));
            }
          });
        }
        setState(() {
          isApiCallProcess = false;
        });
      });
    } catch (e) {}
  }

  Future<Null> getCategorys(int IntBuildingId) async {
    try {
      setState(() {
        formModel.setLoopNo(-1);
        LoopsOption = [
          DropdownMenuItem(child: Text("No choose"), value: '-1'),
        ];
      });
      if (IntBuildingId != -1) {
        setState(() {
          isApiCallProcess = true;
        });
        apiService.getCategorys(IntBuildingId).then((value) {
          if (value != null) {
            setState(() {
              for (var loop in value['categorys']) {
                String loopNo = loop['LoopNo'].toString();

                if (loopNo.length > 12) {
                  loopNo = loopNo.substring(0, 11) + "...";
                }
                LoopsOption.add(
                    DropdownMenuItem(child: Text(loopNo), value: loopNo));
              }
            });
          }
          setState(() {
            isApiCallProcess = false;
          });
        });
      }
    } catch (e) {}
  }

  Future<Null> getTasks(int IntBuildingId, int IntFloorId, int LoopNo) async {
    try {
      setState(() {
        formModel.setIntLoopId(-1);
        TasksOption = [DropdownMenuItem(child: Text("No choose"), value: '-1')];
      });
      if (IntBuildingId != -1 || IntFloorId != -1 || LoopNo != -1) {
        setState(() {
          isApiCallProcess = true;
        });
        apiService.getTasksNoFloorId(IntBuildingId, LoopNo).then((value) {
          if (value != null) {
            setState(() {
              for (var task in value['tasks']) {
                String taskName = task['TaskName'];

                if (taskName.length > 40) {
                  taskName = taskName.substring(0, 39) + "...";
                }
                TasksOption.add(DropdownMenuItem(
                    child: Text(taskName),
                    value: task['IntLoopId'].toString()));
              }
            });
          }
          setState(() {
            isApiCallProcess = false;
          });
        });
      }
    } catch (e) {}
  }

  Future<Null> getHolds() async {
    try {
      setState(() {
        isApiCallProcess = true;
      });
      apiService.getHolds().then((value) {
        if (value != null) {
          setState(() {
           
            for (var hold in value['holds']) {
              HoldsOption.add(DropdownMenuItem(
                  child: Text(hold['HoldStatusName']),
                  value: hold['HoldStatusId'].toString()));
            }
          });
        }
        setState(() {
          isApiCallProcess = false;
        });
      });
    } catch (e) {}
  }

  //submitTask
  Future<Null> submitTask(ExteriorTaskModel formData) async {
    try {
      setState(() {
        isApiCallProcess = true;
      });
      apiService.addExteriorTask(formData).then((value) {
        String status = 'fail please try again';
        if (value != null) {
          status = 'successful';
          apiService
              .addExteriorImage(formData, value["IntTaskId"])
              .then((value) {
            status = 'successful';
          });
        }
        setState(() {
          isApiCallProcess = false;
        });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Submit'),
            content: Text(status),
            actions: <Widget>[
              if (status == 'fail please try again')
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
              TextButton(
                onPressed: () {
                  formData.resetdata();
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    } catch (e) {}
  }

  Future<Null> getTaskByDate(ExteriorTaskModel formData, DateTime date) async {
    try {
      setState(() {
        isApiCallProcess = true;
      });
      apiService.getExteriorTask(formData, date).then((value) {
        if (value != null && value['status'] == "have") {
          setState(() {
            formModel.setHoldStatusId(value['HoldStatusId']);
            formModel.setTaskStatusId(value['TaskStatusId']);
            formModel.setTaskCompleted((value['TaskCompleted'] * 100).toInt());
            formModel.setTaskDescription(value['TaskDescription']);
            fileNames = value['filename'];
            TaskId = value['IntTaskId'];
            isEdit = true;
          });
        } else {
          setState(() {
            formModel.setHoldStatusId(0);
            formModel.setTaskStatusId(0);
            formModel.setTaskCompleted(0);
            formModel.setTaskDescription("");
            fileNames = [];
            TaskId =0;
            isEdit = false;
          });
        }
        setState(() {
          isApiCallProcess = false;
        });
      });
    } catch (e) {}
  }

  //updateTask
  Future<Null> updateTask(ExteriorTaskModel formData, DateTime date) async {
    try {
      setState(() {
        isApiCallProcess = true;
      });
      apiService.updateExteriorTask(formData, date).then((value) {
        String status = 'fail please try again';
        if (value != null) {
          status = 'successful';
        }
        setState(() {
          isApiCallProcess = false;
        });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('update'),
            content: Text(status),
            actions: <Widget>[
              if (status == 'fail please try again')
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
              TextButton(
                onPressed: () {
                  formData.resetdata();
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    } catch (e) {}
  }
}
