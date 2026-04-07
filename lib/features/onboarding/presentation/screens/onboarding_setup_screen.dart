import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/onboarding_progress.dart';
import '../../../../core/l10n/app_strings.dart';
import '../../../../shared/presentation/widgets/onboarding_eyebrow_text.dart';
import '../../../../shared/presentation/widgets/onboarding_progress_header.dart';
import '../../../../shared/presentation/widgets/streakly_primary_async_button.dart';
import '../../../habits/presentation/widgets/habit_emoji_badge.dart';
import '../../domain/starter_habit_template.dart';
import '../controller/onboarding_setup_controller.dart';
import '../widgets/template_card.dart';

class OnboardingSetupScreen extends StatelessWidget {
  const OnboardingSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingSetupController(),
      child: const _OnboardingSetupView(),
    );
  }
}

class _OnboardingSetupView extends StatelessWidget {
  const _OnboardingSetupView();

  Future<void> _showAddCustomHabitDialog(
    BuildContext context,
    OnboardingSetupController controller,
  ) async {
    final result = await showDialog<_AddCustomHabitDialogResult?>(
      context: context,
      builder: (dialogContext) => const _AddCustomHabitDialog(),
    );
    if (!context.mounted || result == null) return;
    controller.addCustomHabit(title: result.title, subtitle: result.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OnboardingProgressHeader(step: OnboardingProgress.setupStep),
                SizedBox(height: AppDimens.spaceXl),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: AppDimens.onboardingBodyPadding,
              children: [
                const SizedBox(height: 6),
                const OnboardingEyebrowText(label: SetupStrings.eyebrow),
                const SizedBox(height: AppDimens.spaceSm),
                Text(
                  SetupStrings.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: AppDimens.spaceMd),
                Text(
                  SetupStrings.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: AppDimens.space3xl),
                Consumer<OnboardingSetupController>(
                  builder: (context, c, _) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppDimens.gridCrossAxisSpacing,
                            mainAxisSpacing: AppDimens.gridMainAxisSpacing,
                            childAspectRatio: 0.74,
                          ),
                      itemCount:
                          kStarterTemplates.length +
                          c.customTemplates.length +
                          1,
                      itemBuilder: (context, index) {
                        final customStart = kStarterTemplates.length;
                        final addButtonIndex =
                            customStart + c.customTemplates.length;

                        if (index == addButtonIndex) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(
                              AppDimens.radiusLg,
                            ),
                            onTap: () => _showAddCustomHabitDialog(context, c),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: cs.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(
                                  AppDimens.radiusLg,
                                ),
                                border: Border.all(color: cs.outlineVariant),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                          color: cs.outlineVariant,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.add,
                                        color: cs.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: AppDimens.spaceMd),
                                    Text(
                                      SetupStrings.customHabit,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                            color: cs.onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }

                        if (index >= customStart) {
                          final t = c.customTemplates[index - customStart];
                          final selected = c.selectedIds.contains(t.id);
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              TemplateCard(
                                title: t.title,
                                subtitle: t.subtitle,
                                leading: HabitEmojiBadge(iconKey: t.iconKey),
                                selected: selected,
                                onTap: () => c.toggle(t.id),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: IconButton(
                                    visualDensity: VisualDensity.compact,
                                    style: IconButton.styleFrom(
                                      backgroundColor: cs.surface.withValues(
                                        alpha: 0.92,
                                      ),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    icon: Icon(
                                      Icons.close,
                                      size: 18,
                                      color: cs.onSurfaceVariant,
                                    ),
                                    onPressed: () =>
                                        c.removeCustomTemplate(t.id),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        final t = kStarterTemplates[index];
                        final selected = c.selectedIds.contains(t.id);
                        return TemplateCard(
                          title: t.title,
                          subtitle: t.subtitle,
                          leading: HabitEmojiBadge(iconKey: t.iconKey),
                          selected: selected,
                          onTap: () => c.toggle(t.id),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppDimens.space3xl),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimens.radiusLg),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        cs.secondaryContainer.withValues(alpha: 0.7),
                        cs.tertiaryContainer.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.all(AppDimens.space3xl),
                  child: Text(
                    SetupStrings.quote,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: cs.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<OnboardingSetupController>(
            builder: (context, c, _) {
              // Color must sit *outside* [SafeArea], or the bottom inset stays
              // transparent and scroll content shows through.
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: cs.surface,
                  border: Border(top: BorderSide(color: cs.outlineVariant)),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimens.pagePaddingH,
                      AppDimens.spaceXl,
                      AppDimens.pagePaddingH,
                      AppDimens.space2xl,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreaklyPrimaryAsyncButton(
                          label: SetupStrings.next,
                          isLoading: c.submitting,
                          onPressed: () async {
                            await c.finishSetup();
                            if (!context.mounted) return;
                            context.go(AppRoutes.onboardingNotifications);
                          },
                        ),
                        const SizedBox(height: AppDimens.spaceMd),
                        Text(
                          SetupStrings.footerHint,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: cs.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AddCustomHabitDialogResult {
  const _AddCustomHabitDialogResult({required this.title, this.subtitle});

  final String title;
  final String? subtitle;
}

class _AddCustomHabitDialog extends StatefulWidget {
  const _AddCustomHabitDialog();

  @override
  State<_AddCustomHabitDialog> createState() => _AddCustomHabitDialogState();
}

class _AddCustomHabitDialogState extends State<_AddCustomHabitDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _categoryController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _nameController.text.trim();
    if (title.isEmpty) return;
    final sub = _categoryController.text.trim();
    Navigator.of(context).pop(
      _AddCustomHabitDialogResult(
        title: title,
        subtitle: sub.isEmpty ? null : sub,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(SetupStrings.dialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: SetupStrings.habitNameLabel,
                hintText: SetupStrings.habitNameHint,
              ),
              autofocus: true,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: AppDimens.space2xl),
            TextField(
              controller: _categoryController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: SetupStrings.categoryLabel,
                hintText: SetupStrings.categoryHint,
              ),
              textInputAction: TextInputAction.done,
              maxLines: 2,
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(AppStrings.add)),
      ],
    );
  }
}
