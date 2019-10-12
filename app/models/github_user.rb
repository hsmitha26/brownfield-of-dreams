# frozen_string_literal: true

class GithubUser
  attr_reader :handle, :url

  def initialize(handle, url)
    @handle = handle
    @url = url
  end

end
