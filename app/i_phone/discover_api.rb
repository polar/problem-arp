module IPhone
  class DiscoverApi < ::Api::DiscoverAPIVersion1
    def initialize(httpClient = nil, url)
      super(httpClient || IPhone::Http::HttpClient.new, url)
    end

    def xmlParse(data)
      BLog.logger.info "#{self.class.name}:#{__method__} calling autorelase_pool" if BLog::INFO
      ret1 = autorelease_pool do
        s = data.getContent
        BLog.logger.info "#{self.class.name}:#{__method__} parsing '#{s}'" if BLog::INFO
        rxml = RXMLElement.elementFromXMLString(s, encoding: NSUTF8StringEncoding)
        ret2 = RaptureXMLTag.new(rxml).tap do |x|
          BLog.logger.info "#{self.class.name}:#{__method__} Inside autorelease_pool #{x}" if BLog::INFO
        end
        BLog.logger.info "#{self.class.name}:#{__method__} Inside autorelease_pool returning #{ret2}" if BLog::INFO
        ret2
      end.tap do |x|
        BLog.logger.info "#{self.class.name}:#{__method__} Outside autorelease_pool #{x}" if BLog::INFO
      end
      BLog.logger.info "#{self.class.name}:#{__method__} Outside autorelease_pool returning #{ret1}" if BLog::INFO
      ret1
    end

  end
end