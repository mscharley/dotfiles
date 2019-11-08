<?php

// Example file available at: http://drush.ws/examples/example.drushrc.php

// Load a drushrc.php configuration file from the following locations.
$git_workdir = rtrim(`git workdir 2> /dev/null`);
if (!empty($git_workdir)) { $options['config'][] = $git_workdir; }
$options['config'][] = '.';

// Load more modules from the current directory as well.
$options['include'] = array('./drush');

