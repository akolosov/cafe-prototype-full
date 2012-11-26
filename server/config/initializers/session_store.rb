# Be sure to restart your server when you modify this file.

Cafe::Application.config.session_store :active_record_store, :key => '_cafe_session', :expire_after => 60.minute

# Cafe::Application.config.session_store :cookie_store, key: '_cafe_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Cafe::Application.config.session_store :active_record_store