require 'ally/detector'
require 'ally/detector/duration/version'

module Ally
  module Detector
    class Duration
      include Ally::Detector

      # TODO replace this logic with
      # https://github.com/hpoydar/chronic_duration

      DURATION_WORDS = [
        { name: 'second', value: 1, aliases: %w[sec second seconds] },
        { name: 'minute', value: 60, aliases: %w[min minute minutes] },
        { name: 'hour', value: 3600, aliases: %w[hr hour hours] },
        { name: 'day', value: 86400, aliases: %w[day days] },
        { name: 'week', value: 604800, aliases: %w[wk week weeks] },
        { name: 'fortnight', value: (604800*2), aliases: %w[fortnight fortnights] },
        { name: 'month', value: (86400*30), aliases: %w[mo mth mnth month months] },
        { name: 'year', value: (86400*365), aliases: %w[yr year years] },
        { name: 'decade', value: 315360000, aliases: %w[decade decades] },
        { name: 'century', value: 3153600000, aliases: %w[century centuries] },
        { name: 'millennium', value: 31536000000, aliases: %w[millennium millennia] },
      ]
    
      def detect
        @datapoints = []
        @inquiry.words_chomp_punc.each_with_index do |word,i|
          next if i == 0
          DURATION_WORDS.each do |dword|
            prev_word = @inquiry.words_chomp_punc[i-1]
            if dword[:aliases].include?(word.downcase)
              if prev_word =~ /^(a|an)$/i
                @datapoints << dword[:value]
              elsif prev_word =~ /^[0-9]+$/
                @datapoints << prev_word.to_i * dword[:value]
              end
            end
          end
        end
        if @datapoints.length == 0
          nil
        else
          @data_detected = true
          @datapoints
        end
      end
    end
  end
end
