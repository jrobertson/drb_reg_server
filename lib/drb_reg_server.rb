#!/usr/bin/env ruby

# file: drb_reg_server.rb


require 'drb'
require 'dws-registry'


class DWSRegistryWrapper

  def initialize(filename)
    
    @filename = filename
    load_reg()
    
  end

  def delete_key(key)
    r = @reg.delete_key key
    r ? 'key deleted' : 'key not found'
  end

  def get_key(path, auto_detect_type: false)
    e = @reg.get_key(path, auto_detect_type: auto_detect_type)
    e.xml
  end

  def get_keys(key)
    
    recordset = @reg.get_keys(key)
    return unless recordset
    
    recordset.to_doc(root: 'recordset').root.xml
  
  end
  
  def gem_register(gemfile)    
    @reg.gem_register(gemfile)
  end
  
  def import(s)
    @reg.import(s)    
  end  
  
  def refresh()
    load_reg()
  end

  def set_key(path, value)
    e = @reg.set_key(path, value)
    e.xml
  end

  def xpath(xpath)
    
    recordset = @reg.xpath(xpath)
    return unless recordset
    
    recordset.to_doc(root: 'recordset').root.xml          
    
  end

  private
  
  def load_reg()
    @reg = DWSRegistry.new(@filename)    
  end
    
end

class DRbRegServer

  def initialize(reg_filepath, host: 'localhost', port: '59500')

    @host, @port = host, port
    @reg = DWSRegistryWrapper.new reg_filepath

  end

  def start()

    DRb.start_service "druby://#{@host}:#{@port}", @reg
    DRb.thread.join

  end

end
