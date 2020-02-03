# frozen_string_literal: true

module Hermes
  module Mail
    def new_message(_message)
      params = query_args.merge(
        drug_id: drug_id,
        state: state,
        v: version
      )
      data = forms_request POST, params: params
      data['forms'].map { |d| Hashie::Mash.new(d) }
    end

    private

    def request(method, options = {}, &block)
      options    =  options.symbolize_keys
      path       =  options[:path] || ''
      params     =  options[:params]
      auth       =  options[:auth]
      host_name  =  public_send("#{api_name}_host".to_sym)
      full_path  =  public_send("#{api_name}_path".to_sym) + path.to_s

      proxy_args = [method, host_name, full_path, params, auth]
      raise ArgumentError, 'method, host_name or full_path can not be nil' if proxy_args.take(3).any?(&:nil?)

      request(*proxy_args.compact, &block)
    end
  end
end
