class Endpoints {
  Endpoints._();

  static const urlApi = 'http://localhost:5555';

  static const apkType = 'apk_medico';

  // Auth Endpoints
  static const login = '/login';
  static const refreshToken = '/refreshToken';
  static const forgotPassword = '/forgotPassword';
  static const newPassword = '/newPassword';

  // Medic Endpoints
  static const userDoctor = '/userDoctor';
  static const schedules = '/doctorSchedules';

  // Patient Endpoints
  static const patientList = '/getPatientListByDoctor';
}
