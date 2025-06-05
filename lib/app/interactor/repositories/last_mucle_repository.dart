abstract class LastMuscleRepository {
  Future<void> saveLastMuscle(String muscle);
  Future<String?> getLastMuscle();
}
