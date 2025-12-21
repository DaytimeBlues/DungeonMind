import 'package:flutter/material.dart';

class GrimoireScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool withNoise;

  const GrimoireScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.withNoise = true,
  });

  @override
  Widget build(BuildContext context) {
    // Access theme colors for gradient
    final colorScheme = Theme.of(context).colorScheme;
    
    return Stack(
      children: [
        // 1. Base Background
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        
        // 2. Atmospheric Gradient (Subtle bottom-center glow)
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.bottomCenter,
                radius: 1.5,
                colors: [
                  colorScheme.primary.withOpacity(0.05), // Very subtle purple glow
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6],
              ),
            ),
          ),
        ),
        
        // 3. Noise Overlay (Optional - Simulated via specific image or pattern, 
        // but for now, we skip image assets to avoid missing files. 
        // We could use a CustomPainter for grain if needed, but gradient is enough for the "Hook".)
        
        // 4. Actual Scaffold with transparent background
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          drawer: drawer,
        ),
      ],
    );
  }
}
