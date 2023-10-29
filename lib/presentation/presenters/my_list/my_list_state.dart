// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyListState {
  final bool isLoading;

  MyListState({
    required this.isLoading,
  });

  factory MyListState.initial() {
    return MyListState(
      isLoading: false,
    );
  }

  MyListState copyWith({
    bool? isLoading,
  }) {
    return MyListState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
