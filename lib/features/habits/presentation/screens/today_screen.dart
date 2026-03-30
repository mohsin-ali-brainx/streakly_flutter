import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.space2xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TodayStrings.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppDimens.spaceSm),
            Text(
              TodayStrings.placeholder,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimens.space2xl),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.space2xl),
                child: Row(
                  children: [
                    const Icon(Icons.shield_outlined),
                    const SizedBox(width: AppDimens.spaceLg),
                    Expanded(
                      child: Text(
                        TodayStrings.insuranceCard,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    FilledButton(
                      onPressed: null,
                      child: Text(TodayStrings.useInsurance),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
