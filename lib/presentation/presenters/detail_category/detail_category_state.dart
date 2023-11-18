// ignore_for_file: public_member_api_docs, sort_constructors_first
class DetailCategoryState {
  final bool isLoading;
  final int tabIndex;
  final List<String> sizes;
  final List<String> colors;
  final List<String> prices;
  final List<Map<String, dynamic>> selectedSizes;
  final List<Map<String, dynamic>> selectedColors;
  final List<Map<String, dynamic>> selectedPrices;
  final String sort;

  DetailCategoryState({
    required this.isLoading,
    required this.tabIndex,
    required this.sizes,
    required this.colors,
    required this.prices,
    required this.selectedSizes,
    required this.selectedColors,
    required this.selectedPrices,
    required this.sort,
  });

  factory DetailCategoryState.initial() {
    return DetailCategoryState(
      isLoading: false,
      tabIndex: 0,
      colors: [],
      sizes: [],
      prices: [],
      selectedColors: [],
      selectedPrices: [],
      selectedSizes: [],
      sort: 'Created descending',
    );
  }

  DetailCategoryState copyWith({
    bool? isLoading,
    int? tabIndex,
    List<String>? sizes,
    List<String>? colors,
    List<String>? prices,
    List<Map<String, dynamic>>? selectedSizes,
    List<Map<String, dynamic>>? selectedColors,
    List<Map<String, dynamic>>? selectedPrices,
    String? sort,
  }) {
    return DetailCategoryState(
      isLoading: isLoading ?? this.isLoading,
      tabIndex: tabIndex ?? this.tabIndex,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      prices: prices ?? this.prices,
      selectedSizes: selectedSizes ?? this.selectedSizes,
      selectedColors: selectedColors ?? this.selectedColors,
      selectedPrices: selectedPrices ?? this.selectedPrices,
      sort: sort ?? this.sort,
    );
  }
}
