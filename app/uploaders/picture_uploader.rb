class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_limit: [Settings.picture_size.size_value,
    Settings.picture_size.size_value]
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end