# == Define: cron::cleanup
#
# Cleans up (removes) files not modified past a defined threshold within a directory.
# Also removes empty directories under the top-level directory.
#
# === Parameters:
#
# [*directory*]
#   The top-level directory from which stale files will be removed.
#
# [*last_modified_threshold*]
#   The threshold in days after which files will be deleted.
#
define cron::cleanup(
  $directory,
  $last_modified_threshold
) {
  $cron_name = "clean_up_${title}"
  $remove_stale_files_cmd = "find ${directory} -type f -mtime +${last_modified_threshold} | xargs rm -f | logger -i -t ${cron_name}"
  $remove_empty_directories_cmd = "find ${directory} -type d -empty -delete | logger -i -t ${cron_name}"
  cron { $cron_name:
    command => "${remove_stale_files_cmd} && ${remove_empty_directories_cmd}",
    user    => 'root',
    minute  => '0',
    hour    => '*/3'
  }
}
