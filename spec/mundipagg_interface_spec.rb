RSpec.describe MundipaggInterface do
  it "has a version number" do
    expect(MundipaggInterface::VERSION).not_to be nil
  end

  context 'instace' do
    context 'success' do 
      api = MundipaggInterface::Api.new({basic_auth_secret_key: ENV['BASIC_SECRET_KEY']})

      context 'custumers' do
        context 'get' do
          it 'index' do
            #api = MundipaggInterface::Api.new({'basic_auth_secret_key': ENV['BASIC_SECRET_KEY']})
            p api.get_custumers().inspect
          end

          it 'create' do
            payload = '{"email":"tonystarkk2@avengers.com","type":"individual","name":"teste"}'
            result = api.create_custumer(payload)
            expect(result.status_code).to be 200

          end

        end
        
        context 'card' do
          user_id = 'cus_xoAJeGaTGsmY7dQ1'
          it 'get all' do
            result = api.get_cards(user_id)
            p result
            expect(result.status_code).to be 200
          end
          it 'custumer not found' do
            user_id = '0'
            result = api.get_cards(user_id)
            expect(result.status_code).to be 404
          end

          context 'create' do 
            it 'success' do 
              payload = '{
                "number": "4000000000000010",
                "holder_name": "Tony Stark",
                "exp_month": 1,
                "exp_year": 20,
                "cvv": "351"}'
              result = api.create_card(user_id, payload)
              p result
              expect(result.status_code).to be 200
            end
          end
        end

        context 'subscriptions' do 
          context 'create' do
            it 'success' do
              payload = '{
                "plan_id": "plan_OPY5a0cMGCymDEKV",
              "payment_method": "credit_card",
              "currency": "BRL",
              "installments": 1,
              "customer": {
                  "id": "cus_yMDoj2kTbsva1Gzw",
                  "name": "Mario Santos",
                  "email": "mariosantos3@gmail.com",
                  "delinquent": false,
                  "created_at": "2018-08-21T18:18:46Z",
                  "updated_at": "2018-08-21T18:18:46Z",
                  "phones": {}
              },
              "card": {
                "number": "4584441896453869",
                "holder_name": "Eaii",
                "exp_month": "12", 
                "exp_year": "2019"
                
              }
            }'
              result = api.create_subscription(payload)
              expect(result.status_code).to be 200
                
            end
          end

          context 'update credit card' do
            it 'success' do
              subscription_id = 'sub_J96g2rDcXT6adEyB'
              payload = '{
                "plan_id": "plan_OPY5a0cMGCymDEKV",
              "payment_method": "credit_card",
              "currency": "BRL",
              "installments": 1,
              "customer": {
                  "id": "cus_yMDoj2kTbsva1Gzw",
                  "name": "Mario Santos",
                  "email": "mariosantos@gmail.com",
                  "delinquent": false,
                  "created_at": "2018-08-21T18:18:46Z",
                  "updated_at": "2018-08-21T18:18:46Z",
                  "phones": {}
              },
              "card": {
                "number": "4584441896453869",
                "holder_name": "Eaiio",
                "exp_month": "12", 
                "exp_year": "2019"
                
              }
            }'
              result = api.change_payment_card(subscription_id, payload)
              expect(result.status_code).to be 200
            
            end
          end

          context 'cancel' do
            it 'success' do 
              subscription_id = 'sub_ekAwY89fPbCm7yB2'
              result = api.cancel_subscription(subscription_id)
              expect(result.status_code).to be 200
            end
          end


        end
      end
    end
  end
end
