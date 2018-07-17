# SUSE's openQA tests
#
# Copyright © 2018 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# Summary: Advanced test cases for wicked
# Test scenarios:
# Test 1 : Reference GRE interface
# Maintainer: Anton Smorodskyi <asmorodskyi@suse.com>, Jose Lausuch <jalausuch@suse.com>

use base 'wickedbase';
use strict;
use testapi;
use utils 'systemctl';
use lockapi;
use mmapi;

sub create_tunnel_with_commands {

    my ($self, $type, $mode, $sub_mask) = @_;
    my $local_ip  = $self->get_ip(no_mask => 1, is_wicked_ref => 1, type => 'host');
    my $remote_ip = $self->get_ip(no_mask => 1, is_wicked_ref => 0, type => 'host');
    my $tunnel_ip = $self->get_ip(is_wicked_ref => 1, type => $type);
    assert_script_run("ip tunnel add $type mode $mode remote $remote_ip local $local_ip");
    assert_script_run("ip link set $type up");
    assert_script_run("ip addr add $tunnel_ip/$sub_mask dev $type");
    assert_script_run("ip addr");
}

sub run {
    my ($self) = @_;

    record_info('Test 1', 'Create a gre interface from legacy ifcfg files');
    $self->create_tunnel_with_commands("gre1", "gre", "24");
    mutex_wait('test_1_ready');
    assert_script_run("ifdown gre1");
    # Placeholder for Test 2: Create a GRE interface from Wicked XML files

    record_info('Test 3', 'Create a SIT interface from legacy ifcfg files');
    $self->create_tunnel_with_commands("sit1", "sit", "127");
    mutex_wait('test_3_ready');
    assert_script_run("ifdown sit1");

    # Placeholder for Test 4: Create a SIT interface from Wicked XML files

    record_info('Test 5', 'Create a IPIP  interface from legacy ifcfg files');
    $self->create_tunnel_with_commands("tunl1", "ipip", "24");
    mutex_wait('test_5_ready');
    assert_script_run("ifdown tunl1");

    # Placeholder for Test 6: Create a IPIP interface from Wicked XML files

    # Placeholder for Test 7: Create a tun interface from legacy ifcfg files
    # Placeholder for Test 8: Create a tun interface from Wicked XML files

    # Placeholder for Test 9: Create a tap interface from legacy ifcfg files
    # Placeholder for Test 10: Create a tap interface from Wicked XML files

    record_info('Test 11', 'Create Bridge interface from legacy ifcfg files');
    # Note: No need to create a bridge interface, as the SUT will ping
    #       the IP of eth0 already configured.
    mutex_wait('test_11_ready');

    # Placeholder for Test 12: Create a Bridge interface from Wicked XML files

    # Placeholder for Test 13: Create a team interface from legacy ifcfg files
    # Placeholder for Test 14: Create a team interface from Wicked XML files
}

1;