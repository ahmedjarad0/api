class ApiSetting{
  static const String _basicUrl = "http://demo-api.mr-dev.tech/api/";
  static const String users  = '${_basicUrl}users';
  static const String login  = '${_basicUrl}students/auth/login';
  static const String register  = '${_basicUrl}students/auth/register';
  static const String logout  = '${_basicUrl}students/auth/logout';
  static const String images  = '${_basicUrl}student/images/{id}';
}