# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_UsageManagement_session',
  :secret      => '657baade0df6c7f5576187674651a3442c2949d21ab63a2299a1ced3265375f4beb6dfe3f9095f6936cf0d34bb5ccbac825530f54319e086f7fb6b71f028cdde'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
