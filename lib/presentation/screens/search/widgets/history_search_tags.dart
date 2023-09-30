import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/res/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../../app/utils/extensions/theme_extension.dart';

class HistorySearchTags extends StatelessWidget {
  final List<String> tags;
  final Function(String) onTap;

  const HistorySearchTags({
    super.key,
    required this.tags,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return tags.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.historySearch.tr(),
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 15,
                      ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: tags
                      .map((tag) => InkWell(
                            onTap: () => onTap(tag),
                            child: TagSearch(tag: tag),
                          ))
                      .toList(),
                ),
              ],
            ),
          );
  }
}

class TagSearch extends StatelessWidget {
  final String tag;

  const TagSearch({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Theme.of(context).extension<ExtensionColors>()!.line!,
        ),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
