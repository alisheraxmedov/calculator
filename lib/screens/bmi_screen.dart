import 'package:calculator/consts/colors.dart';
import 'package:calculator/l10n/app_localizations.dart';
import 'package:calculator/provider/bmi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BMIScreen extends StatelessWidget {
  const BMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => BMIProvider(),
        child: Consumer<BMIProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(l10n.screenBmi),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width * 0.08),
                    Text(
                      l10n.bmiGender,
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: width * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: _GenderTile(
                            label: l10n.bmiMale,
                            icon: Icons.male,
                            selected: provider.gender == BmiGender.male,
                            onTap: () => provider.updateGender(BmiGender.male),
                            width: width,
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Expanded(
                          child: _GenderTile(
                            label: l10n.bmiFemale,
                            icon: Icons.female,
                            selected: provider.gender == BmiGender.female,
                            onTap: () =>
                                provider.updateGender(BmiGender.female),
                            width: width,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * 0.08),
                    Text(
                      l10n.bmiHeightLabel,
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Slider(
                      value: provider.height,
                      min: 100,
                      max: 250,
                      divisions: 150,
                      label: provider.height.round().toString(),
                      onChanged: provider.updateHeight,
                    ),
                    Text(
                      l10n.bmiHeightValue(provider.height.round()),
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: ColorClass.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: width * 0.08),
                    Text(
                      l10n.bmiWeightLabel,
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Slider(
                      value: provider.weight,
                      min: 30,
                      max: 200,
                      divisions: 170,
                      label: provider.weight.round().toString(),
                      onChanged: provider.updateWeight,
                    ),
                    Text(
                      l10n.bmiWeightValue(provider.weight.round()),
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: ColorClass.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: width * 0.08),
                    Container(
                      width: width * 0.9,
                      padding: EdgeInsets.all(width * 0.05),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(width * 0.05),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.bmiResult(provider.bmi.toStringAsFixed(1)),
                            style: TextStyle(
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: ColorClass.orange,
                            ),
                          ),
                          SizedBox(height: width * 0.02),
                          Text(
                            l10n.bmiCategoryLabel(_categoryLabel(provider.category, l10n)),
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: width * 0.02),
                          Text(
                            l10n.bmiGenderLabel(_genderLabel(provider.gender, l10n)),
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _categoryLabel(BmiCategory c, AppLocalizations l10n) {
    switch (c) {
      case BmiCategory.underweight:
        return l10n.bmiUnderweight;
      case BmiCategory.normal:
        return l10n.bmiNormal;
      case BmiCategory.overweight:
        return l10n.bmiOverweight;
      case BmiCategory.obesity:
        return l10n.bmiObesity;
    }
  }

  String _genderLabel(BmiGender g, AppLocalizations l10n) {
    return g == BmiGender.male ? l10n.bmiMale : l10n.bmiFemale;
  }
}

class _GenderTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final double width;

  const _GenderTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.03),
        decoration: BoxDecoration(
          color: selected ? primary : primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(width * 0.03),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? ColorClass.white : primary),
            SizedBox(width: width * 0.02),
            Text(
              label,
              style: TextStyle(
                color: selected ? ColorClass.white : primary,
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
