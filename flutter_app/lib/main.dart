import 'package:flutter/material.dart';

void main() {
  runApp(const JPStudyApp());
}

class JPStudyApp extends StatelessWidget {
  const JPStudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JP Study',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: const MainShell(),
    );
  }
}

class AppColors {
  static const background = Color(0xFFE7EAEF);
  static const navStart = Color(0xFFF7F9FC);
  static const navEnd = Color(0xFFDDE3ED);
  static const navActiveStart = Color(0xFF3D5B8C);
  static const navActiveEnd = Color(0xFF2F456D);
  static const navBorder = Color(0xFFC4CCDA);
  static const card = Color(0xFFFDFDFF);
  static const cardBorder = Color(0xFFC7D0DE);
  static const textPrimary = Color(0xFF1F2733);
  static const textSubtle = Color(0xFF4B5563);
  static const gradeAgain = Color(0xFFD9534F);
  static const gradeHard = Color(0xFFF0AD4E);
  static const gradeGood = Color(0xFF5CB85C);
  static const gradeEasy = Color(0xFF5BC0DE);
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Segoe UI',
      fontFamilyFallback: const ['Noto Sans', 'Roboto', 'Arial'],
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.navActiveStart,
        surface: AppColors.card,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.textSubtle,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.cardBorder),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );

    return base;
  }
}

class NavItem {
  final String label;
  final Widget view;

  const NavItem({required this.label, required this.view});
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  late final List<NavItem> _items = [
    const NavItem(label: 'Home', view: HomeView()),
    const NavItem(label: 'A - Import', view: ImportView()),
    const NavItem(label: 'B - SRS', view: SrsView()),
    const NavItem(label: 'C - Cloze', view: ClozeView()),
    const NavItem(label: 'D - Test', view: TestView()),
  ];

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NavBar(
              brand: 'JP Study',
              currentIndex: _index,
              items: _items,
              onTap: _setIndex,
            ),
            Expanded(
              child: IndexedStack(
                index: _index,
                children: _items.map((item) => item.view).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final String brand;
  final int currentIndex;
  final List<NavItem> items;
  final ValueChanged<int> onTap;

  const NavBar({
    super.key,
    required this.brand,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navStart, AppColors.navEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.navBorder),
      ),
      child: Row(
        children: [
          Text(
            brand,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF1F3D68),
                ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(items.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: NavButton(
                      label: items[index].label,
                      isActive: currentIndex == index,
                      onTap: () => onTap(index),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : AppColors.textPrimary,
        );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [AppColors.navActiveStart, AppColors.navActiveEnd],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [Color(0xFFF8FAFD), Color(0xFFE4E8F1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? const Color(0xFF2A3D60) : const Color(0xFFBDC6D6),
          ),
        ),
        child: Text(label, style: textStyle),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class GradeButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;

  const GradeButton({
    super.key,
    required this.label,
    required this.color,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
      child: Text(label),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Text('Daily Plan - A/B/C/D', style: titleStyle),
        const SizedBox(height: 8),
        Text('Total items: 0 | Due today: 0', style: subtitleStyle),
        Text('Activity: 0 | Acc: 0%', style: subtitleStyle),
        Text('Streak: 0 days | Goal: 30/day', style: subtitleStyle),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quick actions', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _ActionChip(label: 'Start SRS'),
                  _ActionChip(label: 'Import CSV'),
                  _ActionChip(label: 'Export attempts'),
                ],
              ),
            ],
          ),
        ),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tip', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(
                'After import, cards are scheduled for today.\n'
                'Goal: SRS daily, then expand with Cloze/Test.',
                style: subtitleStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImportView extends StatelessWidget {
  const ImportView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Text('A - Import', style: titleStyle),
        const SizedBox(height: 8),
        Text('Import CSV or add cards manually.', style: subtitleStyle),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Actions', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _ActionChip(label: 'Import CSV'),
                  _ActionChip(label: 'Auto Import'),
                  _ActionChip(label: 'Add item'),
                ],
              ),
            ],
          ),
        ),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Preview table', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Latest items will show here.', style: subtitleStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class SrsView extends StatelessWidget {
  const SrsView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Text('B - SRS Review', style: titleStyle),
        const SizedBox(height: 8),
        Text('Queue: 0 | JLPT: all | tag: all', style: subtitleStyle),
        SectionCard(
          child: Column(
            children: [
              Text('Front: [vocab] term', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Text('Back: meaning / example / tags', style: subtitleStyle),
              const SizedBox(height: 16),
              const Wrap(
                spacing: 10,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  GradeButton(label: 'Again', color: AppColors.gradeAgain, textColor: Colors.white),
                  GradeButton(label: 'Hard', color: AppColors.gradeHard, textColor: Colors.black87),
                  GradeButton(label: 'Good', color: AppColors.gradeGood, textColor: Colors.white),
                  GradeButton(label: 'Easy', color: AppColors.gradeEasy, textColor: Colors.black87),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ClozeView extends StatelessWidget {
  const ClozeView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Text('C - Cloze Practice', style: titleStyle),
        const SizedBox(height: 8),
        Text('Queue: 0 (mistakes first)', style: subtitleStyle),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sentence with ____', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Text('Hint: meaning (term reading)', style: subtitleStyle),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(labelText: 'Your answer'),
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 12,
                children: [
                  _ActionChip(label: 'Check'),
                  _ActionChip(label: 'Show answer'),
                  _ActionChip(label: 'Next'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TestView extends StatelessWidget {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Text('D - Mini Test', style: titleStyle),
        const SizedBox(height: 8),
        Text('Mode: mix | JLPT: all | tag: all', style: subtitleStyle),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Question 1/10', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Sentence with ____', style: subtitleStyle),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(labelText: 'Your answer'),
              ),
              const SizedBox(height: 12),
              const Wrap(
                spacing: 12,
                children: [
                  _ActionChip(label: 'Check'),
                  _ActionChip(label: 'Show answer'),
                  _ActionChip(label: 'Next'),
                  _ActionChip(label: 'Restart'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;

  const _ActionChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}
