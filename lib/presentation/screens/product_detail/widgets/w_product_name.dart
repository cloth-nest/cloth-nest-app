import 'package:flutter/material.dart';

class WProductName extends StatelessWidget {
  const WProductName({super.key, required this.marginSide});

  final double marginSide;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.only(left: marginSide, right: marginSide, bottom: 10),
        child: Text(
          'DC x BR Mate T-shirt - Cream',
          style: Theme.of(context).textTheme.displayMedium,
        ));
    // return Selector<EpisodeDetailPresenter, bool>(
    //   selector: (_, presenter) => presenter.isLoading,
    //   builder: (_, isLoading, __) => isLoading
    //       ? Padding(
    //           padding: EdgeInsets.only(
    //               left: marginSide, right: marginSide, bottom: 10),
    //           child: Row(
    //             children: [
    //               const Skeleton(
    //                 height: 20,
    //                 width: 180,
    //               )
    //             ],
    //           ),
    //         )
    //       : Selector<EpisodeDetailPresenter, String>(
    //           selector: (_, presenter) => presenter.episodeName,
    //           builder: (_, episodeName, __) => Padding(
    //             padding: EdgeInsets.only(
    //                 left: marginSide, right: marginSide, bottom: 10),
    //             child: episodeName.isNotEmpty
    //                 ? Text(
    //                     episodeName,
    //                     style: Theme.of(context).textTheme.displayMedium,
    //                   )
    //                 : const SizedBox.shrink(),
    //           ),
    //         ),
    // );
  }
}
