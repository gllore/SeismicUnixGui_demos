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
	use Project;

	my $Project = new Project();

	use misc::message;
	use misc::flow;
	use misc::data_in;
	use sunix::sugain;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sugain				= new sugain();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sugain);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

	$data_in				->clear();
	$data_in				->base_file_name('60_clean');
	$data_in				->type('su');
	$data_in[1] 			= $data_in->Step();

=head2 Set up

	sugain parameter values

=cut

	$sugain				->clear();
	$sugain				->agc(1);
	$sugain				->width_s(.1);
	$sugain				->tmpdir('/tmp');
	$sugain[1] 			= $sugain->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->absclip(1);
	$suximage				->cmap('hsv1');
	$suximage				->dt(1.0);
	$suximage				->dx(1.0);
	$suximage				->first_time_sample_value(0.0);
	$suximage				->gridcolor('blue');
	$suximage				->labelcolor('blue');
	$suximage				->labelfont('Erg14');
	$suximage				->legendfont('times_roman10');
	$suximage				->lwidth(16);
	$suximage				->lx(3);
	$suximage				->picks('/dev/tty');
	$suximage				->num_minor_ticks_betw_time_ticks(1);
	$suximage				->num_minor_ticks_betw_distance_ticks(1);
	$suximage				->percent4clip(100.0);
	$suximage				->plotfile('plotfile.ps');
	$suximage				->orientation('seismic');
	$suximage				->title('suximage');
	$suximage				->titlecolor('red');
	$suximage				->titlefont('Rom22');
	$suximage				->tmpdir('./');
	$suximage				->units('unit');
	$suximage				->verbose(1);
	$suximage				->windowtitle('suximage');
	$suximage				->wperc(100.0);
	$suximage				->box_X0(500);
	$suximage				->box_Y0(500);
	$suximage				->box_width(550);
	$suximage				->box_height(550);
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sugain[1], $in,
		  $data_in[1], $to,
		  $suximage[1],
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


