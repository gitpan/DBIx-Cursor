# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 10 };
use DBIx::Cursor;
use DBI;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

my ($dbh, $c);

print "please give me a dbi-data-source, where I can create a table dbixcursor in: ";
my $ds = <>;
ok ($ds);

print "username:";
my $user = <>;
print "password:";
my $passwd = <>;

ok ($dbh = DBI->connect($ds));
ok ($dbh->do ('
 create table dbixcursor (
   pk1 int not null,
   pk2 int not null,
   ivalue1 int not null,
   ivalue2 int,
   svalue1 varchar(80) not null,
   svalue2 varchar(80),
   primary key (pk1, pk2)
 );'));
ok ($c = new DBIx::Cursor($dbh, 'dbixcursor', 'pk1', 'pk2'));
ok ($c->set(pk1 => 1, pk2 => 2, ivalue1 => 10, svalue1 => 'hello'));
ok ($c->insert);
ok ($c->reset);
ok ($dbh->do ('drop table dbixcursor'));
ok ($dbh->disconnect);
