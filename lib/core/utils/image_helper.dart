class ImageHelper {
  /// Get image URL with CORS proxy for web
  static String getImageUrl(String imageUrl) {
    if (imageUrl.isEmpty) return '';
    
    // Use CORS proxy for web
    return 'https://wsrv.nl/?url=$imageUrl';
  }
}