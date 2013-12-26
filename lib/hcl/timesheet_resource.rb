module HCl
  class TimesheetResource
    def initialize params
      @data = params
    end

    def id
      @data[:id]
    end

    def method_missing method, *args
      @data.key?(method.to_sym) ? @data[method] : super
    end

    def respond_to? method
      (@data && @data.key?(method.to_sym)) || super
    end

    class << self
      def post url, data
        new Net.post url, data
      end
      def get url
        new Net.get url
      end
      def get_all url
        Net.get(url)[collection_key].map {|o| new o }
      end

      def collection_key
        @collection_key ||=
          self.name.split("::").last.split(/(?=[A-Z])/).map(&:downcase).join('_').to_sym
      end
    end
  end
end
