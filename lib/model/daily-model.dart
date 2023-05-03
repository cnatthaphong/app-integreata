import 'package:image_picker/image_picker.dart';

class fromDailyTaskModel {
  int IntBuildingId = -1;
  int IntFloorId = -1;
  int LoopNo = -1;
  int IntLoopId = -1;
  int HoldStatusId = 0;
  int TaskStatusId = 0;
  String TaskDescription = '';
  int IntDisciplineId = 1;

  List<XFile> listImages = [];

  fromDailyTaskModel();
  void setTaskDescription(String data) {
    TaskDescription = data;
  }

  void setListImages(List<XFile> _images) {
    listImages = _images;
  }

  void setIntBuildingId(int _IntBuildingId) {
    IntBuildingId = _IntBuildingId;
  }

  void setIntFloorId(int _IntFloorId) {
    IntFloorId = _IntFloorId;
  }

  void setLoopNo(int _LoopNo) {
    LoopNo = _LoopNo;
  }

  void setIntLoopId(int _IntLoopId) {
    IntLoopId = _IntLoopId;
  }

  void setHoldStatusId(int _HoldStatusId) {
    HoldStatusId = _HoldStatusId;
  }

  void setTaskStatusId(int _TaskStatusId) {
    TaskStatusId = _TaskStatusId;
  }

  void setTaskDes(String _TaskDescription) {
    TaskDescription = _TaskDescription;
  }

  void setDiscipline(int _IntDisciplineId) {
    IntDisciplineId = _IntDisciplineId;
  }
}

class ConsturcTaskModel {
  int IntBuildingId = -1;
  int IntFloorId = -1;
  int LoopNo = -1;
  int IntLoopId = -1;
  int HoldStatusId = 0;
  int TaskStatusId = 0;
  String TaskDescription = '';
  int TaskCompleted = 0;

  List<XFile> listImages = [];

  ConsturcTaskModel();
  void setTaskDescription(String data) {
    TaskDescription = data;
  }

  void setTaskCompleted(int data) {
    TaskCompleted = data;
  }

  void setListImages(List<XFile> _images) {
    listImages = _images;
  }

  void setIntBuildingId(int _IntBuildingId) {
    IntBuildingId = _IntBuildingId;
  }

  void setIntFloorId(int _IntFloorId) {
    IntFloorId = _IntFloorId;
  }

  void setLoopNo(int _LoopNo) {
    LoopNo = _LoopNo;
  }

  void setIntLoopId(int _IntLoopId) {
    IntLoopId = _IntLoopId;
  }

  void setHoldStatusId(int _HoldStatusId) {
    HoldStatusId = _HoldStatusId;
  }

  void setTaskStatusId(int _TaskStatusId) {
    TaskStatusId = _TaskStatusId;
  }

  void setTaskDes(String _TaskDescription) {
    TaskDescription = _TaskDescription;
  }

  void resetdata() {
    IntBuildingId = -1;
    IntFloorId = -1;
    LoopNo = -1;
    IntLoopId = -1;
    HoldStatusId = 0;
    TaskStatusId = 0;
    TaskDescription = '';
    TaskCompleted = 0;
  }

  bool isHaveData() {
    return IntBuildingId != -1 &&
        IntFloorId != -1 &&
        LoopNo != -1 &&
        IntLoopId != -1;
  }
}

class SturcTaskModel {
  int IntBuildingId = -1;
  int IntFloorId = -1;
  int LoopNo = -1;
  int IntLoopId = -1;
  int HoldStatusId = 0;
  int TaskStatusId = 0;
  String TaskDescription = '';
  int TaskCompleted = 0;
  int IntDisciplineId = 1;

  List<XFile> listImages = [];

  SturcTaskModel();
  void setTaskDescription(String data) {
    TaskDescription = data;
  }

  void setTaskCompleted(int data) {
    TaskCompleted = data;
  }

  void setListImages(List<XFile> _images) {
    listImages = _images;
  }

  void setIntBuildingId(int _IntBuildingId) {
    IntBuildingId = _IntBuildingId;
  }

  void setIntFloorId(int _IntFloorId) {
    IntFloorId = _IntFloorId;
  }

  void setLoopNo(int _LoopNo) {
    LoopNo = _LoopNo;
  }

  void setIntLoopId(int _IntLoopId) {
    IntLoopId = _IntLoopId;
  }

  void setHoldStatusId(int _HoldStatusId) {
    HoldStatusId = _HoldStatusId;
  }

  void setTaskStatusId(int _TaskStatusId) {
    TaskStatusId = _TaskStatusId;
  }

  void setTaskDes(String _TaskDescription) {
    TaskDescription = _TaskDescription;
  }

  void resetdata() {
    IntBuildingId = -1;
    IntFloorId = -1;
    LoopNo = -1;
    IntLoopId = -1;
    HoldStatusId = 0;
    TaskStatusId = 0;
    TaskDescription = '';
    TaskCompleted = 0;
  }

