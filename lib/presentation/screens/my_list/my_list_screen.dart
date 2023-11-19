import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/my_list_sliver_list.dart';
import 'package:ecommerce/presentation/screens/my_list/widgets/my_list_sliver_list_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({super.key});

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  late MyListPresenter _presenter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = context.read<MyListPresenter>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.getData();
    });
  }

  void _onProductTap() {
    final String currentLocation =
        context.currentBeamLocation.state.routeInformation.location ?? '/';
    final uri = Uri.parse(currentLocation);
    context.beamToNamed('${uri.path}/product');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My List',
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textLightBasic,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0.3,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 10,
              ),
              child: Text(
                '0 Item(s)',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _presenter.refreshData,
        child: Selector<MyListPresenter, bool>(
          selector: (_, presenter) => presenter.isLoading,
          builder: (_, isLoading, __) => CustomScrollView(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            physics: isLoading
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            slivers: [
              isLoading
                  ? const MyListSliverListLoading()
                  : MyListSliverList(
                      onTap: _onProductTap,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
