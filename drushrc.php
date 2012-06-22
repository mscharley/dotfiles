<?php

// Example file available at: http://drush.ws/examples/example.drushrc.php

// Load a drushrc.php configuration file from the following locations.
$options['config'][] = rtrim(`git workdir`);
$options['config'][] = '.';

// Load more modules from the current directory as well.
$options['include'] = array('./drush');

