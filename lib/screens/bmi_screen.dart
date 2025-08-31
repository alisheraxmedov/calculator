import 'package:calculator/consts/colors.dart';
import 'package:calculator/provider/bmi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BMIScreen extends StatelessWidget {
  const BMIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
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
                title: const Text('Body Mass Index'),
                centerTitle: true,
                elevation: 0,
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width * 0.08),
                    Text(
                      'Jins',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: width * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => provider.updateGender('Male'),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.03),
                              decoration: BoxDecoration(
                                color: provider.gender == 'Male'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(width * 0.03),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                    color: provider.gender == 'Male'
                                        ? ColorClass.white
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      color: provider.gender == 'Male'
                                          ? ColorClass.white
                                          : Theme.of(context).colorScheme.primary,
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => provider.updateGender('Female'),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: width * 0.03),
                              decoration: BoxDecoration(
                                color: provider.gender == 'Female'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(width * 0.03),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.female,
                                    color: provider.gender == 'Female'
                                        ? ColorClass.white
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      color: provider.gender == 'Female'
                                          ? ColorClass.white
                                          : Theme.of(context).colorScheme.primary,
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * 0.08),
                    Text(
                      'Length (cm)',
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
                      '${provider.height.round()} sm',
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: ColorClass.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: width * 0.08),
                    Text(
                      'Weight (kg)',
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
                      '${provider.weight.round()} kg',
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
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(width * 0.05),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BMI: ${provider.bmi.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: width * 0.06,
                              fontWeight: FontWeight.bold,
                              color: ColorClass.orange,
                            ),
                          ),
                          SizedBox(height: width * 0.02),
                          Text(
                            'Category: ${provider.category}',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          SizedBox(height: width * 0.02),
                          Text(
                            'Gender: ${provider.gender}',
                            style: TextStyle(
                              fontSize: width * 0.045,
                              color: Theme.of(context).colorScheme.onBackground,
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
} 