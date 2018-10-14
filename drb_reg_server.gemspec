Gem::Specification.new do |s|
  s.name = 'drb_reg_server'
  s.version = '0.2.0'
  s.summary = 'Provides a DWS_registry service from a DRb server'
  s.authors = ['James Robertson']
  s.files = Dir['lib/drb_reg_server.rb']
  s.add_runtime_dependency('dws-registry', '~> 0.5', '>=0.5.0')
  s.signing_key = '../privatekeys/drb_reg_server.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/drb_reg_server'
end
