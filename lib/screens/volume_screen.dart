import 'package:calculator/consts/colors.dart';
import 'package:calculator/provider/volume_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolumeScreen extends StatelessWidget {
  const VolumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return ChangeNotifierProvider(
      create: (_) => VolumeProvider(),
      child: Consumer<VolumeProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Volume'),
              centerTitle: true,
              elevation: 0,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: width * 0.08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: provider.fromUnit,
                        items: provider.units
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e, style: TextStyle(fontSize: width * 0.045)),
                                ))
                            .toList(),
                        onChanged: provider.changeFromUnit,
                        underline: const SizedBox(),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            provider.input,
                            style: TextStyle(
                              fontSize: width * 0.07,
                              color: ColorClass.orange,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        value: provider.toUnit,
                        items: provider.units
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e, style: TextStyle(fontSize: width * 0.045, color: ColorClass.white)),
                                ))
                            .toList(),
                        onChanged: provider.changeToUnit,
                        underline: const SizedBox(),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            provider.output,
                            style: TextStyle(
                              fontSize: width * 0.07,
                              color: ColorClass.orange,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.08),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ...[
                          ['C', '⌫', '%', '÷'],
                          ['7', '8', '9', '×'],
                          ['4', '5', '6', '-'],
                          ['1', '2', '3', '+'],
                          ['00', '0', '.', '=']
                        ].map((row) => Padding(
                              padding: EdgeInsets.only(bottom: width * 0.025),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: row
                                    .map((btn) => GestureDetector(
                                          onTap: () {
                                            provider.buttonPressed(btn);
                                          },
                                          child: Container(
                                            height: width / 6,
                                            width: width / 6,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: btn == '='
                                                  ? ColorClass.orange
                                                  : ColorClass.white,
                                              borderRadius: BorderRadius.circular(width * 0.05),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              btn,
                                              style: TextStyle(
                                                fontSize: width * 0.055,
                                                fontWeight: FontWeight.bold,
                                                color: btn == '='
                                                    ? ColorClass.white
                                                    : btn == 'C' ||
                                                            btn == '÷' ||
                                                            btn == '×' ||
                                                            btn == '-' ||
                                                            btn == '+'
                                                        ? ColorClass.orange
                                                        : ColorClass.black,
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            )),
                        SizedBox(height: width * 0.04),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 