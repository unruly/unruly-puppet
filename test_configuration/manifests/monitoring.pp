class test_configuration::monitoring {
  include base::yum::repos::epel
  include monitoring
}