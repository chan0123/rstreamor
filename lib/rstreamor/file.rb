module Rstreamor
  class File

    def initialize(file_url, file_size, content_type)
      @url = file_url
      @content_type = content_type
      @file_size = file_size
    end

    def url
      @url
    end

    def content_type
      @content_type
    end

    def size
      # Because of encoding, the string size might not match the stream size,
      # and that may lead to files being truncated when served (i.e. this happens
      # often for MP3 files, were the last few seconds of files longer than a minute
      # gets trimmed).
      @file_size
    end
  end
end
