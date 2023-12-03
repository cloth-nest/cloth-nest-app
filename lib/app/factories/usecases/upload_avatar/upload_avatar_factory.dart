import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/data/usecases/upload_avatar/remote_fetch_upload_avatar.dart';
import 'package:ecommerce/domain/usecases/upload_avatar/fetch_upload_avatar.dart';

FetchUploadAvatar makeFetchUploadAvatar() =>
    RemoteFetchUploadAvatar(url: makeApiUrl('user/upload-avatar'));
