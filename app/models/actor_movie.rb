class ActorMovie < ApplicationRecord
  belongs_to :actor, counter_cache: :movies_count
  belongs_to :movie
  validates_uniqueness_of :actor_id, scope: :movie_id
end
