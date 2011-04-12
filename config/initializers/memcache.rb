require 'memcached'
CACHE = Memcached.new(['127.0.0.1:11211'], :show_not_found_backtraces => true, 
                                            :support_cas => true, :prefix_key => 'test')


class Memcached
  def get_or(key, timeout=0, marshal=true, &block)
    get(key, marshal)
  rescue TypeError, Memcached::NotFound => e
    if block_given?
      value = block.call
      set(key, value, timeout, marshal) rescue nil
      value
    else
      raise e
    end
  end
end