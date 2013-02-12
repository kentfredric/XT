use strict;
use warnings;

package XT::Controller::JSON;

use Web::Simple 'XT::Controller::JSON';
use JSON;

sub usage {
  return [ 200, [ 'Content-Type' => 'text/plain' ], [ <<'EOF' ] ];

query params:

    pretty = 
    indent =
    space_before = 
    space_after  = 
    canonical    =

/json/user/{username}

EOF

}

sub _request_setup {
  my $self   = shift;
  my $config = {};
  $config->{json_encoder} = JSON->new();
  $config->{json_encoder}->utf8(1);
  $config->{json_encoder}->pretty(0);
  $config->{render}      = 'json';
  $config->{render_json} = sub {
    my $data           = shift;
    my $string         = $config->{json_encoder}->encode($data);
    my $content_length = length $string;
    return [
      200,
      [
        'Content-Type'   => 'application/x-javascript',
        'Content-Length' => $content_length,
      ],
      [$string]
    ];
  };
  $config->{renderref} = sub {
    my $data   = shift;
    my $method = $config->{render};
    if ( exists $config->{ 'render_' . $method } ) {
      my $sub = $config->{ 'render_' . $method };
      return $sub->($data);
    }
  };
  return $config;
}

sub _json_params {
  return qw( pretty indent space_before space_after canonical);
}

sub _json_params_rules {
  my $config  = shift;
  my $encoder = $config->{json_encoder};
  return map {
    my $param_name   = $_;
    my $param_setter = $encoder->can($param_name);
    ( ( '?' . $param_name . '=' ) => sub { $encoder->$param_setter( $_[1] ); return; } );
  } _json_params;
}

sub dispatch_request {
  my $self   = shift;
  my $config = $self->_request_setup();
  my $render = $config->{renderref};
  return (
    _json_params_rules($config),
    '/user/*' => sub {
      my ( $shift, $user ) = @_;
      return $render->( { requested => { user => $user } } );
    },
    '/' => sub { __PACKAGE__->usage() },
  );
}

__PACKAGE__->run_if_script;
