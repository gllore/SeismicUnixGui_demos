=head2 SYNOPSIS

 PACKAGE NAME: 

 AUTHOR:  

 DATE:

 DESCRIPTION:

 Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut


	use Moose;
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
	use Project_config;

	my $Project		= new Project_config();
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;

	use message;
	use flow;
	use data_in;
	use suxmax;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $suxmax				= new suxmax();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@suxmax);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name(quotemeta('30_clean'));
	$data_in				->suffix_type(quotemeta('su'));
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	suxmax parameter values

=cut

	$suxmax				->clear();
	$suxmax				->mode(quotemeta('max'));
	$suxmax				->verbose(quotemeta(0));
	$suxmax[1] 			= $suxmax->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suxmax[1], $in,
		  $data_in[1],
		  $go
		  );
	$flow[1] = $run->modules(\@items);


=head2 RUN FLOW(s) 


=cut

	$run->flow(\$flow[1]);



=head2 LOG FLOW(s)

	to screen and FILE

=cut

	print $flow[1];

	$log->file($flow[1]);


