.PHONY: help
help: ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

.PHONY: install
install: ## install all dependencies
	npm install \
	&& flutter pub get \
	&& cd ios && pod install && cd .. \
	&& flutter pub run easy_localization:generate -S "assets/translations" -O "lib/generated" -f keys -o locale_keys.g.dart


.PHONY: generate-language
generate-language: ## generate template language
	flutter pub run easy_localization:generate -S "assets/translations" -O "lib/app/res" -f keys -o locale_keys.g.dart

.PHONY: generate-hive
generate-hive: ## generate template language
	flutter pub run build_runner build --delete-conflicting-outputs

.PHONY: start-dev
start-dev: ## start app with dev environment
	flutter run --flavor dev -t lib/main_dev.dart --debug

.PHONY: start-stg
start-stg: ## start app with staging environment
	flutter run --flavor staging -t lib/main_staging.dart --debug

.PHONY: start-prod
start-prod: ## start app with production environment
	flutter run --flavor prod -t lib/main_production.dart --debug

.PHONY: generate-splash-screen
generate-splash-screen: ## generate splash screen
	flutter clean \
	&& make install \
	&& flutter pub run flutter_native_splash:create --path=./flutter_native_splash.yaml

.PHONY: clean
clean: ## clean all dependencies
	flutter clean \
	&& flutter pub cache clean

.PHONY: build-android-dev
build-android-dev: ## build apk on android for development
	flutter build apk --flavor dev -t lib/main_dev.dart --release --no-tree-shake-icons

.PHONY: build-android-stg
build-android-stg: ## build apk on android for development
	flutter build apk --flavor staging -t lib/main_staging.dart --release --no-tree-shake-icons

.PHONY: build-android-prod
build-android-prod: ## build apk on android for development
	flutter build apk --flavor prod -t lib/main_production.dart --release --no-tree-shake-icons	

.PHONY: build-ios-dev
build-ios-dev: ## build ipa on ios for development
	flutter build ipa --flavor dev -t lib/main_dev.dart --release --no-tree-shake-icons --export-options-plist "ios/exportOptions.plist"

.PHONY: build-ios-stg
build-ios-stg: ## build ipa on ios for development
	flutter build ipa --flavor staging -t lib/main_staging.dart --release --no-tree-shake-icons --export-options-plist "ios/exportOptions.plist"

.PHONY: build-ios-prod
build-ios-prod: ## build ipa on ios for development
	flutter build ipa --flavor prod -t lib/main_production.dart --release --no-tree-shake-icons --export-options-plist "ios/exportOptions.plist"	

.PHONY: deploy-android-dev
deploy-android-dev: ## deploy apk on android for development
	cd android \
	&& bundle exec fastlane upload_appcenter_dev

.PHONY: deploy-ios-dev
deploy-ios-dev: ## deploy ipa on ios for development
	cd ios \
	&& bundle exec fastlane upload_appcenter_dev

.PHONY: generate-file
generate-file: ## generate file
	flutter pub run build_runner build --delete-conflicting-outputs
.PHONY: generate-pigeon
generate-pigeon: ## generate pigeon file
	flutter pub run pigeon \
	--input pigeons/region_popup.dart \
	--dart_out lib/generated/region_popup.dart \
    --swift_out ios/Runner/RegionPopup.swift \
    --kotlin_out android/app/src/main/kotlin/com/yomumiru/pigeon/RegionPopup.kt \
    --kotlin_package "com.yomumiru.pigeon"