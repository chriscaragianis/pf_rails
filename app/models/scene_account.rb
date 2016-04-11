class SceneAccount < ActiveRecord::Base
  belongs_to :account
  belongs_to :scenario
end
