class User < ActiveRecord::Base  
  validates_uniqueness_of :username, :scope => :admin_id
  has_many :friendships, :foreign_key => "user_1_id", :dependent => :destroy
  has_many :friends, :through => :friendships, :source => :user_2, :conditions => "status = 'accepted'"
  
  has_one :admin
  
  # used for paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  
  # not a production app, lets not worry about those silly passwords and logins
  acts_as_authentic do |c|
    c.require_password_confirmation = false
    c.validate_password_field = false
    c.ignore_blank_passwords = false
    c.validate_login_field = false    
    c.validate_email_field = false
  end
  
  #######################  Begin Meat and Potatoes of the Potential Friend Code ################################
  
  # returns array of friend ids from all of a user's friends, array is not unique...duplicate entries indicate multiple friends had a mutual friend
  def friends_of_a_friend_ids(options = {})
    foaf_ids ||= []
    get_friend_ids.each do |friend_id|
      foaf_ids << User.get_someones_friend_ids(friend_id)
    end
    foaf_ids.flatten
  end
  
  def mutual_friends(user)
    (self.get_friend_ids & user.get_friend_ids).count if self != user
  end
     
  
  def potential_friend_ids(options = {})
    potential_friend_ids = friends_of_a_friend_ids - not_potential_friend_ids
    # potential_friend_ids is now an array of potential friend ids, we now sort it, by building a hash with the friend id as the key
    # and the count of the number of times it occurs as the value, we sort by this value (greatest number of mutual friends wins)
    # we then return only the key (friend id) to form an array of sorted potential friends
    potential_friend_ids = potential_friend_ids.inject({}) {|sorted_id_hash, friend_id|
                                      sorted_id_hash[friend_id].blank? ? sorted_id_hash[friend_id] = 1 : sorted_id_hash[friend_id] += 1;
                                      sorted_id_hash }.
                                      sort {|x, y| y.last <=> x.last}.
                                      map(&:first)
    return potential_friend_ids
  end
  
  def not_potential_friend_ids_key
    "users:not_potential_friend_ids:#{self.id}"
  end
  
  # use not_potential_friend_ids for most calls, this is only the ids that the user has ignored directly
  def ignored_potential_friend_ids
    REDIS.lrange(not_potential_friend_ids_key, 0, -1).map(&:to_i)
  end
  
  def ignore_potential_friend(friend_id)
    REDIS.lpush(not_potential_friend_ids_key, friend_id) unless ignored_potential_friend_ids.include?(friend_id)
  end
  
  # returns ids of all current friends (regardless of status) and any additional ignored friends
  def not_potential_friend_ids
    @not_potential_friend_ids ||= CACHE.get_or(not_potential_friend_ids_key, 24.hours) {
      [self.id] + self.get_friend_ids + Friendship.where(:user_1_id => self.id).map(&:user_2_id) + self.ignored_potential_friend_ids
    }
  end
  
  # pulls users from potential_friend_ids
  def potential_friends(options = {})
    # add memcached to this call in a production app
    User.where("id in (?)", potential_friend_ids(options).first(options[:limit]||200)).all
  end
  #######################  End Meat and Potatoes of the Potential Friend Code ################################
  
  
  
  def self.get(username)
      CACHE.get_or("user:get:#{username}") do
        User.where(:username => username.downcase).first
      end
  end
  
  def self.friends_key(user_id)
    "users:friend_ids:#{user_id}"
  end
  
  def self.get_someones_friend_ids(user_id)
    friend_ids = CACHE.get_or(User.friends_key(user_id)) do
      User.connection.select_values("select user_2_id from friendships where user_1_id = #{user_id} and status = 'accepted'").map(&:to_i).uniq
    end
    return friend_ids.dup
  end
  
  def get_friend_ids
    User.get_someones_friend_ids(self.id)
  end
  
  
  
end