  bool isHaveData() {
    return IntBuildingId != -1 &&
        IntFloorId != -1 &&
        LoopNo != -1 &&
        IntLoopId != -1;
  }
}


class ExteriorTaskModel {
  int IntBuildingId = -1;
  int IntFloorId = -1;
  int LoopNo = -1;
  int IntLoopId = -1;
  int HoldStatusId = 0;
  int TaskStatusId = 0;
  String TaskDescription = '';
  int TaskCompleted = 0;

  List<XFile> listImages = [];

  ExteriorTaskModel();
  void setTaskDescription(String data) {
    TaskDescription = data;
  }

  void setTaskCompleted(int data) {
    TaskCompleted = data;
  }

  void setListImages(List<XFile> _images) {
    listImages = _images;
  }

  void setIntBuildingId(int _IntBuildingId) {
    IntBuildingId = _IntBuildingId;
  }

  void setIntFloorId(int _IntFloorId) {
    IntFloorId = _IntFloorId;
  }

  void setLoopNo(int _LoopNo) {
    LoopNo = _LoopNo;
  }

  void setIntLoopId(int _IntLoopId) {
    IntLoopId = _IntLoopId;
  }

  void setHoldStatusId(int _HoldStatusId) {
    HoldStatusId = _HoldStatusId;
  }

  void setTaskStatusId(int _TaskStatusId) {
    TaskStatusId = _TaskStatusId;
  }

  void setTaskDes(String _TaskDescription) {
    TaskDescription = _TaskDescription;
  }

  void resetdata() {
    IntBuildingId = -1;
    IntFloorId = -1;
    LoopNo = -1;
    IntLoopId = -1;
    HoldStatusId = 0;
    TaskStatusId = 0;
    TaskDescription = '';
    TaskCompleted = 0;
  }

  bool isHaveData() {
    return IntBuildingId != -1 &&
        LoopNo != -1 &&
        IntLoopId != -1;
  }
}

class ExternalTaskModel {
  int IntBuildingId = -1;
  int IntFloorId = -1;
  int LoopNo = -1;
  int IntLoopId = -1;
  int HoldStatusId = 0;
  int TaskStatusId = 0;
  String TaskDescription = '';
  int TaskCompleted = 0;

  List<XFile> listImages = [];

  ExternalTaskModel();
  void setTaskDescription(String data) {
    TaskDescription = data;
  }

  void setTaskCompleted(int data) {
    TaskCompleted = data;
  }

  void setListImages(List<XFile> _images) {
    listImages = _images;
  }

  void setIntBuildingId(int _IntBuildingId) {
    IntBuildingId = _IntBuildingId;
  }

  void setIntFloorId(int _IntFloorId) {
    IntFloorId = _IntFloorId;
  }

  void setLoopNo(int _LoopNo) {
    LoopNo = _LoopNo;
  }

  void setIntLoopId(int _IntLoopId) {
    IntLoopId = _IntLoopId;
  }

  void setHoldStatusId(int _HoldStatusId) {
    HoldStatusId = _HoldStatusId;
  }

  void setTaskStatusId(int _TaskStatusId) {
    TaskStatusId = _TaskStatusId;
  }

  void setTaskDes(String _TaskDescription) {
    TaskDescription = _TaskDescription;
  }

  void resetdata() {
    IntBuildingId = -1;
    IntFloorId = -1;
    LoopNo = -1;
    IntLoopId = -1;
    HoldStatusId = 0;
    TaskStatusId = 0;
    TaskDescription = '';
    TaskCompleted = 0;
  }

  bool isHaveData() {
    return IntBuildingId != -1 &&
        LoopNo != -1 &&
        IntLoopId != -1;
  }
}

class DeflectTaskModel {
  int IntBuildingId = -1;
  int IntFloorId = -1;
  int IntRoomId = -1;
  int HoldStatusId = 0;
  int TaskStatusId = 0;
  String TaskDescription = '';

  List<XFile> listImages = [];

 DeflectTaskModel();
  void setTaskDescription(String data) {
    TaskDescription = data;
  }


  void setListImages(List<XFile> _images) {
    listImages = _images;
  }

  void setIntBuildingId(int _IntBuildingId) {
    IntBuildingId = _IntBuildingId;
  }

  void setIntFloorId(int _IntFloorId) {
    IntFloorId = _IntFloorId;
  }

  void setIntRoomId(int _IntRoomId) {
    IntRoomId = _IntRoomId;
  }

  void setHoldStatusId(int _HoldStatusId) {
    HoldStatusId = _HoldStatusId;
  }

  void setTaskStatusId(int _TaskStatusId) {
    TaskStatusId = _TaskStatusId;
  }

  void setTaskDes(String _TaskDescription) {
    TaskDescription = _TaskDescription;
  }

  void resetdata() {
    IntBuildingId = -1;
    IntFloorId = -1;
    IntRoomId = -1;
    HoldStatusId = 0;
    TaskStatusId = 0;
    TaskDescription = '';
  }

  bool isHaveData() {
    return IntBuildingId != -1 &&
        IntFloorId != -1 &&
        IntRoomId != -1;
  }
}