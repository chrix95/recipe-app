class JsonTransformService
  def self.transform_keys_to_snake_case(data)
    if data.is_a?(Hash)
      data.transform_keys { |key| key.to_s.underscore.to_sym }
        .transform_values { |value| self.transform_keys_to_snake_case(value) }
    elsif data.is_a?(Array)
      data.map { |item| self.transform_keys_to_snake_case(item) }
    else
      data
    end
  end
end
