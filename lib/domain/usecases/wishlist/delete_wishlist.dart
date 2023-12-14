abstract class DeleteWishlist {
  Future<void> deleteLocal({required int defautVariantId});
}

abstract class DeleteRemoteWishlist {
  Future<void> deleteRemote({required List<int> variantIds});
}
