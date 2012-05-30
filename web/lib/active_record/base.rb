module ActiveRecord
  class Base

    # thanks to marklunds.com/articles/one/398
    def self.auto_strip(*attributes)
      attributes.each do |attribute|
        before_validation do |record|
          record.send("#{attribute}=", record.send("#{attribute}_before_type_cast").to_s.strip) if record.send(attribute)
        end
      end
    end

  end
end
