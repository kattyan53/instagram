class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  #画像サイズ縮小
    include CarrierWave::MiniMagick
    storage :file
    process :resize_to_limit => [500,500]
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #ファイル形式
  def extension_white_list
       %w(jpg jpeg gif png)
  end

  #正方形にトリミング
  def create_square_image(magick, size)
  narrow = magick[:width] > magick[:height] ? magick[:height] : magick[:width]
  magick.combine_options do |c|
   c.gravity "center"
   c.crop "#{narrow}x#{narrow}+0+0"
  end
  magick.resize "#{size}x#{size}"
end

end
