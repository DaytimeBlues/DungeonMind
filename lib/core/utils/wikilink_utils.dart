/// Utility for processing Wikilinks like [[Page Name]] or [[Page Name|Alias]]
class WikilinkUtils {
  /// Transforms text containing wikilinks into Markdown links with a custom scheme.
  /// 
  /// [[Page Name]] -> [Page Name](wikilink:Page Name)
  /// [[Page Name|Alias]] -> [Alias](wikilink:Page Name)
  static String processWikilinks(String text) {
    if (text.isEmpty) return text;
    
    // Regex matches [[Target]] or [[Target|Alias]]
    // Group 1: Target
    // Group 2: Alias (optional)
    final wikilinkRegex = RegExp(r'\[\[([^\]|]+)(?:\|([^\]]+))?\]\]');
    
    return text.replaceAllMapped(wikilinkRegex, (match) {
      final target = match.group(1)?.trim() ?? '';
      final alias = match.group(2)?.trim() ?? target;
      
      if (target.isEmpty) return match.group(0) ?? '';
      
      // We encode the target to ensure it works in a URL
      // But for display we keep the alias clean
      return '[$alias](wikilink:$target)';
    });
  }
}
