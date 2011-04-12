class Friendship < ActiveRecord::Base
  
  def friends_or_requested_or_pending?(user_1, user_2)
    return true if friends?(user_1, user_2)
    return true if requested_or_pending?(user_1, user_2)
    false
  end
  
  def requested_or_pending?(user_1, user_2)
    # return requested?(user_1, user_2) || pending?(user_1, user_2)
    return true if find_by_user_1_id_and_user_2_id_and_status(user_1, user_2, "pending")
    return true if find_by_user_1_id_and_user_2_id_and_status(user_1, user_2, "requested")
    false
  end
  
  def friends?(user_1, user_2)
    find_by_user_1_id_and_user_2_id_and_status(user_1, user_2, "accepted")
  end
  
  def request(user_1, user_2)
    return false if user_1 == user_2 || friends_or_requested_or_pending?(user_1, user_2)
    transaction do
      create! :user_1 => user_1, :user_2 => user_2, :status => "pending", :notifications => true
      create! :user_1 => user_2, :user_2 => user_1, :status => "requested", :notifications => true
    end
    return true
  end
  
  def accept(user_1, user_2, options = {})
    f1 = find_by_user_1_id_and_user_2_id_and_status(user_1, user_2, "requested")
    f2 = find_by_user_1_id_and_user_2_id_and_status(user_2, user_1, "pending")
    return false if f1.nil? or f2.nil?
    transaction do
      f1.update_attributes(:status => "accepted")
      f2.update_attributes(:status => "accepted")
    end
    return true
  end
  
  def reject(user_1, user_2)
    f1 = find_all_by_user_1_id_and_user_2_id(user_1, user_2)
    f2 = find_all_by_user_1_id_and_user_2_id(user_2, user_1)
    return false unless f1.any? && f2.any?
    transaction do
      f1.each { |f| f.update_attributes(:status => "ignored") }
      f2.each { |f| f.update_attributes(:status => "rejected") }
    end
    return true
  end
  
  
  
  

end