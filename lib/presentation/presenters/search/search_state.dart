enum GenderType { women, men, kids, baby }

class SearchState {
  final int currentTabIndex;

  SearchState({
    required this.currentTabIndex,
  });

  factory SearchState.initial() {
    return SearchState(
      currentTabIndex: 0,
    );
  }

  SearchState copyWith({
    int? currentTabIndex,
  }) {
    return SearchState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
