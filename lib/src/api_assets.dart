/// A reference to an image
abstract class Image {
  /// The full image URL
  final String url;

  Image._(this.url);
}

/// A reference to an image icon which includes the url to full standalone image
/// and a sprite reference
abstract class ImageIcon extends Image {
  /// The image sprite reference
  final ImageSprite sprite;

  ImageIcon._(this.sprite, String url) : super._(url);
}

/// A reference for an image in a sprite
abstract class ImageSprite {
  /// The X coordinate
  final int x;

  /// The Y coordinate
  final int y;

  /// The target image width within the sprite
  final int width;

  /// The target image height within the sprite
  final int height;

  /// The full sprite image URL
  final String url;

  const ImageSprite._(this.url,
      {this.x = 0, this.y = 0, this.height, this.width});
}

/// A video clip reference
abstract class VideoClip {
  /// The video clip Url
  final String url;

  /// The video thumbnail
  final Image thumbnail;

  VideoClip._(this.url, this.thumbnail);
}
