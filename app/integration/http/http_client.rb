BLog.logger.info("#{self.class.name}:#{__method__}: loading Integration::Http::HttpClient") if BLog::INFO

module Integration
  module Http
    class HttpClient
      def getURLResponse(url)
        message = "Not Implemented"
        HttpResponse.new(message)
      end

      def openURL(url)
        message = "Not Implemented"
        HttpEntity.new(message)
      end

      def postURLResponse(url, params)
        message = "Not Implemented"
        HttpResponse.new(message)
      end

      def postURL(url, params)
        message = "Not Implemented"
        HttpEntity.new(message)
      end

      def postDeleteURL(url)
        message = "Not Implemented"
        HttpEntity.new(message)
      end
    end
  end
end