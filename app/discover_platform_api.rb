class DiscoverPlatformApi < Api::DiscoverAPIVersion1

  attr_accessor :uiEvents
  attr_accessor :bgEvents

  def initialize(client, url)
    super(client, url)
    self.bgEvents = Api::BuspassEventDistributor.new(name: "BGEvents", queue: IPhoneQ.new)
    self.uiEvents = Api::BuspassEventDistributor.new(name: "UIEvents", queue: IPhoneQ.new)
  end

  def xmlParse(data)
    BLog.logger.info "#{self.class.name}:#{__method__} calling autorelease_pool" if BLog::INFO
    autorelease_pool do
      s = data.getContent.to_s
      rxml = RXMLElement.elementFromXMLString(s, encoding: NSUTF8StringEncoding)
      RaptureXMLTag.new(rxml).tap do
        BLog.logger.info "#{self.class.name}:#{__method__} DONE autorelease_pool" if BLog::INFO
      end
    end
  end

  def xmlParse1(data)
    #puts "IM CALLING YOU!!!"
    #puts "data #{data.to_s}"
    #puts "xmlParse(#{data.getContent.to_s})"
    return APITAG_DISCOVER.tap do |x|
      #puts x
    end if /<API/ =~ data.getContent.to_s
    return APITAG_MASTERS.tap do |x|
      #puts x
    end
  end
end
