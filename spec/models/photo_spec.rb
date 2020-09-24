require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe '#create' do
    before do

      @photo[:image] = FactoryBot.build(:photo)
      @photo.image = fixture_file_upload('/samplegram/spec/fixtures/IMG_9584.JPG')

    end
  end
end