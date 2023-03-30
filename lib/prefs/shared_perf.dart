import 'package:api/models/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PerfKeys { id, fullName, email, gender, token, loggedIn }

class SharedPerfController {
  SharedPerfController._();

  late SharedPreferences _sharedPreferences;

  static SharedPerfController? _instance;

  factory SharedPerfController() {
    return _instance ??= SharedPerfController._();
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void save(Student student) async {
    await _sharedPreferences.setBool(PerfKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(PerfKeys.id.name, student.id);
    await _sharedPreferences.setString(
        PerfKeys.fullName.name, student.fullName);
    await _sharedPreferences.setString(PerfKeys.email.name, student.email);
    await _sharedPreferences.setString(PerfKeys.gender.name, student.gender);
    await _sharedPreferences.setString(
        PerfKeys.token.name, 'Bearer ${student.token}');
  }

  T? getValueFor<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T?;
    }
    return null;
  }
  void clear()async{
    _sharedPreferences.clear() ;
  }
}
