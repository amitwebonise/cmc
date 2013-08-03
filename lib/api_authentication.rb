class ApiAuthentication
  #This methods create a digest using the values in params and create a encrypted string using secret key that we used for authentication of API
  # Each Time this Signed key will be different according to the parameters

  def self.is_response_authenticated?(params)
    Rails.logger.info("============BEFORE================================#{params.inspect}")
    parameter_data = params.reject{|key,value| ["action","signed_key","controller","format","photos","api"].include?(key)}
    Rails.logger.info("============Param DATA================================#{parameter_data.inspect}")
    hdata =  parameter_data.sort.collect{|i| i.last}.join("")
    Rails.logger.info("============Hdata DATA================================#{hdata.inspect}")
    Rails.logger.info("============AFTER===#{parameter_data.sort.collect{|i| i.first}.inspect}=============================#{parameter_data.inspect}")
    digest_sig = OpenSSL::HMAC.hexdigest("sha1",SECRET_KEY, hdata)
    Rails.logger.info("=======GENERATED=====KEY===============#{digest_sig}")
    if params[:signed_key].to_s == digest_sig
      return true
    else
      Rails.logger.error "Invalid Secret key : #{params[:signed_key].to_s}"
      return false
    end
  end
end