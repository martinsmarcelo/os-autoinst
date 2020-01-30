# SUSE's openQA tests
#
# Copyright © 2019 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
#
# Summary: Server especif configurations to mail server, and
#   configurations to wait mail clients.
# Maintainer: Marcelo Martins <mmartins@@suse.com>

use base 'opensusebasetest';
use strict;
use warnings;
use testapi;
use lockapi;
use mmapi;

sub run {
    my $self = shift;
    $self->select_serial_terminal;
    #preparing files will be use by client side.

    #Server ready, mutex to client continue....
    mutex_create('mail_server_ready');

    # Waitting client finish tests.
    my $children = get_children();
    my $child_id = (keys %$children)[0];
    mutex_wait('MAIL_DONE', $child_id,);
    record_info 'Mail Done', 'Mail client test done.';
}
1;
