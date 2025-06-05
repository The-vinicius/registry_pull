import 'package:registry_pull/app/interactor/repositories/last_mucle_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalLastMuscleRepository implements LastMuscleRepository {
  @override
  Future<void> saveLastMuscle(String muscle) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("muscle", muscle);
  }

  @override
  Future<String?> getLastMuscle() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? muscleName = prefs.getString("muscle");
    return muscleName;
  }
}
