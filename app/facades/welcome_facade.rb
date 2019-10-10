# frozen_string_literal: true

class WelcomeFacade
  def all_tutorials(page, tag)
    if tag
      Tutorial.tagged_with(tag).paginate(page: page, per_page: 5)
    else
      Tutorial.all.paginate(page: page, per_page: 5)
    end
  end

  def visitor_tutorials(page, tag)
    if tag
      Tutorial.where(classroom: false).tagged_with(tag).paginate(page: page, per_page: 5)
    else
      Tutorial.where(classroom: false).paginate(page: page, per_page: 5)
    end
  end
end
