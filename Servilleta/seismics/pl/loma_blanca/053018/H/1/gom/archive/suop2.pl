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

	my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;

	use misc::message;
	use misc::flow;
	use sunix::suop2;
	use sunix::sugain;
	use sunix::suximage;

	my $log					= new message();
	my $run					= new flow();
	my $suop2				= new suop2();
	my $sugain				= new sugain();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@suop2);
	my (@sugain);
	my (@suximage);

=head2 Set up

	suop2 parameter values

=cut

	$suop2				->clear();
	$suop2				->file1(quotemeta($DATA_SEISMIC_SU.'/'.'61_clean'.$suffix_su));
	$suop2				->file2(quotemeta($DATA_SEISMIC_SU.'/'.'62_clean'.$suffix_su));
	$suop2				->op(quotemeta('diff'));
	$suop2[1] 			= $suop2->Step();

=head2 Set up

	sugain parameter values

=cut

	$sugain				->clear();
	$sugain				->agc(quotemeta(1));
	$sugain				->width_s(quotemeta(.1));
	$sugain				->tmpdir(quotemeta('/tmp'));
	$sugain[1] 			= $sugain->Step();

=head2 Set up

	suximage parameter values

=cut

	$suximage				->clear();
	$suximage				->absclip(quotemeta(1));
	$suximage				->loclip(quotemeta(0.01));
	$suximage				->hiclip(quotemeta(.2));
	$suximage				->cmap(quotemeta('hsv0'));
	$suximage				->dx(quotemeta(1.0));
	$suximage				->first_time_sample_value(quotemeta(0.0));
	$suximage				->gridcolor(quotemeta('blue'));
	$suximage				->labelcolor(quotemeta('blue'));
	$suximage				->labelfont(quotemeta('Erg14'));
	$suximage				->legend(quotemeta(1));
	$suximage				->legendfont(quotemeta('times_roman10'));
	$suximage				->lwidth(quotemeta(16));
	$suximage				->lx(quotemeta(3));
	$suximage				->picks(quotemeta('/dev/tty'));
	$suximage				->num_minor_ticks_betw_time_ticks(quotemeta(1));
	$suximage				->num_minor_ticks_betw_distance_ticks(quotemeta(1));
	$suximage				->percent4clip(quotemeta(100.0));
	$suximage				->plotfile(quotemeta('plotfile.ps'));
	$suximage				->orientation(quotemeta('seismic'));
	$suximage				->title(quotemeta('diff'));
	$suximage				->titlecolor(quotemeta('red'));
	$suximage				->titlefont(quotemeta('Rom22'));
	$suximage				->tmpdir(quotemeta('./'));
	$suximage				->tend_s(quotemeta(.5));
	$suximage				->units(quotemeta('unit'));
	$suximage				->verbose(quotemeta(1));
	$suximage				->windowtitle(quotemeta('suximage'));
	$suximage				->wperc(quotemeta(100.0));
	$suximage				->box_X0(quotemeta(800));
	$suximage				->box_Y0(quotemeta(500));
	$suximage				->box_width(quotemeta(550));
	$suximage				->box_height(quotemeta(550));
	$suximage[1] 			= $suximage->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suop2[1], $to,
		  $sugain[1], $to,
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


