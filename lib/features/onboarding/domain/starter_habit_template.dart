class StarterHabitTemplate {
  const StarterHabitTemplate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconKey,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconKey;
}

const List<StarterHabitTemplate> kStarterTemplates = [
  StarterHabitTemplate(
    id: 'read10',
    title: 'Read 10 mins',
    subtitle: 'Expand your mind daily.',
    iconKey: 'read',
  ),
  StarterHabitTemplate(
    id: 'water',
    title: 'Drink Water',
    subtitle: 'Stay hydrated, stay clear.',
    iconKey: 'water',
  ),
  StarterHabitTemplate(
    id: 'meditate',
    title: 'Meditate',
    subtitle: 'Find your center.',
    iconKey: 'meditate',
  ),
  StarterHabitTemplate(
    id: 'walk',
    title: 'Morning Walk',
    subtitle: 'Wake up with movement.',
    iconKey: 'walk',
  ),
  StarterHabitTemplate(
    id: 'journal',
    title: 'Journal',
    subtitle: 'Reflect on your growth.',
    iconKey: 'journal',
  ),
];

