module Vega
  module Helper
    def vega_chart(chart, nonce: true)
      raise TypeError, "expected Vega chart" unless chart.is_a?(Vega::BaseChart)

      if nonce == true
        # Secure Headers also defines content_security_policy_nonce but it takes an argument
        # Rails 5.2 overrides this method, but earlier versions do not
        if respond_to?(:content_security_policy_nonce) && (content_security_policy_nonce rescue nil)
          # Rails 5.2
          nonce = content_security_policy_nonce
        elsif respond_to?(:content_security_policy_script_nonce)
          # Secure Headers
          nonce = content_security_policy_script_nonce
        else
          nonce = nil
        end
      end

      chart.to_html(nonce: nonce)
    end
  end
end
