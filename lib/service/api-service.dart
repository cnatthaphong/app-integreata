import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:integreata2/model/daily-model.dart';
import 'dart:convert';
import '../model/login-model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
//ต้องมาเเก้ domain
  String baseUrl = 'https://m.integreata.com';
  // String baseUrl = 'http://192.168.1.12:4000';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Map<String, String> apiPath = {
    "login": '/login',
    "buildings": '/buildings',
    "floors": '/floors',
    "loops": '/loops',
    "categorys": '/categorys',
    "rooms": '/rooms',
    'tasks': '/tasks',
    'tasks_no_floorId': '/tasks_no_floorId',
    'holds': '/holds',
    
    'get_construc_task': '/get_construc_task',
    'get_struc_task': '/get_struc_task',
    'get_exterior_task':"/get_exterior_task",
    'get_external_task':"/get_external_task",
    'get_defect_task':"/get_defect_task",
    
    'add_content_construc_task': '/add_content_construc_task',
    'add_content_struc_task': '/add_content_struc_task',
    'add_content_external_task': '/add_content_external_task',
    'add_content_exterior_task': '/add_content_exterior_task',
    'add_content_defect_task': '/add_content_defect_task',
    
    'add_images_construc_task': '/add_images_construc_task',
    'add_images_struc_task': '/add_images_struc_task',
    'add_images_external_task': '/add_images_external_task',
    'add_images_exterior_task': '/add_images_exterior_task',
    'add_images_defect_task': '/add_images_defect_task',
    
    'update_construc_task': '/update_construc_task',
    'update_struc_task': '/update_struc_task',
    'update_external_task': '/update_external_task',
    'update_exterior_task': '/update_exterior_task',
    'update_defect_task': '/update_defect_task'

  };
