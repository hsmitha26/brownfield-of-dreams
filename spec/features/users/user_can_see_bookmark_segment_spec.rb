require 'rails_helper'

describe 'A registered user' do
  it "can display Bookmarked" do
    user = create(:user)
    u2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    t1 = create(:tutorial, title: 'How to Tie Your Shoes')
    t1v1 = create(:video, title: 'The Bunny Ears Technique', tutorial: t1, position: 2)
    t1v2 = create(:video, tutorial: t1, position: 1)
    t1v3 = create(:video, tutorial: t1, position: 3)

    t2 = create(:tutorial)
    t2v1 = create(:video, tutorial: t2)

    uv1 = create(:user_video, user_id: user.id, video_id: t1v1.id)
    uv2 = create(:user_video, user_id: user.id, video_id: t1v2.id)
    uv3 = create(:user_video, user_id: user.id, video_id: t2v1.id)

    uv4 = create(:user_video, user_id: u2.id, video_id: t1v3.id)

    visit dashboard_path
    expect(page).to have_content("Bookmarked Segments")

    within ".bookmarks" do
      expect(page.all('li')[0]).to have_content("#{t1v2.title}")
      expect(page.all('li')[1]).to have_content("#{t1v1.title}")
      expect(page.all('li')[2]).to have_content("#{t2v1.title}")
    end
  end
end
