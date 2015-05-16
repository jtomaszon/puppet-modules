class kbit-common {
  include stdlib
  include kbit-common::users
  include kbit-common::fail2ban
  include kbit-common::newrelic
  include kbit-common::nodejs
  include kbit-common::percona
}
