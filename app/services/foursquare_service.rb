class FoursquareService

  def self.get_photo_as_url(image)
    photo_prefix = image.prefix
    photo_suffix = image.suffix
    binding.pry
    "#{photo_prefix}100x100#{photo_suffix}"
  end

end
