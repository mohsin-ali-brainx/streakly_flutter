import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget leading;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = selected ? cs.primaryContainer : cs.surfaceContainerHighest;
    final border = selected ? cs.primary : cs.outlineVariant;

    return InkWell(
      borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          border: Border.all(color: border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.space3xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(AppDimens.radiusSm + 2),
                      border: Border.all(color: cs.outlineVariant),
                    ),
                    alignment: Alignment.center,
                    child: leading,
                  ),
                  const Spacer(),
                  if (selected)
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: cs.primary,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.check, size: 16, color: cs.onPrimary),
                    ),
                ],
              ),
              const SizedBox(height: AppDimens.spaceLg),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

