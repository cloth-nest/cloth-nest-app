String makeApiUrl(String path) {
  const String apiUrl = 'localhost:9000/';
  return 'http://$apiUrl$path';
}
