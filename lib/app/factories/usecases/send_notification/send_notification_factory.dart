import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/send_notification/remote_fetch_send_notification.dart';
import 'package:ecommerce/domain/usecases/send_notification/fetch_send_notification.dart';

FetchSendNotification makeFetchSendNotification() =>
    RemoteFetchSendNotification(
      client: makeHttpAuthorizedAdapter(),
      url: 'https://fcm.googleapis.com/fcm/send',
    );
