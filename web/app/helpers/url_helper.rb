module UrlHelper
  def no_subdomain
    request.domain
  end

  def with_subdomain(subdomain)
    subdomain ||= ""
    subdomain += "." unless subdomain.empty?
    [subdomain, request.domain].join
  end

  def url_for(options=nil)
    if options.kind_of?(Hash)
      options[:host] = options.has_key?(:subdomain) ? with_subdomain(options.delete(:subdomain)) : no_subdomain
      options[:port] = request.port_string.gsub(":", "") unless request.port_string.empty?
    end
    super
  end
end
