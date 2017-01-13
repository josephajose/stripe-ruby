module Stripe
  class Invoice < APIResource
    extend Stripe::APIOperations::List
    include Stripe::APIOperations::Save
    extend Stripe::APIOperations::Create

    def self.upcoming(params, opts={})
      resp, opts = request(:get, upcoming_url, params, opts)
      Util.convert_to_stripe_object(resp.data, opts, response: resp)
    end

    def pay(opts={})
      self.response, opts = request(:post, pay_url, {}, opts)
      initialize_from(response.data, opts)
    end

    private

    def self.upcoming_url
      resource_url + '/upcoming'
    end

    def pay_url
      resource_url + '/pay'
    end
  end
end