//-------------------------------------------------------------------
//api เสร๋จเเล้ว
//-------------------------------------------------------------------
  Future<LoginResponseModel> login( LoginRequestModel requestModel) async {
    var url = Uri.parse(baseUrl + apiPath["login"]!);
    var jsonData = json.encode(requestModel.toJson());
    final response = await http
        .post(url,
            headers: {"Content-Type": "application/json"}, body: jsonData)
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else if (response.statusCode == 408) {
      return LoginResponseModel.fromJson({"erorr": "Time out"});
    } else {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getListProject( int IntMemberId) async {
    var url = Uri.parse(baseUrl + '/projects');
    var jsonData = json.encode({'IntMemberId': IntMemberId});
    final response = await http
        .post(url,
            headers: {"Content-Type": "application/json"}, body: jsonData)
        .timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response('Error', 408);
      },
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      Map<String, dynamic> datatest = json.decode(response.body);
      return datatest;
    } else {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getBuildings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntProjectId = preferences.getInt('IntprojectId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["buildings"]!);
    var jsonData = jsonEncode({"IntProjectId": IntProjectId});
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getFloors( int IntBuildingId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;

    var url = Uri.parse(baseUrl + apiPath["floors"]!);
    var jsonData = jsonEncode(
        {"IntDisciplineId": IntDisciplineId, "IntBuildingId": IntBuildingId});
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getLoops( int IntBuildingId, int IntFloorId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;

    var url = Uri.parse(baseUrl + apiPath["loops"]!);
    var jsonData = jsonEncode({
      "IntDisciplineId": IntDisciplineId,
      "IntBuildingId": IntBuildingId,
      "IntFloorId": IntFloorId
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getCategorys( int IntBuildingId ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;

    var url = Uri.parse(baseUrl + apiPath["categorys"]!);
    var jsonData = jsonEncode({
      "IntDisciplineId": IntDisciplineId,
      "IntBuildingId": IntBuildingId,
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getRooms( int IntBuildingId, int IntFloorId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;

    var url = Uri.parse(baseUrl + apiPath["rooms"]!);
    var jsonData = jsonEncode({
      "IntDisciplineId": IntDisciplineId,
      "IntBuildingId": IntBuildingId,
      "IntFloorId": IntFloorId
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getTasks( int IntBuildingId, int IntFloorId, int LoopNo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["tasks"]!);
    var jsonData = jsonEncode({
      "IntDisciplineId": IntDisciplineId,
      "IntBuildingId": IntBuildingId,
      "IntFloorId": IntFloorId,
      "LoopNo": LoopNo
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getTasksNoFloorId( int IntBuildingId, int LoopNo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["tasks_no_floorId"]!);
    var jsonData = jsonEncode({
      "IntDisciplineId": IntDisciplineId,
      "IntBuildingId": IntBuildingId,
      "LoopNo": LoopNo
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getHolds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;

    var url = Uri.parse(baseUrl + apiPath["holds"]!);
    try {
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> addConsturcTask( ConsturcTaskModel formData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('projectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["add_content_construc_task"]!);
    List<String> image_name =
        List.from(formData.listImages.map((image) => image.name.toString().substring(image.name.toString().length - 9)));
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntFloorId": formData.IntFloorId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "FileNames": image_name
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> updateConsturcTask( ConsturcTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["update_construc_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntFloorId": formData.IntFloorId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "DateTime": date.toString()
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<bool> addConsturcImage( ConsturcTaskModel formData, int IntTaskId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntMemberId = preferences.getInt('memberId') ?? -1;
    String ProjectGuId = preferences.getString('ProjectGuId') ?? '';
    var url = Uri.parse(baseUrl + apiPath["add_images_construc_task"]!);
    final request = new http.MultipartRequest('POST', url);
    request.fields['projectId'] = projectId.toString();
    request.fields['ProjectGuId'] = ProjectGuId;
    request.fields['type'] = 'Consturction';
    request.fields['IntTaskId'] = IntTaskId.toString();

    List<MultipartFile> newList = [];
    List<XFile> images = formData.listImages;
    for (int i = 0; i < images.length; i++) {
      XFile imageFile = images[i];
      String fileName = imageFile.name.substring(imageFile.name.length - 9);
      request.files.add(await http.MultipartFile.fromPath(
          'files', imageFile.path,
          filename: fileName));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded!');
      return true;
    } else {
      return false;
    }
  }

//complete
  Future<Map<String, dynamic>> addSturcTask(  SturcTaskModel formData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["add_content_struc_task"]!);
    List<String> image_name =
        List.from(formData.listImages.map((image) => image.name.toString().substring(image.name.toString().length - 9)));
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntFloorId": formData.IntFloorId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "FileNames": image_name
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> updateSturcTask( SturcTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["update_construc_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntFloorId": formData.IntFloorId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "DateTime": date.toString()
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<bool> addSturcImage( SturcTaskModel formData, int IntTaskId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntMemberId = preferences.getInt('memberId') ?? -1;
    String ProjectGuId = preferences.getString('ProjectGuId') ?? '';
    var url = Uri.parse(baseUrl + apiPath["add_images_struc_task"]!);

    final request = new http.MultipartRequest('POST', url);
    request.fields['projectId'] = projectId.toString();
    request.fields['ProjectGuId'] = ProjectGuId;
    request.fields['type'] = 'Task';
    request.fields['IntTaskId'] = IntTaskId.toString();
    List<MultipartFile> newList = [];
    List<XFile> images = formData.listImages;
    for (int i = 0; i < images.length; i++) {
      XFile imageFile = images[i];
      String fileName = imageFile.name.substring(imageFile.name.length - 9);
      request.files.add(await http.MultipartFile.fromPath(
          'files', imageFile.path,
          filename: fileName));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded!');
      return true;
    } else {
      return false;
    }
  }

//complete
  Future<Map<String, dynamic>> addExternalTask( ExternalTaskModel formData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('projectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["add_content_external_task"]!);
    List<String> image_name =
        List.from(formData.listImages.map((image) => image.name.toString().substring(image.name.toString().length - 9)));
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "FileNames": image_name
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> updateExternalTask( ExternalTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["update_external_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "DateTime": date.toString()
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<bool> addExternalImage( ExternalTaskModel formData, int IntTaskId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntMemberId = preferences.getInt('memberId') ?? -1;
    String ProjectGuId = preferences.getString('ProjectGuId') ?? '';
    var url = Uri.parse(baseUrl + apiPath["add_images_external_task"]!);
    final request = new http.MultipartRequest('POST', url);
    request.fields['projectId'] = projectId.toString();
    request.fields['ProjectGuId'] = ProjectGuId;
    request.fields['type'] = 'Task';
    request.fields['IntTaskId'] = IntTaskId.toString();
    List<MultipartFile> newList = [];
    List<XFile> images = formData.listImages;
    for (int i = 0; i < images.length; i++) {
      XFile imageFile = images[i];
      String fileName = imageFile.name.substring(imageFile.name.length - 9);
      request.files.add(await http.MultipartFile.fromPath(
          'files', imageFile.path,
          filename: fileName));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded!');
      return true;
    } else {
      return false;
    }
  }

//complete
  Future<Map<String, dynamic>> addExteriorTask( ExteriorTaskModel formData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('projectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["add_content_exterior_task"]!);
    List<String> image_name =
        List.from(formData.listImages.map((image) => image.name.toString().substring(image.name.toString().length - 9)));
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "FileNames": image_name
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> updateExteriorTask( ExteriorTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["update_exterior_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntLoopId": formData.IntLoopId,
      "HoldStatusId": formData.HoldStatusId,
      "TaskStatusId": formData.TaskStatusId,
      "TaskDescription": formData.TaskDescription,
      "TaskCompleted": formData.TaskCompleted / 100,
      "DateTime": date.toString()
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<bool> addExteriorImage( ExteriorTaskModel formData, int IntTaskId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntMemberId = preferences.getInt('memberId') ?? -1;
    String ProjectGuId = preferences.getString('ProjectGuId') ?? '';
    var url = Uri.parse(baseUrl + apiPath["add_images_exterior_task"]!);
    final request = new http.MultipartRequest('POST', url);
    request.fields['projectId'] = projectId.toString();
    request.fields['ProjectGuId'] = ProjectGuId;
    request.fields['type'] = 'Taks';
    request.fields['IntTaskId'] = IntTaskId.toString();
    List<MultipartFile> newList = [];
    List<XFile> images = formData.listImages;
    for (int i = 0; i < images.length; i++) {
      XFile imageFile = images[i];
      String fileName = imageFile.name.substring(imageFile.name.length - 9);
      request.files.add(await http.MultipartFile.fromPath(
          'files', imageFile.path,
          filename: fileName));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded!');
      return true;
    } else {
      return false;
    }
  }

//complete
  Future<Map<String, dynamic>> addDeflectTask( DeflectTaskModel formData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('projectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["add_content_defect_task"]!);
    List<String> image_name =
        List.from(formData.listImages.map((image) => image.name.toString().substring(image.name.toString().length - 9)));
    var jsonData = jsonEncode({
      "IntRoomId": formData.IntRoomId,
      "HoldStatusId": formData.HoldStatusId,
      "DeflectStatusId": formData.TaskStatusId,
      "DeflectDescription": formData.TaskDescription,
      "FileNames": image_name
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> updateDeflectTask( DeflectTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["update_defect_task"]!);
    var jsonData = jsonEncode({
      "IntRoomId": formData.IntRoomId,
      "HoldStatusId": formData.HoldStatusId,
      "DeflectStatusId": formData.TaskStatusId,
      "DeflectDescription": formData.TaskDescription,
      "DateTime": date.toString()
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<bool> addDeflectImage( DeflectTaskModel formData, int IntTaskId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntMemberId = preferences.getInt('memberId') ?? -1;
    String ProjectGuId = preferences.getString('ProjectGuId') ?? '';
    var url = Uri.parse(baseUrl + apiPath["add_images_defect_task"]!);
    final request = new http.MultipartRequest('POST', url);
    request.fields['projectId'] = projectId.toString();
    request.fields['ProjectGuId'] = ProjectGuId;
    request.fields['type'] = 'Deflect';
    request.fields['IntTaskId'] = IntTaskId.toString();
    List<MultipartFile> newList = [];
    List<XFile> images = formData.listImages;
    for (int i = 0; i < images.length; i++) {
      XFile imageFile = images[i];
      String fileName = imageFile.name.substring(imageFile.name.length - 9);
      request.files.add(await http.MultipartFile.fromPath(
          'files', imageFile.path,
          filename: fileName));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded!');
      return true;
    } else {
      return false;
    }
  }

//complete
  Future<Map<String, dynamic>> getSturcTask( SturcTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["get_struc_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntFloorId": formData.IntFloorId,
      "IntLoopId": formData.IntLoopId,
      "DateTime": date.toString(),
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getConsturcTask( ConsturcTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["get_construc_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntFloorId": formData.IntFloorId,
      "IntLoopId": formData.IntLoopId,
      "DateTime": date.toString(),
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getExternalTask( ExternalTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["get_external_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntLoopId": formData.IntLoopId,
      "DateTime": date.toString(),
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getExteriorTask( ExteriorTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["get_exterior_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntLoopId": formData.IntLoopId,
      "DateTime": date.toString(),
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }

//complete
  Future<Map<String, dynamic>> getDeflectTask( DeflectTaskModel formData, DateTime date) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int projectId = preferences.getInt('IntprojectId') ?? -1;
    int IntDisciplineId = preferences.getInt('IntDisciplineId') ?? -1;
    var url = Uri.parse(baseUrl + apiPath["get_defect_task"]!);
    var jsonData = jsonEncode({
      "IntBuildingId": formData.IntBuildingId,
      "IntDisciplineId": IntDisciplineId,
      "IntFloorId": formData.IntFloorId,
      "IntRoomId": formData.IntRoomId,
      "DateTime": date.toString(),
    });
    try {
      final response = await http
          .post(url,
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (response.statusCode == 200 || response.statusCode == 400) {
        Map<String, dynamic> datatest = json.decode(response.body);
        return datatest;
      } else {
        throw Exception('Failed to load data!!!!!!');
      }
    } catch (e) {
      throw Exception('Failed to load data!');
    }
  }
}
