import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.space2xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              HabitsStrings.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppDimens.spaceSm),
            Text(
              HabitsStrings.placeholder,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimens.space2xl),
            FilledButton.icon(
              onPressed: null,
              icon: const Icon(Icons.add),
              label: Text(HabitsStrings.addHabit),
            ),
          ],
        ),
      ),
    );
  }
}
