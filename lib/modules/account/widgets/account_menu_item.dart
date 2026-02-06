import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountMenuItem extends StatelessWidget {
  final IconData? icon;
  final String? iconPath;
  final String title;
  final String? trailing;
  final bool isExternal;
  final VoidCallback? onTap;

  const AccountMenuItem({
    super.key,
    this.icon,
    this.iconPath,
    required this.title,
    this.trailing,
    this.isExternal = false,
    this.onTap,
  }) : assert(icon != null || iconPath != null, 'Either icon or iconPath must be provided');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            if (iconPath != null)
              iconPath!.endsWith('.svg')
                  ? SvgPicture.asset(
                      iconPath!,
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                    )
                  : Image.asset(
                      iconPath!,
                      width: 22,
                      height: 22,
                      color: Colors.black87,
                    )
            else
              Icon(
                icon,
                size: 22,
                color: Colors.black87,
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              isExternal ? Icons.open_in_new : Icons.chevron_right,
              size: 20,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
