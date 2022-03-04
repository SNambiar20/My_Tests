
require_relative './apis'


class TestCases
  include Apis

  def getUserslist_index
    Apis::getUserslist_index
  end

  def getUserslist_show
    Apis::getUserslist_show
  end

  def getUser_invalid_data
    Apis::getUser_invalid_data
  end

  def getUserslist_index
    Apis::post_user(data)
  end

end

