import 'dart:io';

abstract class FetchUploadAvatar {
  Future<String> call({required File file});
}
