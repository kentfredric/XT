use strict;
use warnings;

package XT;

# ABSTRACT: A viral platform for content aggregation and world domination

=head1 DESCRIPTION

You've seen them before, 9-gag and all those pesky "funny pics" websites that are forever clogging your C<$socialnetwork>.

They're effective at what they do, find cool stuff and make it go viral.

Outside these specific websites, the concept doesn't seem to have spread yet, the only noteworthy example being reddit, which is a generalised approach at unifying a sense of virality with arbitrary content. 

This project is intended to fill this market niché, and provide a topic-specific platform for promoting content, in a way that will hopefully supercede the sphere of "Planet" RSS Aggregators, so that gems are more likely to surface, and chaff is more likely to vanish, as opposed to having a perpetual linear stream of randomly variating quality.

In simple terms:

=over 4

=item people submit content ( either by individual content links, or via a feed )

=item content is aggregated into a pool

=item people vote up/down on content

=item people classify content

=item "hot" content is delivered to a "hot" page.  

=item everyone benefits

=back 4

=cut

use Web::Simple 'XT';

require XT::Controller::JSON;

sub dispatch_request {
  return (
    '/json...' => sub {
      XT::Controller::JSON->dispatch_request(@_);
    },
  );
}

__PACKAGE__->run_if_script;
