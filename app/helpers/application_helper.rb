module ApplicationHelper
  def avatar_url(email, size= 100)
  	gravatar = Digest::MD5::hexdigest(email).downcase
    url = "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}"
  end
end
