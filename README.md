# MundipaggInterface


This gem create easy interface to manipulate Mundipagg API with basic Auth.

## Requirements

You need create API Token, oficial docummentation this topic:
https://docs.mundipagg.com/reference#autentica%C3%A7%C3%A3o

Rest Client is used to perform all API calls.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mundipagg_interface'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mundipagg_interface

## Getting started

First need to instance the API:

    api = MundipaggInterface::Api.new({
        basic_auth_secret_key: 'YOU_SECRET_KEY'
        })



## Methods

##### Custumers

    * api.get_custumers()
      -> Returns list custumers.
    * api.create_custumer(body)
      -> Create custumer.
      -> Example: api.create_ticket({
          "email":"tonystarkk2@avengers.com",
          "type":"individual",
          "name":"teste"
          })

##### Cards

    * api.get_cards(custumer_id)
      -> Returns list custumer cards.
    * api.create_card(custumer_id, body)
      -> Create custumer.
      -> Example: api.create_card(
          custumer_id,
            {
                "number": "4000000000000010",
                "holder_name": "Tony Stark",
                "exp_month": 1,
                "exp_year": 20,
                "cvv": "351"
            }
        )

##### Subscriptions

    * api.create_subscription(body)
      -> Create subscription, user and card if not exist.
      -> Example: api.create_subscription(
          {
                "plan_id": "plan_OPY5a0cMGCymDEKV",
              "payment_method": "credit_card",
              "currency": "BRL",
              "installments": 1,
              "customer": {
                  "name": "Mario Santos",
                  "email": "mariosantos3@gmail.com",
                  "delinquent": false,
                  "phones": {}
              },
              "card": {
                "number": "4584441896453869",
                "holder_name": "Eaii",
                "exp_month": "12", 
                "exp_year": "2019"
                
              }
            }
        )

    * api.change_payment_card(subscription_id, payload)
      -> Change signature credit card.
      -> Example: api.change_payment_card(
          'sub_J96g2rDcXT6adEyB',
          {
                "plan_id": "plan_OPY5a0cMGCymDEKV",
              "payment_method": "credit_card",
              "currency": "BRL",
              "installments": 1,
              "card": {
                "number": "4584441896453869",
                "holder_name": "Eaiio",
                "exp_month": "12", 
                "exp_year": "2019"
                
              }
            }
      )

    * api.cancel_subscription(subscription_id)
      -> Cancel subscription.
      -> Example: api.cancel_subscription('sub_J96g2rDcXT6adEyB')

##### Generics

    * api.get_request("/API_PATH", params={}, headers={})
      -> Returns get from Octa API.
      -> Example: api.get_request("/persons?email=custumer@email.com")

    * api.post_request("/API_PATH", params={}, headers={})
      -> Returns post from Octa API.

    * api.put_request("/API_PATH", params={}, headers={})
      -> Returns put from Octa API.

    * api.patch_request("/API_PATH", params={}, headers={})
      -> Returns patch from Octa API.

    * api.delete_request("/API_PATH", params={}, headers={})
      -> Returns delete from Octa API.



## Contributing / Problems?

If you have encountered any problem, difficulty or bug, please start by opening a issue.

Bug reports and pull requests are welcome on GitHub at https://github.com/douglara/mundipagg_interface. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
