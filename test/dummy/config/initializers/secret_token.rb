if Rails::VERSION::STRING < '4.1'
  Dummy::Application.config.secret_key_base = 'dc498f06cced8f5cfcc042ddc7ed73fce78490951e553b9cf2700d1a6077fbf365eac1a6ae0f1a580334f311dddffb995a54cb89615c13d02a58e1b60bc3aba1'
end
