import 'package:http/http.dart' as http;

class Services {
  List uids = [];
  // Map<String,dynamic> _para() {
  //   Map<String,dynamic> map = {};
  //   map['uid'] = uids;
  // }
  static createSem(uids, String sem) async {
    Map<String,dynamic> body = {};
    body['uid']= uids;
    body['semester'] = sem;
    var result = await http.post(
        "http://192.168.0.115/fiwi_apis/api-d/admin/attendance/assign_semester.php",
        body: body);
        print(result.body);
  }
}
