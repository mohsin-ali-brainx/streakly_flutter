import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/l10n/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.space2xl),
        children: [
          Text(
            SettingsStrings.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: AppDimens.spaceLg),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: Text(SettingsStrings.notificationsTitle),
            subtitle: Text(SettingsStrings.notificationsSubtitle),
            trailing: Text(AppStrings.commonSoon),
          ),
          ListTile(
            leading: const Icon(Icons.color_lens_outlined),
            title: Text(SettingsStrings.themeTitle),
            subtitle: Text(SettingsStrings.themeSubtitle),
            trailing: Text(SettingsStrings.system),
          ),
          ListTile(
            leading: const Icon(Icons.shield_outlined),
            title: Text(SettingsStrings.insuranceTitle),
            subtitle: Text(SettingsStrings.insuranceSubtitle),
            trailing: Text(SettingsStrings.tokensPlaceholder),
          ),
        ],
      ),
    );
  }
}
