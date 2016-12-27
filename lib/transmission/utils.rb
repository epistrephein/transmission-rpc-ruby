module Transmission
  module Utils
    def is_valid_key?(key, attributes)
      !attributes.select do |attribute|
        option_keys(key).include? attribute[:field]
      end.empty?
    end

    def option_keys(key)
      split = key.to_s.split '_'
      dashed = split.join '-'
      camelcase = split.collect(&:capitalize).join
      camelcase = camelcase[0].downcase + camelcase[1..-1]
      [dashed, camelcase]
    end

    def option_key(key, attributes)
      selected = attributes.select do |attribute|
        option_keys(key).include? attribute[:field]
      end
      selected.first[:field] unless selected.empty?
    end
  end
end
