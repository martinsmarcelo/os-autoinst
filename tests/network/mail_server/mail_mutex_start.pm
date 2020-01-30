# SUSE"s openQA tests
# #
# # Copyright © 2019 SUSE LLC
# #
# # Copying and distribution of this file, with or without modification,
# # are permitted in any medium without royalty provided the copyright
# # notice and this notice are preserved.  This file is offered as-is,
# # without any warranty.
#
# Summary: Test regression to mail clients
#  this test curl with http, https, ldap, ftp and ntlm auth
#  poo#51536
# Maintainer: Marcelo Martins <mmartins@suse.cz>

use base "x11test";
use strict;
use warnings;
use testapi;
use lockapi;

sub run {
    assert_script_run('ping -c 3 server');
    mutex_wait('mail_server_ready', undef, 'Server configuration in progress!');
    record_info 'Waiting Server', 'Waiting mail-server to start tests.';
    select_console 'x11' unless check_var('DESKTOP', 'textmode');
}
1;
