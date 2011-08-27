package :imagemagick do
  description 'ImageMagick image convertion library'
  apt 'libxml2-dev libmagick9-dev imagemagick' 

  verify do
    has_file '/usr/bin/convert'
  end
end
