String makeApiUri(String path) {
  const String apiUrl = 'localhost:8000/';
  return 'https://$apiUrl$path';
}
