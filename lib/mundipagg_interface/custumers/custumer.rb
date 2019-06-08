module MundipaggInterface
  module Custumers
    module Custumer

      def get_custumers()
        get_request("/customers")
      end

      def create_custumer(body)
        post_request("/customers", body)
      end

    end
  end
end