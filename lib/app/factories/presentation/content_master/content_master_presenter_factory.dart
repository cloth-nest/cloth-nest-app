import 'package:ecommerce/app/factories/usecases/category/category_factory.dart';
import 'package:ecommerce/presentation/presenters/content_master/provider_content_master_presenter.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';

ContentMasterPresenter makeContentMasterPresenter() =>
    ProviderContentMasterPresenter(
      fetchCategory: makeFetchCategory(),
    );
