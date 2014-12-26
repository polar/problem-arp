
module IPhone
  class Api < Api::APIBase
    def initialize(master)
      super(IPhone::Http::HttpClient.new, master.slug, master.apiUrl, "iPhone", "0.1.0")
      #self.bgEvents = ::Api::BuspassEventDistributor.new(:name => "BGEvents:#{master.slug}", :queue => IPhoneQ.new)
      #self.uiEvents = ::Api::BuspassEventDistributor.new(:name => "UIEvents:#{master.slug}", :queue => IPhoneQ.new)
    end

    def xmlParse(data)
      BLog.logger.info "#{self.class.name}:#{__method__} calling autorelase_pool" if BLog::INFO
      ret1 = autorelease_pool do
        s = data.getContent.to_s
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