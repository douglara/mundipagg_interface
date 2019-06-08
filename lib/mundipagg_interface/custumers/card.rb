module MundipaggInterface
  module Custumers
    module Card

      def get_cards(custumer_id)
        get_request("/customers/#{custumer_id}/cards")
      end

      def create_card(custumer_id, body)
        post_request("/customers/#{custumer_id}/cards", body)
      end
    
    end
  end
end