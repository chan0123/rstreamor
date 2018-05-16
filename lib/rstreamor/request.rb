module Rstreamor
  class Request
    attr_reader :request, :file

    def initialize(request, file)
      @request = request
      @file = file
    end

    def ranges
      request.headers['HTTP_RANGE'].gsub('bytes=', '').split('-') if request.headers['HTTP_RANGE']
    end

    def upper_bound
      ranges[1] ? ranges[1].to_i : file.size
    end

    def lower_bound
      ranges[0] ? ranges[0].to_i : 0
    end

    def range_header?
      request.headers['HTTP_RANGE'].present?
    end

    def file_content_type
      file.content_type
    end

    def slice_file
      if request.headers['HTTP_RANGE'].present?
        response = HTTParty.get(file.url, {
          headers: {"range" => "bytes=#{lower_bound}-#{upper_bound}"}
          #debug_output: STDOUT, # To show that User-Agent is Httparty
        })
        response.body
        # file.data.byteslice(lower_bound, upper_bound)
      else
        puts "should flag an error if come to here"
      end
    end

    def file_size
      file.size
    end
  end
end
