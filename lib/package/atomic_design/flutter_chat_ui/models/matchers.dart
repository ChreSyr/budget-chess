import 'package:crea_chess/package/atomic_design/flutter_chat_ui/models/pattern_style.dart';
import 'package:crea_chess/package/chat/flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

MatchText mailToMatcher({TextStyle? style}) => MatchText(
      onTap: (mail) async {
        final url = Uri(scheme: 'mailto', path: mail);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
      pattern: regexEmail,
      style: style,
    );

MatchText urlMatcher({
  TextStyle? style,
  void Function(String url)? onLinkPressed,
}) =>
    MatchText(
      onTap: (urlText) async {
        final protocolIdentifierRegex = RegExp(
          r'^((http|ftp|https):\/\/)',
          caseSensitive: false,
        );
        if (!urlText.startsWith(protocolIdentifierRegex)) {
          urlText = 'https://$urlText';
        }
        if (onLinkPressed != null) {
          onLinkPressed(urlText);
        } else {
          final url = Uri.tryParse(urlText);
          if (url != null && await canLaunchUrl(url)) {
            await launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          }
        }
      },
      pattern: regexLink,
      style: style,
    );

MatchText _patternStyleMatcher({
  required PatternStyle patternStyle,
  TextStyle? style,
}) =>
    MatchText(
      pattern: patternStyle.pattern,
      style: style,
      renderText: ({required String str, required String pattern}) => {
        'display': str.replaceAll(
          patternStyle.from,
          patternStyle.replace,
        ),
      },
    );

MatchText boldMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.bold,
      style: style,
    );

MatchText italicMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.italic,
      style: style,
    );

MatchText lineThroughMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.lineThrough,
      style: style,
    );

MatchText codeMatcher({TextStyle? style}) => _patternStyleMatcher(
      patternStyle: PatternStyle.code,
      style: style,
    );
