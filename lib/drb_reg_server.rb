#!/usr/bin/env ruby

# file: drb_reg_server.rb


require 'drb'
require 'dws-registry'



class DWSRegistryWrapper

  def initialize(filepath)
    @reg = DWSRegistry.new filepath
  end

  def delete_key(path)
    @reg.delete_key path
  end

  def get_key(path, auto_detect_type: false)
    e = @reg.get_key(path, auto_detect_type: auto_detect_type)
    e.xml
  end

  def get_keys(path)
    recordset = @reg.get_keys(key)

    if recordset then
      recordset.to_doc(root: 'recordset').root.xml
    else
      nil
    end    
  end

  def set_key(path, value)
    e = @reg.set_key(path, value)
    e.xml
  end

  def xpath(xpath)
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
