// ignore_for_file: public_member_api_docs, sort_constructors_first
class AccountState {
  final bool isLoading;
  final String? navigateTo;

  factory AccountState.initial() {
    return AccountState(isLoading: false);
  }

  AccountState({required this.isLoading, this.navigateTo});

  AccountState copyWith({
    bool? isLoading,
    String? navigateTo,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      navigateTo: navigateTo ?? this.navigateTo,
    );
  }
}
