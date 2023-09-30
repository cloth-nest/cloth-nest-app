import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class OnboardingLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('onboarding'),
        title: 'onboarding',
        child: Container(),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/onboarding'];
}
