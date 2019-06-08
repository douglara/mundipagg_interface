module MundipaggInterface
  module Subscriptions
    module Subscription

      def create_subscription(body)
        post_request("/subscriptions", body)
      end

      def change_payment_card(subscription_id, body)
        patch_request("/subscriptions/#{subscription_id}/card", body)      
      end

      def cancel_subscription(subscription_id)
        delete_request("/subscriptions/#{subscription_id}")
      end
    
    end
  end
end