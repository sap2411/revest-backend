require 'date'

module Plaid

  module_function
  def default_client
    Plaid::Client.new(
      env: :development,
      client_id: ENV["PLAID_CLIENT_ID"],
      secret: ENV["PLAID_DEV_SECRET"],
      public_key: ENV["PLAID_PUBLIC_KEY"]
    )
  end

  def self.generate_access_token(public_token)
    exchange_token_response = default_client.item.public_token.exchange(public_token)
    exchange_token_response['access_token']
  end

  MAX_NUMBER_DAYS = 31

  def fetch(access_token, start_date = Date.today, last_date = (Date.today - MAX_NUMBER_DAYS))
    fetch_plaid(access_token, start_date, last_date)
  end


  def fetch_plaid(access_token, start_date, last_date)
    transaction_response = client.transactions.get(access_token, last_date, start_date)
    transactions = transaction_response.transactions

    while transactions.length < transaction_response['total_transactions']
      transaction_response = client.transactions.get(access_token, last_date, start_date, offset: transactions.length)
      transactions += transaction_response.transactions
    end
    transactions
  end

  def client
    @client ||= self.default_client
  end
end 